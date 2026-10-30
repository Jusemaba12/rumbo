import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rumbo/features/answers/presentation/screens/answers_screen.dart'
    show copyAnswer;
import 'package:rumbo/features/offers/application/use_cases/draft_negotiation_use_case.dart';
import 'package:rumbo/features/offers/domain/entities/negotiation_draft.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';

class NegotiationScreen extends ConsumerStatefulWidget {
  const NegotiationScreen({super.key, required this.applicationId});

  final String applicationId;

  @override
  ConsumerState<NegotiationScreen> createState() => _NegotiationScreenState();
}

class _NegotiationScreenState extends ConsumerState<NegotiationScreen> {
  final TextEditingController _target = TextEditingController();
  final TextEditingController _priorities = TextEditingController();
  bool _english = false;
  bool _busy = false;
  bool _failed = false;
  NegotiationDraft? _draft;

  @override
  void dispose() {
    _target.dispose();
    _priorities.dispose();
    super.dispose();
  }

  Future<void> _generate() async {
    final DraftNegotiationUseCase draftNegotiation = ref.read(
      draftNegotiationUseCaseProvider,
    );
    if (!draftNegotiation.isAvailable) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _failed = false;
    });
    final Result<NegotiationDraft> result = await draftNegotiation(
      applicationId: widget.applicationId,
      targetSalary: double.tryParse(_target.text.trim()),
      priorities: _priorities.text.trim(),
      language: _english ? 'en' : 'es',
    );
    if (!mounted) return;
    setState(() {
      _busy = false;
      _draft = result.valueOrNull ?? _draft;
      _failed = !result.isOk;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final NegotiationDraft? draft = _draft;
    Widget points(String title, List<String> items) => items.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: AppTheme.sectionTitle(context)),
                for (final String item in items)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text('•  $item'),
                  ),
              ],
            ),
          );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.negotiateTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        children: <Widget>[
          Text(l10n.negotiateIntro),
          const SizedBox(height: 16),
          TextField(
            key: const Key('negotiateTarget'),
            controller: _target,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              labelText: l10n.negotiateTarget,
              helperText: l10n.negotiateTargetHelper,
              helperMaxLines: 2,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _priorities,
            minLines: 2,
            maxLines: 4,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l10n.negotiatePriorities,
              hintText: l10n.negotiatePrioritiesHint,
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.negotiateEnglish),
            value: _english,
            onChanged: (bool value) => setState(() => _english = value),
          ),
          const SizedBox(height: 8),
          FilledButton(
            key: const Key('generateNegotiation'),
            onPressed: _busy ? null : _generate,
            child: Text(
              _busy ? l10n.negotiateGenerating : l10n.negotiateGenerate,
            ),
          ),
          if (_failed)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                l10n.negotiateError,
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),
          if (draft != null) ...<Widget>[
            const SizedBox(height: 24),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    l10n.negotiateEmail,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => copyAnswer(context, draft.email),
                  icon: const Icon(Icons.copy, size: 18),
                  label: Text(l10n.answerCopy),
                ),
              ],
            ),
            const SizedBox(height: 4),
            SelectableText(draft.email),
            points(l10n.negotiatePoints, draft.talkingPoints),
            points(l10n.negotiateRisks, draft.risks),
          ],
        ],
      ),
    );
  }
}
