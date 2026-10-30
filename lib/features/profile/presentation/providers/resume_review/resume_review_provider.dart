import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/repositories/review_history_store.dart';
import 'package:rumbo/features/profile/domain/services/resume_review.dart';
import 'package:rumbo/features/profile/domain/services/review_history.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/features/profile/presentation/providers/profile/profile_provider.dart';
import 'package:rumbo/features/search/presentation/providers/search/search_provider.dart';
import 'package:rumbo/shared/application/services/clock.dart';

part 'resume_review_provider.g.dart';

/// Revisión ATS de la HV base con los cargos de las preferencias; nula
/// mientras carga el perfil.
@Riverpod(keepAlive: true)
ResumeReview? resumeReview(Ref ref) {
  final ProfileData? data = ref.watch(profileControllerProvider).value;
  if (data == null) return null;
  return reviewResume(
    data,
    targetRoles:
        ref.watch(searchPreferencesProvider).value?.roles ?? const <String>[],
    now: ref.watch(clockProvider)(),
  );
}

/// Historial de la nota; se actualiza al cambiar la nota.
@Riverpod(keepAlive: true)
class ReviewHistory extends _$ReviewHistory {
  @override
  Future<List<ScorePoint>> build() async {
    final int? score = ref.watch(resumeReviewProvider)?.score;
    final ReviewHistoryStore store = ref.read(reviewHistoryStoreProvider);
    if (score == null) return store.load();
    return store.record(score: score, now: ref.read(clockProvider)());
  }
}
