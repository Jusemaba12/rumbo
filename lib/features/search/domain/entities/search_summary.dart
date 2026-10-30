import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_summary.freezed.dart';

/// Resultado de una búsqueda en los portales.
@Freezed(fromJson: false, toJson: false)
abstract class SearchSummary with _$SearchSummary {
  const factory SearchSummary({
    required int found,
    required int scored,
    required int suggested,
    @Default(<String>[]) List<String> failedSources,
  }) = _SearchSummary;

  factory SearchSummary.fromJson(Map<String, dynamic> json) => SearchSummary(
    found: json['found'] as int? ?? 0,
    scored: json['scored'] as int? ?? 0,
    suggested: json['suggested'] as int? ?? 0,
    failedSources: <String>[
      ...(json['failed_sources'] as List<dynamic>? ?? const <dynamic>[])
          .cast<String>(),
    ],
  );
}
