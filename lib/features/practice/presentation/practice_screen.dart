import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../answers/domain/saved_answer.dart';
import '../../answers/presentation/answers_controller.dart';
import '../data/interview_coach.dart';
import '../domain/practice.dart';

/// Simulador de entrevista para una oferta guardada.
class PracticeScreen extends ConsumerStatefulWidget {
  const PracticeScreen({super.key, required this.jobId});

  final String jobId;

  @override
  ConsumerState<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends ConsumerState<PracticeScreen> {
  var _mode = PracticeMode.mixed;
  var _language = PracticeLanguage.es;
  var _total = 5;
  bool _started = false;
  bool _waiting = false;
  CoachFailure? _failure;
  final _turns = <PracticeTurn>[];
  String? _question;
  PracticeSummary? _summary;
  final _answer = TextEditingController();
  final _scroll = ScrollController();

  @override
  void dispose() {
    _answer.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _ask() async {
    final coach = ref.read(interviewCoachProvider);
    if (coach == null) return;
    setState(() {
      _waiting = true;
      _failure = null;
    });
    try {
      final reply = await coach.next(
        jobId: widget.jobId,
        mode: _mode,
        language: _language,
        totalQuestions: _total,
        turns: _turns,
      );
      if (!mounted) return;
      setState(() {
        if (reply.feedback != null && _turns.isNotEmpty) {
          _turns.last = _turns.last.copyWith(feedback: reply.feedback);
        }
        _question = reply.nextQuestion;
        _summary = reply.summary;
      });
      _scrollToEnd();
    } on CoachException catch (error) {
      if (mounted) setState(() => _failure = error.reason);
    } catch (_) {
      if (mounted) setState(() => _failure = CoachFailure.other);
    } finally {
      if (mounted) setState(() => _waiting = false);
    }
  }

  void _start() {
    setState(() => _started = true);
    _ask();
  }

  void _send() {
    final answer = _answer.text.trim();
    final question = _question;
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
    final l10n = AppLocalizations.of(context);
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
      children: [
        Text(l10n.practiceIntro),
        label(l10n.practiceMode),
        SegmentedButton<PracticeMode>(
          segments: [
            ButtonSegment(
              value: PracticeMode.technical,
              label: Text(l10n.modeTechnical),
            ),
            ButtonSegment(
              value: PracticeMode.behavioral,
              label: Text(l10n.modeBehavioral),
            ),
            ButtonSegment(
              value: PracticeMode.mixed,
              label: Text(l10n.modeMixed),
            ),
          ],
          selected: {_mode},
          onSelectionChanged: (s) => setState(() => _mode = s.first),
        ),
        label(l10n.practiceLanguage),
        SegmentedButton<PracticeLanguage>(
          segments: [
            ButtonSegment(
              value: PracticeLanguage.es,
              label: Text(l10n.languageEs),
            ),
            ButtonSegment(
              value: PracticeLanguage.en,
              label: Text(l10n.languageEn),
            ),
          ],
          selected: {_language},
          onSelectionChanged: (s) => setState(() => _language = s.first),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          children: [
            for (final count in const [3, 5, 8])
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
    final theme = Theme.of(context);
    final question = _question;
    final summary = _summary;
    final failure = _failure;
    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: _scroll,
            padding: const EdgeInsets.all(16),
            children: [
              for (final (index, turn) in _turns.indexed) ...[
                _QuestionBubble(
                  label: l10n.practiceQuestion(index + 1, _total),
                  text: turn.question,
                ),
                _AnswerBubble(text: turn.answer),
                if (turn.feedback case final feedback?)
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
                    children: [
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
                    children: [
                      Text(switch (failure) {
                        CoachFailure.dailyLimit => l10n.aiErrorDailyLimit,
                        CoachFailure.rateLimited => l10n.aiErrorRateLimited,
                        CoachFailure.busy => l10n.aiErrorBusy,
                        CoachFailure.other => l10n.practiceError,
                      }, style: TextStyle(color: theme.colorScheme.error)),
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
              children: [
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
                ValueListenableBuilder(
                  valueListenable: _answer,
                  builder: (context, value, _) => IconButton.filled(
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
    final theme = Theme.of(context);
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
          children: [
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
    final theme = Theme.of(context);
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
        children: [
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
    final color = Theme.of(context).colorScheme.primary;
    return Semantics(
      label: AppLocalizations.of(context).practiceScore(score),
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 1; i <= 5; i++)
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
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(feedback.betterAnswer),
                  ),
                  Wrap(
                    alignment: WrapAlignment.end,
                    children: [
                      TextButton.icon(
                        key: const Key('saveToBank'),
                        onPressed: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          try {
                            await ref
                                .read(answersControllerProvider.notifier)
                                .save(
                                  SavedAnswer(
                                    question: question,
                                    answer: feedback.betterAnswer,
                                  ),
                                );
                            messenger.showSnackBar(
                              SnackBar(content: Text(l10n.answerSavedToBank)),
                            );
                          } catch (_) {
                            messenger.showSnackBar(
                              SnackBar(content: Text(l10n.saveError)),
                            );
                          }
                        },
                        icon: const Icon(Icons.bookmark_add_outlined, size: 18),
                        label: Text(l10n.answerSaveToBank),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          final messenger = ScaffoldMessenger.of(context);
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
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.secondaryContainer,
      margin: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
