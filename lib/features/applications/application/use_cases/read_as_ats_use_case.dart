import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/domain/repositories/ats_reader.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'read_as_ats_use_case.g.dart';

/// Extrae el texto de un PDF como lo haría un ATS.
class ReadAsAtsUseCase {
  const ReadAsAtsUseCase({required this._reader});

  final AtsReader? _reader;

  /// Falso en modo local, donde no hay servidor.
  bool get isAvailable => _reader != null;

  Future<Result<AtsReading>> call(Uint8List pdf) async =>
      await _reader?.read(pdf) ??
      const Err<AtsReading>(BackendUnavailableFailure());
}

@Riverpod(keepAlive: true)
ReadAsAtsUseCase readAsAtsUseCase(Ref ref) =>
    ReadAsAtsUseCase(reader: ref.watch(atsReaderProvider));
