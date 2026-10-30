import 'package:rumbo/features/learning/domain/entities/learning.dart';

LearningTopic learningTopicFromRow(Map<String, dynamic> row) => LearningTopic(
  id: row['id'] as String,
  topic: row['topic'] as String,
  status:
      LearningStatus.values.asNameMap()[row['status']] ??
      LearningStatus.pending,
  demand: row['demand'] as int? ?? 0,
  plan: row['plan'] is Map
      ? LearningPlan.fromJson(
          (row['plan'] as Map<dynamic, dynamic>).cast<String, dynamic>(),
        )
      : null,
);
