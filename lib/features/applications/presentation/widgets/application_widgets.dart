import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/domain/services/follow_up.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/configurations/theme/app_colors.dart';
import 'package:rumbo/shared/presentation/extensions/build_context_extension.dart';

String statusLabel(AppLocalizations l10n, ApplicationStatus status) =>
    switch (status) {
      ApplicationStatus.saved => l10n.statusSaved,
      ApplicationStatus.preparing => l10n.statusPreparing,
      ApplicationStatus.applied => l10n.statusApplied,
      ApplicationStatus.inReview => l10n.statusInReview,
      ApplicationStatus.technicalTest => l10n.statusTechnicalTest,
      ApplicationStatus.interview => l10n.statusInterview,
      ApplicationStatus.offer => l10n.statusOffer,
      ApplicationStatus.accepted => l10n.statusAccepted,
      ApplicationStatus.declined => l10n.statusDeclined,
      ApplicationStatus.rejected => l10n.statusRejected,
      ApplicationStatus.noResponse => l10n.statusNoResponse,
    };

/// Texto del botón que lleva a [status], escrito como lo que pasó.
String statusAction(AppLocalizations l10n, ApplicationStatus status) =>
    switch (status) {
      ApplicationStatus.saved => l10n.actionSaved,
      ApplicationStatus.preparing => l10n.actionPreparing,
      ApplicationStatus.applied => l10n.actionApplied,
      ApplicationStatus.inReview => l10n.actionInReview,
      ApplicationStatus.technicalTest => l10n.actionTechnicalTest,
      ApplicationStatus.interview => l10n.actionInterview,
      ApplicationStatus.offer => l10n.actionOffer,
      ApplicationStatus.accepted => l10n.actionAccepted,
      ApplicationStatus.declined => l10n.actionDeclined,
      ApplicationStatus.rejected => l10n.actionRejected,
      ApplicationStatus.noResponse => l10n.actionNoResponse,
    };

/// Orden de las columnas del tablero.
const List<ApplicationStatus> boardOrder = <ApplicationStatus>[
  ApplicationStatus.offer,
  ApplicationStatus.interview,
  ApplicationStatus.technicalTest,
  ApplicationStatus.inReview,
  ApplicationStatus.applied,
  ApplicationStatus.preparing,
  ApplicationStatus.saved,
  ApplicationStatus.noResponse,
  ApplicationStatus.accepted,
  ApplicationStatus.declined,
  ApplicationStatus.rejected,
];

/// Tono de color de cada estado: verde lo logrado, azul lo enviado, ámbar lo
/// que pide preparación, rojo lo perdido y gris lo que no avanza.
Tone statusTone(ApplicationStatus status) => switch (status) {
  ApplicationStatus.offer || ApplicationStatus.accepted => Tone.accent,
  ApplicationStatus.applied || ApplicationStatus.inReview => Tone.info,
  ApplicationStatus.interview || ApplicationStatus.technicalTest => Tone.signal,
  ApplicationStatus.rejected || ApplicationStatus.declined => Tone.risk,
  ApplicationStatus.saved ||
  ApplicationStatus.preparing ||
  ApplicationStatus.noResponse => Tone.neutral,
};

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.status});

  final ApplicationStatus status;

  @override
  Widget build(BuildContext context) {
    final RumboColors colors = context.colors;
    // La oferta es el único estado en color sólido: es el que más importa.
    final (
      Color background,
      Color foreground,
    ) = status == ApplicationStatus.offer
        ? (colors.accent, colors.onAccent)
        : colors.soft(statusTone(status));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        statusLabel(context.l10n, status),
        style: Theme.of(context).textTheme.labelMedium
            ?.copyWith(color: foreground),
      ),
    );
  }
}

/// Línea de estado del seguimiento: vencido (en color) o fecha prevista.
class FollowUpLine extends StatelessWidget {
  const FollowUpLine({super.key, required this.application, required this.now});

  final Application application;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final DateTime? followUp = application.nextFollowUpAt;
    final DateTime? applied = application.appliedAt;
    if (isFollowUpDue(application: application, now: now)) {
      return Row(
        children: <Widget>[
          Icon(
            Icons.notifications_active,
            size: 16,
            color: context.colors.onSignalSoft,
          ),
          const SizedBox(width: 4),
          Text(
            l10n.followUpDue,
            style: theme.textTheme.bodySmall?.copyWith(
              color: context.colors.onSignalSoft,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }
    final List<String> parts = <String>[
      if (applied != null) l10n.appliedDaysAgo(now.difference(applied).inDays),
      if (followUp != null && application.status.isActive)
        l10n.followUpOn(
          DateFormat.MMMd(Localizations.localeOf(context).toLanguageTag())
              .format(followUp),
        ),
    ];
    if (parts.isEmpty) return const SizedBox.shrink();
    return Text(
      parts.join(' · '),
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
