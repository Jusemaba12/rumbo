import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/answers/domain/entities/saved_answer.dart';
import 'package:rumbo/features/answers/presentation/providers/answers/answers_provider.dart';
import 'package:rumbo/features/practice/application/use_cases/next_practice_turn_use_case.dart';
import 'package:rumbo/features/practice/domain/entities/practice.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/failure_message.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';

/// Simulador de entrevista para una oferta guardada.
class PracticeScreen extends ConsumerStatefulWidget {
  const PracticeScreen({super.key, required this.jobId});

  final String jobId;

  @override
  ConsumerState<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends ConsumerState<PracticeScreen> {
  PracticeMode _mode = PracticeMode.mixed;
  PracticeLanguage _language = PracticeLanguage.es;
  int _total = 5;
  bool _started = false;
  bool _waiting = false;
  Failure? _failure;
  final List<PracticeTurn> _turns = <PracticeTurn>[];
  String? _question;
  PracticeSummary? _summary;
  final TextEditingController _answer = TextEditingController();
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _answer.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _ask() async {
    final NextPracticeTurnUseCase nextTurn = ref.read(
      nextPracticeTurnUseCaseProvider,
    );
    if (!nextTurn.isAvailable) return;
    setState(() {
      _waiting = true;
      _failure = null;
    });
    final Result<CoachReply> result = await nextTurn(
      jobId: widget.jobId,
      mode: _mode,
      language: _language,
      totalQuestions: _total,
      turns: _turns,
    );
    if (!mounted) return;
    final CoachReply? reply = result.valueOrNull;
    setState(() {
      _waiting = false;
      _failure = result.failureOrNull;
      if (reply != null) {
        if (reply.feedback != null && _turns.isNotEmpty) {
          _turns.last = _turns.last.copyWith(feedback: reply.feedback);
        }
        _question = reply.nextQuestion;
        _summary = reply.summary;
      }
    });
    if (reply != null) _scrollToEnd();
  }

  void _start() {
    setState(() => _started = true);
    _ask();
  }

  void _send() {
    final String answer = _answer.text.trim();
    final String? question = _question;
    if (question == null || answer.isEmpty) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _turns.add(PracticeTurn(question: question, answer: answer));
      _question = null;
      _answer.clear();
    });
    _ask();
  }

  void _restart() => setState(() {
    _started = false;
    _turns.clear();
    _question = null;
    _summary = null;
    _failure = null;
  });

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.practiceTitle)),
      body: SafeArea(child: _started ? _session(l10n) : _setup(l10n)),
    );
  }

  Widget _setup(AppLocalizations l10n) {
    Widget label(String text) => Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(text, style: AppTheme.sectionTitle(context)),
    );
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text(l10n.practiceIntro),
        label(l10n.practiceMode),
        SegmentedButton<PracticeMode>(
          segments: <ButtonSegment<PracticeMode>>[
            ButtonSegment<PracticeMode>(
              value: PracticeMode.technical,
              label: Text(l10n.modeTechnical),
            ),
            ButtonSegment<PracticeMode>(
              value: PracticeMode.behavioral,
              label: Text(l10n.modeBehavioral),
            ),
            ButtonSegment<PracticeMode>(
              value: PracticeMode.mixed,
              label: Text(l10n.modeMixed),
            ),
          ],
          selected: <PracticeMode>{_mode},
          onSelectionChanged: (Set<PracticeMode> s) =>
              setState(() => _mode = s.first),
        ),
        label(l10n.practiceLanguage),
        SegmentedButton<PracticeLanguage>(
          segments: <ButtonSegment<PracticeLanguage>>[
            ButtonSegment<PracticeLanguage>(
              value: PracticeLanguage.es,
              label: Text(l10n.languageEs),
            ),
            ButtonSegment<PracticeLanguage>(
              value: PracticeLanguage.en,
              label: Text(l10n.languageEn),
            ),
          ],
          selected: <PracticeLanguage>{_language},
          onSelectionChanged: (Set<PracticeLanguage> s) =>
              setState(() => _language = s.first),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          children: <Widget>[
            for (final int count in const <int>[3, 5, 8])
              ChoiceChip(
                label: Text(l10n.practiceCount(count)),
                selected: _total == count,
                onSelected: (_) => setState(() => _total = count),
              ),
          ],
        ),
        const SizedBox(height: 28),
        FilledButton(
          key: const Key('startPractice'),
          onPressed: _start,
          child: Text(l10n.practiceStart),
        ),
      ],
    );
  }

  Widget _session(AppLocalizations l10n) {
    final ThemeData theme = Theme.of(context);
    final String? question = _question;
    final PracticeSummary? summary = _summary;
    final Failure? failure = _failure;
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            controller: _scroll,
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              for (final (int index, PracticeTurn turn)
                  in _turns.indexed) ...<Widget>[
                _QuestionBubble(
                  label: l10n.practiceQuestion(index + 1, _total),
                  text: turn.question,
                ),
                _AnswerBubble(text: turn.answer),
                if (turn.feedback case final AnswerFeedback feedback?)
                  _FeedbackCard(question: turn.question, feedback: feedback),
              ],
              if (question != null)
                _QuestionBubble(
                  label: l10n.practiceQuestion(_turns.length + 1, _total),
                  text: question,
                ),
              if (_waiting)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: <Widget>[
                      const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      const SizedBox(width: 12),
                      Text(l10n.practiceThinking),
                    ],
                  ),
                ),
              if (failure != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        failureMessage(
                          l10n: l10n,
                          failure: failure,
                          fallback: l10n.practiceError,
                        ),
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                      TextButton(
                        onPressed: _ask,
                        child: Text(l10n.practiceRetry),
                      ),
                    ],
                  ),
                ),
              if (summary != null)
                _SummaryCard(summary: summary, onRestart: _restart),
            ],
          ),
        ),
        if (question != null && !_waiting)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    key: const Key('practiceAnswer'),
                    controller: _answer,
                    minLines: 1,
                    maxLines: 6,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: l10n.practiceAnswerHint,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Solo se puede enviar con algo escrito.
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _answer,
                  builder: (BuildContext context, TextEditingValue value, _) =>
                      IconButton.filled(
                        key: const Key('sendAnswer'),
                        tooltip: l10n.practiceSend,
                        onPressed: value.text.trim().isEmpty ? null : _send,
                        icon: const Icon(Icons.send),
                      ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _QuestionBubble extends StatelessWidget {
  const _QuestionBubble({required this.label, required this.text});

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 40),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.colors.surface,
          border: Border.all(color: context.colors.line),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(18),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label, style: AppTheme.overline(context)),
            const SizedBox(height: 4),
            Text(text, style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _AnswerBubble extends StatelessWidget {
  const _AnswerBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 40),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(6),
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
          ),
        ),
      ),
    );
  }
}

class _Points extends StatelessWidget {
  const _Points({
    required this.title,
    required this.items,
    required this.icon,
    required this.color,
  });

  final String title;
  final List<String> items;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          for (final String item in items)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(icon, size: 16, color: color),
                  const SizedBox(width: 6),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Score extends StatelessWidget {
  const _Score({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.primary;
    return Semantics(
      label: context.l10n.practiceScore(score),
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (int i = 1; i <= 5; i++)
            Icon(
              i <= score ? Icons.star : Icons.star_border,
              size: 18,
              color: color,
            ),
        ],
      ),
    );
  }
}

class _FeedbackCard extends ConsumerWidget {
  const _FeedbackCard({required this.question, required this.feedback});

  final String question;
  final AnswerFeedback feedback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _Score(score: feedback.score),
            _Points(
              title: l10n.practiceStrengths,
              items: feedback.strengths,
              icon: Icons.check_circle_outline,
              color: scheme.primary,
            ),
            _Points(
              title: l10n.practiceImprove,
              items: feedback.improve,
              icon: Icons.trending_up,
              color: scheme.tertiary,
            ),
            if (feedback.betterAnswer.isNotEmpty)
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(l10n.practiceBetter),
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(feedback.betterAnswer),
                  ),
                  Wrap(
                    alignment: WrapAlignment.end,
                    children: <Widget>[
                      TextButton.icon(
                        key: const Key('saveToBank'),
                        onPressed: () async {
                          final ScaffoldMessengerState messenger =
                              ScaffoldMessenger.of(context);
                          showResultSnackBar(
                            messenger: messenger,
                            l10n: l10n,
                            result: await ref
                                .read(answersControllerProvider.notifier)
                                .save(
                                  SavedAnswer(
                                    question: question,
                                    answer: feedback.betterAnswer,
                                  ),
                                ),
                            success: l10n.answerSavedToBank,
                          );
                        },
                        icon: const Icon(Icons.bookmark_add_outlined, size: 18),
                        label: Text(l10n.answerSaveToBank),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          final ScaffoldMessengerState messenger =
                              ScaffoldMessenger.of(context);
                          await Clipboard.setData(
                            ClipboardData(text: feedback.betterAnswer),
                          );
                          messenger.showSnackBar(
                            SnackBar(content: Text(l10n.practiceCopied)),
                          );
                        },
                        icon: const Icon(Icons.copy, size: 18),
                        label: Text(l10n.practiceCopy),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.summary, required this.onRestart});

  final PracticeSummary summary;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.secondaryContainer,
      margin: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(l10n.practiceSummary, style: theme.textTheme.titleMedium),
            const SizedBox(height: 6),
            _Score(score: summary.score),
            const SizedBox(height: 8),
            Text(summary.overall),
            _Points(
              title: l10n.practiceStrengths,
              items: summary.strengths,
              icon: Icons.check_circle_outline,
              color: theme.colorScheme.primary,
            ),
            _Points(
              title: l10n.practiceImprove,
              items: summary.improve,
              icon: Icons.trending_up,
              color: theme.colorScheme.tertiary,
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              key: const Key('practiceAgain'),
              onPressed: onRestart,
              child: Text(l10n.practiceAgain),
            ),
          ],
        ),
      ),
    );
  }
}
