import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/presentation/widgets/job_widgets.dart';
import 'package:rumbo/features/offers/domain/entities/job_offer.dart';
import 'package:rumbo/features/offers/presentation/providers/offers/offers_provider.dart';
import 'package:rumbo/shared/application/services/clock.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/helpers/form_helpers.dart';

class OfferFormScreen extends ConsumerStatefulWidget {
  const OfferFormScreen({super.key, required this.applicationId});

  final String applicationId;

  @override
  ConsumerState<OfferFormScreen> createState() => _OfferFormScreenState();
}

class _OfferFormScreenState extends ConsumerState<OfferFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              (JobOffer o) => o.applicationId == widget.applicationId,
            ) ??
        JobOffer(applicationId: widget.applicationId);
    final double? salary = _offer.salary;
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
    final AppLocalizations l10n = context.l10n;
    final JobOffer offer = _offer.copyWith(
      salary: double.tryParse(_salary.text.trim()),
      currency: _currency.text.trim().toUpperCase(),
      benefits: _benefits.text.trim(),
      notes: _notes.text.trim(),
    );
    saveAndClose(
      context,
      () => ref.read(offersControllerProvider.notifier).save(offer),
      success: l10n.offerSaved,
    );
  }

  Widget _dateField({
    required String label,
    required DateTime? value,
    required ValueChanged<DateTime> onChanged,
  }) {
    final DateTime now = ref.read(clockProvider)();
    final String locale = Localizations.localeOf(context).toLanguageTag();
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
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
    final AppLocalizations l10n = context.l10n;
    return ProfileFormScaffold(
      title: l10n.offerTitle,
      formKey: _formKey,
      onSave: _save,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: TextFormField(
                key: const Key('offerSalary'),
                controller: _salary,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
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
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(3),
                ],
                decoration: InputDecoration(labelText: l10n.offerCurrency),
                validator: (String? value) => requiredValidator(context, value),
              ),
            ),
          ],
        ),
        SegmentedButton<SalaryPeriod>(
          segments: <ButtonSegment<SalaryPeriod>>[
            ButtonSegment<SalaryPeriod>(
              value: SalaryPeriod.month,
              label: Text(l10n.periodMonth),
            ),
            ButtonSegment<SalaryPeriod>(
              value: SalaryPeriod.year,
              label: Text(l10n.periodYear),
            ),
          ],
          selected: <SalaryPeriod>{_offer.period},
          onSelectionChanged: (Set<SalaryPeriod> s) =>
              setState(() => _offer = _offer.copyWith(period: s.first)),
        ),
        DropdownButtonFormField<WorkMode?>(
          initialValue: _offer.workMode,
          decoration: InputDecoration(labelText: l10n.offerWorkMode),
          items: <DropdownMenuItem<WorkMode?>>[
            DropdownMenuItem<WorkMode?>(value: null, child: Text(l10n.notSet)),
            for (final WorkMode mode in WorkMode.values)
              DropdownMenuItem<WorkMode?>(
                value: mode,
                child: Text(workModeLabel(l10n, mode)),
              ),
          ],
          onChanged: (WorkMode? value) =>
              setState(() => _offer = _offer.copyWith(workMode: value)),
        ),
        _dateField(
          label: l10n.offerStart,
          value: _offer.startDate,
          onChanged: (DateTime date) =>
              setState(() => _offer = _offer.copyWith(startDate: date)),
        ),
        _dateField(
          label: l10n.offerDeadline,
          value: _offer.deadline,
          onChanged: (DateTime date) =>
              setState(() => _offer = _offer.copyWith(deadline: date)),
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
