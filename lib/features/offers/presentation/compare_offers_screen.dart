import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/notice_banner.dart';
import '../../../shared/widgets/pull_to_refresh.dart';
import '../../applications/presentation/application_widgets.dart';
import '../../applications/presentation/applications_controller.dart';
import '../../jobs/presentation/job_widgets.dart';
import '../../jobs/presentation/jobs_controller.dart';
import 'offer_widgets.dart';
import 'offers_controller.dart';

class CompareOffersScreen extends ConsumerWidget {
  const CompareOffersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final rows = offerRows(
      ref.watch(applicationsControllerProvider).value ?? [],
      ref.watch(offersControllerProvider).value ?? [],
      ref.watch(jobsControllerProvider).value ?? [],
    );
    final locale = Localizations.localeOf(context).toLanguageTag();

    // Mejor salario mensual por moneda.
    final best = <String, double>{};
    for (final row in rows) {
      final monthly = row.offer.monthlySalary;
      if (monthly == null) continue;
      final currency = row.offer.currency;
      if (monthly > (best[currency] ?? -1)) best[currency] = monthly;
    }
    final currencies = {
      for (final row in rows)
        if (row.offer.salary != null) row.offer.currency,
    };

    return Scaffold(
      appBar: AppBar(title: Text(l10n.compareTitle)),
      body: rows.isEmpty
          ? EmptyState(
              icon: Icons.compare_arrows,
              title: l10n.compareTitle,
              body: l10n.compareEmpty,
            )
          : PullToRefresh(
              providers: [
                offersControllerProvider.future,
                applicationsControllerProvider.future,
              ],
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                children: [
                  if (currencies.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: NoticeBanner(
                        text: l10n.compareMixedCurrencies,
                        icon: Icons.currency_exchange,
                      ),
                    ),
                  for (final row in rows)
                    Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () => ApplicationDetailRoute(
                          id: row.process.application.id,
                        ).push(context),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${jobTitle(l10n, row.process.job)} · '
                                      '${row.process.job.company}',
                                      style: theme.textTheme.titleMedium,
                                    ),
                                  ),
                                  StatusPill(
                                    status: row.process.application.status,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              if (row.offer.monthlySalary
                                  case final monthly?) ...[
                                Text(
                                  l10n.compareMonthly(
                                    formatMoney(
                                      context,
                                      monthly,
                                      row.offer.currency,
                                    ),
                                  ),
                                  style: AppTheme.numbers(
                                    theme.textTheme.titleLarge,
                                  ).copyWith(fontSize: 20),
                                ),
                                if (best[row.offer.currency] == monthly &&
                                    rows.length > 1)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        l10n.compareHighest(row.offer.currency),
                                        style: theme.textTheme.labelMedium
                                            ?.copyWith(
                                              color:
                                                  theme.colorScheme.onPrimary,
                                            ),
                                      ),
                                    ),
                                  ),
                              ] else
                                Text(l10n.offerNoDetails),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 12,
                                runSpacing: 4,
                                children: [
                                  if (row.offer.workMode case final mode?)
                                    Text(workModeLabel(l10n, mode)),
                                  if (row.score case final score?)
                                    Text(l10n.compareFit(score)),
                                  if (row.offer.deadline case final deadline?)
                                    Text(
                                      l10n.compareDeadline(
                                        DateFormat.MMMd(locale)
                                            .format(deadline),
                                      ),
                                    ),
                                ],
                              ),
                              if (row.offer.benefits.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  row.offer.benefits,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
