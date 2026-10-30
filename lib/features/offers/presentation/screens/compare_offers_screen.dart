import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Refreshable;
import 'package:intl/intl.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/presentation/providers/applications/applications_provider.dart';
import 'package:rumbo/features/applications/presentation/widgets/application_widgets.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/presentation/providers/jobs/jobs_provider.dart';
import 'package:rumbo/features/jobs/presentation/widgets/job_widgets.dart';
import 'package:rumbo/features/offers/domain/entities/job_offer.dart';
import 'package:rumbo/features/offers/domain/services/offer_rows.dart';
import 'package:rumbo/features/offers/presentation/providers/offers/offers_provider.dart';
import 'package:rumbo/features/offers/presentation/widgets/offer_widgets.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_theme.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';
import 'package:rumbo/shared/presentation/widgets/empty_state.dart';
import 'package:rumbo/shared/presentation/widgets/notice_banner.dart';
import 'package:rumbo/shared/presentation/widgets/pull_to_refresh.dart';

class CompareOffersScreen extends ConsumerWidget {
  const CompareOffersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final List<OfferRow> rows = offerRows(
      applications:
          ref.watch(applicationsControllerProvider).value ??
          <ApplicationWithJob>[],
      offers: ref.watch(offersControllerProvider).value ?? <JobOffer>[],
      jobs: ref.watch(jobsControllerProvider).value ?? <SavedJob>[],
    );
    final String locale = Localizations.localeOf(context).toLanguageTag();

    // Mejor salario mensual por moneda.
    final Map<String, double> best = <String, double>{};
    for (final OfferRow row in rows) {
      final double? monthly = row.offer.monthlySalary;
      if (monthly == null) continue;
      final String currency = row.offer.currency;
      if (monthly > (best[currency] ?? -1)) best[currency] = monthly;
    }
    final Set<String> currencies = <String>{
      for (final OfferRow row in rows)
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
              providers: <Refreshable<Future<Object?>>>[
                offersControllerProvider.future,
                applicationsControllerProvider.future,
              ],
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                children: <Widget>[
                  if (currencies.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: NoticeBanner(
                        text: l10n.compareMixedCurrencies,
                        icon: Icons.currency_exchange,
                      ),
                    ),
                  for (final OfferRow row in rows)
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
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
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
                                  case final double monthly?) ...<Widget>[
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
                                children: <Widget>[
                                  if (row.offer.workMode
                                      case final WorkMode mode?)
                                    Text(workModeLabel(l10n, mode)),
                                  if (row.score case final int score?)
                                    Text(l10n.compareFit(score)),
                                  if (row.offer.deadline
                                      case final DateTime deadline?)
                                    Text(
                                      l10n.compareDeadline(
                                        DateFormat.MMMd(locale)
                                            .format(deadline),
                                      ),
                                    ),
                                ],
                              ),
                              if (row.offer.benefits.isNotEmpty) ...<Widget>[
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
