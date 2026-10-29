import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/time/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../../jobs/domain/job.dart';
import '../../jobs/presentation/job_widgets.dart';
import '../../profile/presentation/form_helpers.dart';
import '../domain/job_offer.dart';
import 'offers_controller.dart';

class OfferFormScreen extends ConsumerStatefulWidget {
  const OfferFormScreen({super.key, required this.applicationId});

  final String applicationId;

  @override
  ConsumerState<OfferFormScreen> createState() => _OfferFormScreenState();
}

class _OfferFormScreenState extends ConsumerState<OfferFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late JobOffer _offer;
  late final TextEditingController _salary;
  late final TextEditingController _currency;
  late final TextEditingController _benefits;
  late final TextEditingController _notes;

  @override
  void initState() {
    super.initState();
    _offer =
        ref
            .read(offersControllerProvider)
            .value
            ?.firstWhereOrNull(
              (o) => o.applicationId == widget.applicationId,
            ) ??
        JobOffer(applicationId: widget.applicationId);
    final salary = _offer.salary;
    _salary = TextEditingController(
      text: salary == null ? '' : salary.round().toString(),
    );
    _currency = TextEditingController(text: _offer.currency);
    _benefits = TextEditingController(text: _offer.benefits);
    _notes = TextEditingController(text: _offer.notes);
  }

  @override
  void dispose() {
    _salary.dispose();
    _currency.dispose();
    _benefits.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final offer = _offer.copyWith(
      salary: double.tryParse(_salary.text.trim()),
      currency: _currency.text.trim().toUpperCase(),
      benefits: _benefits.text.trim(),
      notes: _notes.text.trim(),
    );
    saveAndClose(context, () async {
      await ref.read(offersControllerProvider.notifier).save(offer);
      messenger.showSnackBar(SnackBar(content: Text(l10n.offerSaved)));
    });
  }

  Widget _dateField(
    String label,
    DateTime? value,
    ValueChanged<DateTime> onChanged,
  ) {
    final now = ref.read(clockProvider)();
    final locale = Localizations.localeOf(context).toLanguageTag();
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? now,
          firstDate: now.subtract(const Duration(days: 365)),
          lastDate: now.add(const Duration(days: 730)),
        );
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        isEmpty: value == null,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_month_outlined),
        ),
        child: value == null
            ? null
            : Text(DateFormat.yMMMd(locale).format(value)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ProfileFormScaffold(
      title: l10n.offerTitle,
      formKey: _formKey,
      onSave: _save,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                key: const Key('offerSalary'),
                controller: _salary,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(labelText: l10n.offerSalary),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: TextFormField(
                key: const Key('offerCurrency'),
                controller: _currency,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [LengthLimitingTextInputFormatter(3)],
                decoration: InputDecoration(labelText: l10n.offerCurrency),
                validator: (value) => requiredValidator(context, value),
              ),
            ),
          ],
        ),
        SegmentedButton<SalaryPeriod>(
          segments: [
            ButtonSegment(
              value: SalaryPeriod.month,
              label: Text(l10n.periodMonth),
            ),
            ButtonSegment(
              value: SalaryPeriod.year,
              label: Text(l10n.periodYear),
            ),
          ],
          selected: {_offer.period},
          onSelectionChanged: (s) =>
              setState(() => _offer = _offer.copyWith(period: s.first)),
        ),
        DropdownButtonFormField<WorkMode?>(
          initialValue: _offer.workMode,
          decoration: InputDecoration(labelText: l10n.offerWorkMode),
          items: [
            DropdownMenuItem(value: null, child: Text(l10n.notSet)),
            for (final mode in WorkMode.values)
              DropdownMenuItem(
                value: mode,
                child: Text(workModeLabel(l10n, mode)),
              ),
          ],
          onChanged: (value) =>
              setState(() => _offer = _offer.copyWith(workMode: value)),
        ),
        _dateField(
          l10n.offerStart,
          _offer.startDate,
          (date) => setState(() => _offer = _offer.copyWith(startDate: date)),
        ),
        _dateField(
          l10n.offerDeadline,
          _offer.deadline,
          (date) => setState(() => _offer = _offer.copyWith(deadline: date)),
        ),
        TextFormField(
          controller: _benefits,
          minLines: 2,
          maxLines: 6,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: l10n.offerBenefits,
            hintText: l10n.offerBenefitsHint,
            alignLabelWithHint: true,
          ),
        ),
        TextFormField(
          controller: _notes,
          minLines: 2,
          maxLines: 6,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: l10n.offerNotes,
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }
}
