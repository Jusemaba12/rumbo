import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/interview.dart';

String interviewKindLabel(AppLocalizations l10n, InterviewKind kind) =>
    switch (kind) {
      InterviewKind.screening => l10n.kindScreening,
      InterviewKind.technical => l10n.kindTechnical,
      InterviewKind.hr => l10n.kindHr,
      InterviewKind.final_ => l10n.kindFinal,
      InterviewKind.other => l10n.kindOther,
    };

String outcomeLabel(AppLocalizations l10n, InterviewOutcome outcome) =>
    switch (outcome) {
      InterviewOutcome.pending => l10n.outcomePending,
      InterviewOutcome.passed => l10n.outcomePassed,
      InterviewOutcome.failed => l10n.outcomeFailed,
    };

/// «jue 16 oct · 10:00» en el idioma del usuario.
String interviewWhen(BuildContext context, DateTime when) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  return '${DateFormat.MMMEd(locale).format(when)} · '
      '${DateFormat.Hm(locale).format(when)}';
}

Uri? interviewLink(String location) {
  final uri = Uri.tryParse(location.trim());
  return uri != null && (uri.scheme == 'https' || uri.scheme == 'http')
      ? uri
      : null;
}

class InterviewTile extends StatelessWidget {
  const InterviewTile({
    super.key,
    required this.interview,
    this.title,
    this.onTap,
  });

  final Interview interview;

  /// Título alternativo (p. ej. cargo y empresa en Inicio).
  final String? title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final link = interviewLink(interview.location);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.event_outlined),
      title: Text(title ?? interviewKindLabel(l10n, interview.kind)),
      subtitle: Text(
        [
          interviewWhen(context, interview.scheduledAt),
          if (title != null) interviewKindLabel(l10n, interview.kind),
          if (interview.outcome != InterviewOutcome.pending)
            outcomeLabel(l10n, interview.outcome),
        ].join(' · '),
      ),
      trailing: link == null
          ? null
          : IconButton(
              tooltip: l10n.interviewJoin,
              icon: const Icon(Icons.videocam_outlined),
              onPressed: () =>
                  launchUrl(link, mode: LaunchMode.externalApplication),
            ),
      onTap: onTap,
    );
  }
}
