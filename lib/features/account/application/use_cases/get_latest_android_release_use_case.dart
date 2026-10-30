import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/account/domain/entities/app_release.dart';
import 'package:rumbo/features/account/domain/repositories/account_repository.dart';
import 'package:rumbo/features/account/infrastructure/di/account_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'get_latest_android_release_use_case.g.dart';

/// La versión más reciente publicada para Android, si hay.
class GetLatestAndroidReleaseUseCase {
  const GetLatestAndroidReleaseUseCase({required this._repository});

  final AccountRepository _repository;

  Future<Result<AppRelease?>> call() => _repository.latestAndroidRelease();
}

@Riverpod(keepAlive: true)
GetLatestAndroidReleaseUseCase getLatestAndroidReleaseUseCase(Ref ref) =>
    GetLatestAndroidReleaseUseCase(
      repository: ref.watch(accountRepositoryProvider),
    );
