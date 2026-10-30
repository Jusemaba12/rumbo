import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/app.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/failures/profile_failures.dart';
import 'package:rumbo/features/profile/domain/repositories/resume_importer.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/features/profile/infrastructure/repositories/in_memory_profile_repository.dart';
import 'package:rumbo/features/profile/infrastructure/services/pdf_picker.dart';
import 'package:rumbo/shared/domain/result.dart';

class _FakeImporter implements ResumeImporter {
  _FakeImporter(this.result);

  final Future<Result<ProfileData>> Function() result;

  @override
  Future<Result<ProfileData>> extract(Uint8List pdf) => result();
}

Future<InMemoryProfileRepository> _openImport(
  WidgetTester tester,
  ResumeImporter importer,
) async {
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);

  final InMemoryProfileRepository repository = InMemoryProfileRepository(
    const ProfileData(profile: Profile(fullName: 'Juan')),
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        authRepositoryProvider.overrideWithValue(const LocalAuthRepository()),
        profileRepositoryProvider.overrideWithValue(repository),
        resumeImporterProvider.overrideWithValue(importer),
        pdfPickerProvider.overrideWithValue(
          () async => Uint8List.fromList(<int>[1, 2, 3]),
        ),
      ],
      child: const RumboApp(locale: Locale('es')),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('HV'));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('importResume')));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Elegir PDF'));
  await tester.pumpAndSettle();
  return repository;
}

void main() {
  testWidgets('muestra lo extraído y lo añade al perfil al confirmar', (
    WidgetTester tester,
  ) async {
    final InMemoryProfileRepository repository = await _openImport(
      tester,
      _FakeImporter(
        () async => Ok<ProfileData>(
          ProfileData(
            profile: const Profile(
              fullName: 'Juan Manzano',
              headline: 'Desarrollador Flutter',
            ),
            experiences: <Experience>[
              Experience(
                company: 'Acme',
                role: 'Flutter Developer',
                startDate: DateTime(2022),
              ),
            ],
            skills: const <Skill>[
              Skill(name: 'Dart'),
              Skill(name: 'Riverpod'),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Esto se añadirá a tu perfil'), findsOneWidget);
    expect(find.text('Titular: Desarrollador Flutter'), findsOneWidget);
    expect(find.textContaining('Nombre completo'), findsNothing);
    expect(find.text('Flutter Developer · Acme'), findsOneWidget);
    expect(find.text('Dart, Riverpod'), findsOneWidget);
    expect((await repository.load()).getOrThrow().skills, isEmpty);

    await tester.tap(find.text('Añadir a mi perfil'));
    await tester.pumpAndSettle();

    final ProfileData saved = (await repository.load()).getOrThrow();
    expect(saved.profile.fullName, 'Juan');
    expect(saved.profile.headline, 'Desarrollador Flutter');
    expect(saved.experiences.single.company, 'Acme');
    expect(saved.skills.map((Skill s) => s.name), <String>['Dart', 'Riverpod']);
    expect(find.text('Perfil actualizado con tu HV.'), findsOneWidget);
    expect(find.text('Tu perfil'), findsOneWidget);
  });

  testWidgets('explica el error si el PDF no se puede leer', (
    WidgetTester tester,
  ) async {
    await _openImport(
      tester,
      _FakeImporter(
        () async => const Err<ProfileData>(UnreadableFileFailure()),
      ),
    );

    expect(find.textContaining('No se pudo leer el PDF'), findsOneWidget);
    expect(find.text('Elegir otro PDF'), findsOneWidget);
  });
}
