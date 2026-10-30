import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Refreshable;
import 'package:rumbo/features/answers/domain/entities/saved_answer.dart';
import 'package:rumbo/features/answers/presentation/providers/answers/answers_provider.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/form_helpers.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';
import 'package:rumbo/shared/presentation/widgets/pull_to_refresh.dart';

List<String> commonQuestions(AppLocalizations l10n) => <String>[
  l10n.commonAboutYou,
  l10n.commonWhyCompany,
  l10n.commonSalary,
  l10n.commonWhyLeave,
  l10n.commonChallenge,
  l10n.commonWeakness,
  l10n.commonConflict,
];

Future<void> copyAnswer(BuildContext context, String text) async {
  final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
  final String done = context.l10n.answerCopied;
  await Clipboard.setData(ClipboardData(text: text));
  messenger.showSnackBar(SnackBar(content: Text(done)));
}

class AnswersScreen extends ConsumerWidget {
  const AnswersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final List<SavedAnswer>? answers = ref
        .watch(answersControllerProvider)
        .value;
    final Set<String> asked = <String>{
      for (final SavedAnswer a in answers ?? <SavedAnswer>[]) a.question,
    };
    final List<String> suggestions = commonQuestions(l10n)
        .where((String q) => !asked.contains(q))
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.answersTitle)),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('addAnswer'),
        onPressed: () => const AnswerNewRoute().push(context),
        icon: const Icon(Icons.add),
        label: Text(l10n.answersAdd),
      ),
      body: answers == null
          ? const Center(child: CircularProgressIndicator())
          : PullToRefresh(
              providers: <Refreshable<Future<Object?>>>[
                answersControllerProvider.future,
              ],
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 96),
                children: <Widget>[
                  Text(
                    l10n.answersIntro,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final SavedAnswer answer in answers)
                    Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(answer.question),
                        subtitle: Text(
                          answer.answer,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          tooltip: l10n.answerCopy,
                          icon: const Icon(Icons.copy),
                          onPressed: () => copyAnswer(context, answer.answer),
                        ),
                        onTap: () =>
                            AnswerEditRoute(id: answer.id).push(context),
                      ),
                    ),
                  if (suggestions.isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    Text(l10n.answersEmpty, style: theme.textTheme.titleSmall),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        for (final String question in suggestions)
                          ActionChip(
                            label: Text(question),
                            onPressed: () =>
                                AnswerNewRoute($extra: question).push(context),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}

class AnswerFormScreen extends ConsumerStatefulWidget {
  const AnswerFormScreen({super.key, this.answerId, this.initialQuestion});

  final String? answerId;
  final String? initialQuestion;

  @override
  ConsumerState<AnswerFormScreen> createState() => _AnswerFormScreenState();
}

class _AnswerFormScreenState extends ConsumerState<AnswerFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SavedAnswer? _initial;
  late final TextEditingController _question;
  late final TextEditingController _answer;

  @override
  void initState() {
    super.initState();
    _initial = ref
        .read(answersControllerProvider)
        .value
        ?.firstWhereOrNull((SavedAnswer a) => a.id == widget.answerId);
    _question = TextEditingController(
      text: _initial?.question ?? widget.initialQuestion,
    );
    _answer = TextEditingController(text: _initial?.answer);
  }

  @override
  void dispose() {
    _question.dispose();
    _answer.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    saveAndClose(
      context,
      () => ref
          .read(answersControllerProvider.notifier)
          .save(
            SavedAnswer(
              id: _initial?.id ?? '',
              question: _question.text.trim(),
              answer: _answer.text.trim(),
            ),
          ),
    );
  }

  Future<void> _delete() async {
    final SavedAnswer initial = _initial!;
    if (!await confirmDelete(context, initial.question)) return;
    if (!mounted) return;
    await saveAndClose(
      context,
      () => ref.read(answersControllerProvider.notifier).delete(initial.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return ProfileFormScaffold(
      title: _initial == null ? l10n.answerNew : l10n.answerEdit,
      formKey: _formKey,
      onSave: _save,
      onDelete: _initial == null ? null : _delete,
      children: <Widget>[
        TextFormField(
          key: const Key('answerQuestion'),
          controller: _question,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(labelText: l10n.answerQuestion),
          validator: (String? value) => requiredValidator(context, value),
        ),
        TextFormField(
          key: const Key('answerText'),
          controller: _answer,
          minLines: 6,
          maxLines: 20,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: l10n.answerText,
            alignLabelWithHint: true,
          ),
          validator: (String? value) => requiredValidator(context, value),
        ),
      ],
    );
  }
}
