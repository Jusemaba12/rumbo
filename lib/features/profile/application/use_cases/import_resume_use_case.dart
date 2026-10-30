import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/repositories/resume_importer.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'import_resume_use_case.g.dart';

/// Lee una HV en PDF con IA, sin guardar nada: el usuario revisa antes.
class ImportResumeUseCase {
  const ImportResumeUseCase({required this._importer});

  final ResumeImporter? _importer;

  /// Falso en modo local, donde no hay IA.
  bool get isAvailable => _importer != null;

  Future<Result<ProfileData>> call(Uint8List pdf) async =>
      await _importer?.extract(pdf) ??
      const Err<ProfileData>(BackendUnavailableFailure());
}

@Riverpod(keepAlive: true)
ImportResumeUseCase importResumeUseCase(Ref ref) =>
    ImportResumeUseCase(importer: ref.watch(resumeImporterProvider));
