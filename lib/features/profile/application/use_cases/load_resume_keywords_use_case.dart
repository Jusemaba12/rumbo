import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/profile/domain/entities/resume_keyword.dart';
import 'package:rumbo/features/profile/domain/repositories/resume_keywords_source.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'load_resume_keywords_use_case.g.dart';

/// Palabras clave de los cargos: las guardadas o, al pedirlas, con IA.
class LoadResumeKeywordsUseCase {
  const LoadResumeKeywordsUseCase({required this._source});

  final ResumeKeywordsSource? _source;

  /// Falso en modo local, donde no hay servidor.
  bool get isAvailable => _source != null;

  /// Las guardadas, sin gastar IA. Un fallo no molesta: sin la tabla o sin
  /// red, se piden al pulsar el botón.
  Future<KeywordsResult?> cached() async =>
      (await _source?.cached())?.valueOrNull;

  Future<Result<KeywordsResult>> call({bool force = false}) async =>
      await _source?.fetch(force: force) ??
      const Err<KeywordsResult>(BackendUnavailableFailure());
}

@Riverpod(keepAlive: true)
LoadResumeKeywordsUseCase loadResumeKeywordsUseCase(Ref ref) =>
    LoadResumeKeywordsUseCase(source: ref.watch(resumeKeywordsSourceProvider));
