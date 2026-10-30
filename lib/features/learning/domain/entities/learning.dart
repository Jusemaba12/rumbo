import 'package:freezed_annotation/freezed_annotation.dart';

part 'learning.freezed.dart';

enum LearningStatus { pending, learning, mastered }

/// Plan generado por la IA para aprender un tema.
@Freezed(fromJson: false, toJson: false)
abstract class LearningPlan with _$LearningPlan {
  const factory LearningPlan({
    required String why,
    required List<({String title, String detail})> steps,
    required List<({String title, String url, String kind})> resources,
    required String project,
    required int hours,
  }) = _LearningPlan;

  factory LearningPlan.fromJson(Map<String, dynamic> json) => LearningPlan(
    why: json['why'] as String? ?? '',
    steps: <({String detail, String title})>[
      for (final dynamic item
          in json['steps'] as List<dynamic>? ?? const <dynamic>[])
        (
          title: (item as Map<dynamic, dynamic>)['title'] as String? ?? '',
          detail: item['detail'] as String? ?? '',
        ),
    ],
    resources: <({String kind, String title, String url})>[
      for (final dynamic item
          in json['resources'] as List<dynamic>? ?? const <dynamic>[])
        (
          title: (item as Map<dynamic, dynamic>)['title'] as String? ?? '',
          url: item['url'] as String? ?? '',
          kind: item['kind'] as String? ?? 'docs',
        ),
    ],
    project: json['project'] as String? ?? '',
    hours: (json['hours'] as num?)?.toInt() ?? 0,
  );
}

@freezed
abstract class LearningTopic with _$LearningTopic {
  const factory LearningTopic({
    required String id,
    required String topic,
    @Default(LearningStatus.pending) LearningStatus status,

    /// En cuántas ofertas aparecía al añadirlo.
    @Default(0) int demand,
    LearningPlan? plan,
  }) = _LearningTopic;
}

/// Tema que conviene aprender: falta en la HV y lo piden las ofertas.
@freezed
abstract class LearningCandidate with _$LearningCandidate {
  const factory LearningCandidate({
    required String topic,

    /// En cuántas de las ofertas del usuario aparece.
    required int demand,

    /// La IA lo marcó como imprescindible para sus cargos.
    @Default(false) bool important,
  }) = _LearningCandidate;
}
