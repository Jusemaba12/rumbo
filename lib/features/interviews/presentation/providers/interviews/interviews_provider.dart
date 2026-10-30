import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/presentation/providers/applications/applications_provider.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/features/interviews/application/use_cases/delete_interview_use_case.dart';
import 'package:rumbo/features/interviews/application/use_cases/get_interviews_use_case.dart';
import 'package:rumbo/features/interviews/application/use_cases/save_interview_use_case.dart';
import 'package:rumbo/features/interviews/domain/entities/interview.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'interviews_provider.g.dart';

@Riverpod(keepAlive: true)
class InterviewsController extends _$InterviewsController {
  @override
  Future<List<Interview>> build() async {
    ref.watch(sessionChangesProvider);
    return (await ref.watch(getInterviewsUseCaseProvider)()).getOrThrow();
  }

  /// Guarda la entrevista y, si es nueva, avanza el estado del proceso.
  /// Devuelve el estado nuevo, o nulo si no cambió.
  Future<Result<ApplicationStatus?>> save({
    required Interview interview,
    required Application application,
  }) async {
    final Result<void> saved = await _thenReload(
      ref.read(saveInterviewUseCaseProvider)(interview),
    );
    if (!saved.isOk || interview.id.isNotEmpty) {
      return saved.map((_) => null);
    }
    final ApplicationStatus? next = statusForInterview(
      current: application.status,
      kind: interview.kind,
    );
    if (next == null) return const Ok<ApplicationStatus?>(null);
    final Result<void> changed = await ref
        .read(applicationsControllerProvider.notifier)
        .changeStatus(application: application, to: next);
    return changed.map((_) => next);
  }

  Future<Result<void>> delete(String id) =>
      _thenReload(ref.read(deleteInterviewUseCaseProvider)(id));

  Future<Result<void>> _thenReload(Future<Result<void>> action) async {
    final Result<void> result = await action;
    if (!result.isOk) return result;
    final Result<List<Interview>> interviews = await ref.read(
      getInterviewsUseCaseProvider,
    )();
    if (interviews case Ok<List<Interview>>(:final List<Interview> value)) {
      state = AsyncData<List<Interview>>(value);
    }
    return result;
  }
}
