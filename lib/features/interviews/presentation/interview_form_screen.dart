import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/time/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../../applications/presentation/application_widgets.dart';
import '../../applications/presentation/applications_controller.dart';
import '../../profile/presentation/form_helpers.dart';
import '../domain/interview.dart';
import 'interview_widgets.dart';
import 'interviews_controller.dart';

class InterviewFormScreen extends ConsumerStatefulWidget {
  const InterviewFormScreen({
    super.key,
    required this.applicationId,
    this.interviewId,
  });

  final String applicationId;

  /// Nulo para programar una nueva.
  final String? interviewId;

  @override
  ConsumerState<InterviewFormScreen> createState() =>
      _InterviewFormScreenState();
}

class _InterviewFormScreenState extends ConsumerState<InterviewFormScreen> {
  final _formKey = GlobalKey<FormState>();
  Interview? _initial;
  late InterviewKind _kind;
  late InterviewOutcome _outcome;
  late DateTime _date;
  late TimeOfDay _time;
  late final TextEditingController _duration;
  late final TextEditingController _location;
  late final TextEditingController _notes;

  @override
  void initState() {
    super.initState();
    _initial = ref
        .read(interviewsControllerProvider)
        .value
        ?.firstWhereOrNull((i) => i.id == widget.interviewId);
    final initial = _initial;
    final now = ref.read(clockProvider)();
    // Por defecto: mañana a las 10:00.
    final start =
        initial?.scheduledAt ?? DateTime(now.year, now.month, now.day + 1, 10);
    _kind = initial?.kind ?? InterviewKind.screening;
    _outcome = initial?.outcome ?? InterviewOutcome.pending;
    _date = DateTime(start.year, start.month, start.day);
    _time = TimeOfDay(hour: start.hour, minute: start.minute);
    _duration = TextEditingController(
      text: '${initial?.durationMinutes ?? 60}',
    );
    _location = TextEditingController(text: initial?.location);
    _notes = TextEditingController(text: initial?.notes);
  }

  @override
  void dispose() {
    _duration.dispose();
    _location.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final process = ref
        .read(applicationsControllerProvider)
        .value
        ?.firstWhereOrNull((i) => i.application.id == widget.applicationId);
    if (process == null) return;
    final interview = Interview(
      id: _initial?.id ?? '',
      applicationId: widget.applicationId,
      kind: _kind,
      scheduledAt: DateTime(
        _date.year,
        _date.month,
        _date.day,
        _time.hour,
        _time.minute,
      ),
      durationMinutes: int.parse(_duration.text),
      location: _location.text.trim(),
      notes: _notes.text.trim(),
      outcome: _outcome,
    );
    try {
      final newStatus = await ref
          .read(interviewsControllerProvider.notifier)
          .save(interview, process.application);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            newStatus == null
                ? l10n.interviewSaved
                : l10n.interviewStatusChanged(statusLabel(l10n, newStatus)),
          ),
        ),
      );
      navigator.pop();
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.saveError)));
    }
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final initial = _initial!;
    if (!await confirmDelete(context, interviewKindLabel(l10n, initial.kind))) {
      return;
    }
    if (!mounted) return;
    await saveAndClose(
      context,
      () => ref.read(interviewsControllerProvider.notifier).delete(initial.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final now = ref.watch(clockProvider)();
    return ProfileFormScaffold(
      title: _initial == null ? l10n.interviewNew : l10n.interviewEdit,
      formKey: _formKey,
      onSave: _save,
      onDelete: _initial == null ? null : _delete,
      children: [
        DropdownButtonFormField<InterviewKind>(
          initialValue: _kind,
          decoration: InputDecoration(labelText: l10n.interviewKind),
          items: [
            for (final kind in InterviewKind.values)
              DropdownMenuItem(
                value: kind,
                child: Text(interviewKindLabel(l10n, kind)),
              ),
          ],
          onChanged: (value) => setState(() => _kind = value!),
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                key: const Key('interviewDate'),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: now.subtract(const Duration(days: 365)),
                    lastDate: now.add(const Duration(days: 365)),
                  );
                  if (picked != null) setState(() => _date = picked);
                },
                child: InputDecorator(
                  decoration: InputDecoration(labelText: l10n.interviewDate),
                  child: Text(DateFormat.yMMMEd(locale).format(_date)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 110,
              child: InkWell(
                key: const Key('interviewTime'),
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: _time,
                  );
                  if (picked != null) setState(() => _time = picked);
                },
                child: InputDecorator(
                  decoration: InputDecoration(labelText: l10n.interviewTime),
                  child: Text(_time.format(context)),
                ),
              ),
            ),
          ],
        ),
        TextFormField(
          key: const Key('interviewDuration'),
          controller: _duration,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
          decoration: InputDecoration(labelText: l10n.interviewDuration),
          validator: (value) {
            final minutes = int.tryParse(value ?? '');
            return minutes == null || minutes < 5 || minutes > 600
                ? l10n.interviewDurationInvalid
                : null;
          },
        ),
        TextFormField(
          key: const Key('interviewLocation'),
          controller: _location,
          autocorrect: false,
          decoration: InputDecoration(
            labelText: l10n.interviewLocation,
            hintText: l10n.interviewLocationHint,
          ),
        ),
        TextFormField(
          controller: _notes,
          minLines: 3,
          maxLines: 8,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: l10n.interviewNotes,
            hintText: l10n.interviewNotesHint,
            alignLabelWithHint: true,
          ),
        ),
        if (_initial != null)
          DropdownButtonFormField<InterviewOutcome>(
            initialValue: _outcome,
            decoration: InputDecoration(labelText: l10n.interviewOutcome),
            items: [
              for (final outcome in InterviewOutcome.values)
                DropdownMenuItem(
                  value: outcome,
                  child: Text(outcomeLabel(l10n, outcome)),
                ),
            ],
            onChanged: (value) => setState(() => _outcome = value!),
          ),
      ],
    );
  }
}
