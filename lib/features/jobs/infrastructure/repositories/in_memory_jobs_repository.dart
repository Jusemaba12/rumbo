import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:uuid/uuid.dart';

/// Guarda las ofertas solo mientras la app está abierta (modo local y tests).
class InMemoryJobsRepository implements JobsRepository {
  InMemoryJobsRepository([List<SavedJob> initial = const <SavedJob>[]])
    : _items = <SavedJob>[...initial];

  static const Uuid _uuid = Uuid();

  final List<SavedJob> _items;

  @override
  Future<Result<List<SavedJob>>> list() async => Ok<List<SavedJob>>(
    <SavedJob>[..._items]..sort(
      (SavedJob a, SavedJob b) => (b.job.createdAt ?? DateTime(0)).compareTo(
        a.job.createdAt ?? DateTime(0),
      ),
    ),
  );

  @override
  Future<Result<void>> save(SavedJob saved) async {
    if (_items.any(
      (SavedJob item) => item.job.dedupeKey == saved.job.dedupeKey,
    )) {
      return const Err<void>(DuplicateFailure());
    }
    _items.add(
      saved.copyWith(
        job: saved.job.copyWith(id: _uuid.v4(), createdAt: DateTime.now()),
      ),
    );
    return ok;
  }

  @override
  Future<Result<void>> delete(String jobId) async {
    _items.removeWhere((SavedJob item) => item.job.id == jobId);
    return ok;
  }

  @override
  Future<Result<void>> keepSuggestion(String jobId) async => _update(
    jobId: jobId,
    change: (Job job) => job.copyWith(discovered: false),
  );

  @override
  Future<Result<void>> dismissSuggestion(String jobId) async =>
      _update(jobId: jobId, change: (Job job) => job.copyWith(dismissed: true));

  @override
  Future<Result<void>> restoreSuggestion(String jobId) async => _update(
    jobId: jobId,
    change: (Job job) => job.copyWith(dismissed: false),
  );

  @override
  Future<Result<void>> updateContact(Job job) async => _update(
    jobId: job.id,
    change: (Job current) => current.copyWith(
      recruiterName: job.recruiterName,
      recruiterEmail: job.recruiterEmail,
      recruiterLinkedin: job.recruiterLinkedin,
      applyMethod: job.applyMethod,
      applySubject: job.applySubject,
      asksSalary: job.asksSalary,
    ),
  );

  @override
  Future<Result<void>> complete(SavedJob saved) async {
    final int index = _items.indexWhere(
      (SavedJob item) => item.job.id == saved.job.id,
    );
    if (index != -1) _items[index] = saved;
    return ok;
  }

  Result<void> _update({
    required String jobId,
    required Job Function(Job job) change,
  }) {
    final int index = _items.indexWhere(
      (SavedJob item) => item.job.id == jobId,
    );
    if (index != -1) {
      _items[index] = _items[index].copyWith(job: change(_items[index].job));
    }
    return ok;
  }
}
