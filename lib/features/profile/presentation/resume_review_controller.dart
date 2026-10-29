import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/time/clock.dart';
import '../../search/presentation/search_controller.dart';
import '../data/review_history.dart';
import '../domain/resume_review.dart';
import 'profile_controller.dart';

part 'resume_review_controller.g.dart';

/// Revisión ATS de la HV base con los cargos de las preferencias; nula
/// mientras carga el perfil.
@Riverpod(keepAlive: true)
ResumeReview? resumeReview(Ref ref) {
  final data = ref.watch(profileControllerProvider).value;
  if (data == null) return null;
  return reviewResume(
    data,
    targetRoles: ref.watch(searchPreferencesProvider).value?.roles ?? const [],
    now: ref.watch(clockProvider)(),
  );
}

/// Historial de la nota; se actualiza al cambiar la nota.
@Riverpod(keepAlive: true)
class ReviewHistory extends _$ReviewHistory {
  @override
  Future<List<ScorePoint>> build() async {
    final score = ref.watch(resumeReviewProvider)?.score;
    final store = ref.read(reviewHistoryStoreProvider);
    if (score == null) return store.load();
    return store.record(score, ref.read(clockProvider)());
  }
}
