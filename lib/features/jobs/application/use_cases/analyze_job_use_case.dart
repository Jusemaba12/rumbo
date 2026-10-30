import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/domain/repositories/job_analyzer.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'analyze_job_use_case.g.dart';

/// Analiza el enlace o el texto de una oferta con IA, sin guardarla.
class AnalyzeJobUseCase {
  const AnalyzeJobUseCase({required this._analyzer});

  final JobAnalyzer? _analyzer;

  /// Falso en modo local, donde no hay IA.
  bool get isAvailable => _analyzer != null;

  Future<Result<SavedJob>> call({String? url, String? text}) async {
    final JobAnalyzer? analyzer = _analyzer;
    if (analyzer == null) {
      return const Err<SavedJob>(BackendUnavailableFailure());
    }
    return analyzer.analyze(url: _blankToNull(url), text: _blankToNull(text));
  }

  String? _blankToNull(String? value) {
    final String? trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}

@Riverpod(keepAlive: true)
AnalyzeJobUseCase analyzeJobUseCase(Ref ref) =>
    AnalyzeJobUseCase(analyzer: ref.watch(jobAnalyzerProvider));
