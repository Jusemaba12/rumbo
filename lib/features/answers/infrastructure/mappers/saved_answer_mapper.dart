import 'package:rumbo/features/answers/domain/entities/saved_answer.dart';

SavedAnswer savedAnswerFromRow(Map<String, dynamic> row) => SavedAnswer(
  id: row['id'] as String,
  question: row['question'] as String,
  answer: row['answer'] as String? ?? '',
  updatedAt: DateTime.parse(row['updated_at'] as String).toLocal(),
);

Map<String, String> savedAnswerToRow(SavedAnswer answer) => <String, String>{
  'question': answer.question,
  'answer': answer.answer,
};
