import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/presentation/providers/applications/applications_provider.dart';
import 'package:rumbo/features/applications/presentation/widgets/application_widgets.dart';
import 'package:rumbo/features/interviews/domain/entities/interview.dart';
import 'package:rumbo/features/interviews/presentation/providers/interviews/interviews_provider.dart';
import 'package:rumbo/features/interviews/presentation/widgets/interview_widgets.dart';
import 'package:rumbo/shared/application/services/clock.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/form_helpers.dart';
import 'package:rumbo/shared/presentation/helpers/result_snack_bar.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        ?.firstWhereOrNull((Interview i) => i.id == widget.interviewId);
    final Interview? initial = _initial;
    final DateTime now = ref.read(clockProvider)();
    // Por defecto: mañana a las 10:00.
    final DateTime start =
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
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final NavigatorState navigator = Navigator.of(context);
    final ApplicationWithJob? process = ref
        .read(applicationsControllerProvider)
        .value
        ?.firstWhereOrNull(
          (ApplicationWithJob i) => i.application.id == widget.applicationId,
        );
    if (process == null) return;
    final Interview interview = Interview(
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
    final Result<ApplicationStatus?> result = await ref
        .read(interviewsControllerProvider.notifier)
        .save(interview: interview, application: process.application);
    final ApplicationStatus? newStatus = result.valueOrNull;
    if (showResultSnackBar(
      messenger: messenger,
      l10n: l10n,
      result: result,
      success: newStatus == null
          ? l10n.interviewSaved
          : l10n.interviewStatusChanged(statusLabel(l10n, newStatus)),
    )) {
      navigator.pop();
    }
  }

  Future<void> _delete() async {
    final AppLocalizations l10n = context.l10n;
    final Interview initial = _initial!;
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
    final AppLocalizations l10n = context.l10n;
    final String locale = Localizations.localeOf(context).toLanguageTag();
    final DateTime now = ref.watch(clockProvider)();
    return ProfileFormScaffold(
      title: _initial == null ? l10n.interviewNew : l10n.interviewEdit,
      formKey: _formKey,
      onSave: _save,
      onDelete: _initial == null ? null : _delete,
      children: <Widget>[
        DropdownButtonFormField<InterviewKind>(
          initialValue: _kind,
          decoration: InputDecoration(labelText: l10n.interviewKind),
          items: <DropdownMenuItem<InterviewKind>>[
            for (final InterviewKind kind in InterviewKind.values)
              DropdownMenuItem<InterviewKind>(
                value: kind,
                child: Text(interviewKindLabel(l10n, kind)),
              ),
          ],
          onChanged: (InterviewKind? value) => setState(() => _kind = value!),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                key: const Key('interviewDate'),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
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
                  final TimeOfDay? picked = await showTimePicker(
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
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
          decoration: InputDecoration(labelText: l10n.interviewDuration),
          validator: (String? value) {
            final int? minutes = int.tryParse(value ?? '');
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
            items: <DropdownMenuItem<InterviewOutcome>>[
              for (final InterviewOutcome outcome in InterviewOutcome.values)
                DropdownMenuItem<InterviewOutcome>(
                  value: outcome,
                  child: Text(outcomeLabel(l10n, outcome)),
                ),
            ],
            onChanged: (InterviewOutcome? value) =>
                setState(() => _outcome = value!),
          ),
      ],
    );
  }
}
