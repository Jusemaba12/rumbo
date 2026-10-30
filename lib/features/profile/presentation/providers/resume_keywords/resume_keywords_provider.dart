import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/profile/application/use_cases/load_resume_keywords_use_case.dart';
import 'package:rumbo/features/profile/domain/entities/resume_keyword.dart';

part 'resume_keywords_provider.g.dart';

/// Palabras clave de los cargos: al abrir se leen las guardadas (sin gastar
/// IA); el botón las pide o las vuelve a generar.
@Riverpod(keepAlive: true)
class ResumeKeywords extends _$ResumeKeywords {
  @override
  Future<KeywordsResult?> build() =>
      ref.watch(loadResumeKeywordsUseCaseProvider).cached();

  Future<void> load({bool force = false}) async {
    final LoadResumeKeywordsUseCase loadKeywords = ref.read(
      loadResumeKeywordsUseCaseProvider,
    );
    if (!loadKeywords.isAvailable) return;
    state = const AsyncLoading<KeywordsResult?>();
    state = await AsyncValue.guard(
      () async => (await loadKeywords(force: force)).getOrThrow(),
    );
  }
}
