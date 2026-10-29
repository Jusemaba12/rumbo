import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/account/presentation/welcome_screen.dart';
import '../../features/answers/presentation/answers_screen.dart';
import '../../features/applications/presentation/application_detail_screen.dart';
import '../../features/applications/presentation/applications_screen.dart';
import '../../features/applications/presentation/prepare_application_screen.dart';
import '../../features/auth/presentation/sign_in_screen.dart';
import '../../features/company/presentation/company_brief_screen.dart';
import '../../features/email/data/email_drafter.dart';
import '../../features/email/presentation/email_draft_screen.dart';
import '../../features/email/presentation/gmail_connect_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/interviews/presentation/interview_form_screen.dart';
import '../../features/jobs/presentation/add_job_screen.dart';
import '../../features/jobs/presentation/apply_email_screen.dart';
import '../../features/jobs/presentation/complete_job_screen.dart';
import '../../features/jobs/presentation/job_contact.dart';
import '../../features/jobs/presentation/job_detail_screen.dart';
import '../../features/jobs/presentation/jobs_screen.dart';
import '../../features/learning/presentation/learning_screen.dart';
import '../../features/learning/presentation/learning_topic_screen.dart';
import '../../features/more/presentation/more_screen.dart';
import '../../features/offers/presentation/compare_offers_screen.dart';
import '../../features/offers/presentation/negotiation_screen.dart';
import '../../features/offers/presentation/offer_form_screen.dart';
import '../../features/practice/presentation/practice_screen.dart';
import '../../features/profile/presentation/basics_form_screen.dart';
import '../../features/profile/presentation/education_form_screen.dart';
import '../../features/profile/presentation/experience_form_screen.dart';
import '../../features/profile/presentation/import_resume_screen.dart';
import '../../features/profile/presentation/improve_achievements_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/profile/presentation/project_form_screen.dart';
import '../../features/profile/presentation/resume_review_screen.dart';
import '../../features/reminders/presentation/reminders_screen.dart';
import '../../features/search/presentation/search_preferences_screen.dart';
import '../../features/stats/presentation/stats_screen.dart';
import 'tabs_shell.dart';

part 'routes.g.dart';

// Rutas tipadas (go_router_builder). Se navega con `XRoute(...).go(context)`
// o `.push(context)`; `.location` da la ruta como texto (avisos locales).
// Las rutas fijas como 'new' o 'compare' van antes que ':id' para que no se
// lean como un id.

@TypedGoRoute<SignInRoute>(path: '/sign-in')
class SignInRoute extends GoRouteData with $SignInRoute {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SignInScreen();
}

@TypedGoRoute<WelcomeRoute>(path: '/welcome')
class WelcomeRoute extends GoRouteData with $WelcomeRoute {
  const WelcomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const WelcomeScreen();
}

@TypedStatefulShellRoute<TabsShellRoute>(
  branches: [
    TypedStatefulShellBranch<HomeBranch>(
      routes: [
        TypedGoRoute<HomeRoute>(
          path: '/home',
          routes: [TypedGoRoute<StatsRoute>(path: 'stats')],
        ),
      ],
    ),
    TypedStatefulShellBranch<JobsBranch>(
      routes: [
        TypedGoRoute<JobsRoute>(
          path: '/jobs',
          routes: [
            TypedGoRoute<JobNewRoute>(path: 'new'),
            TypedGoRoute<JobDetailRoute>(
              path: ':id',
              routes: [
                TypedGoRoute<JobCompanyRoute>(path: 'company'),
                TypedGoRoute<JobPracticeRoute>(path: 'practice'),
                TypedGoRoute<JobPrepareRoute>(path: 'prepare'),
                TypedGoRoute<JobCompleteRoute>(path: 'complete'),
                TypedGoRoute<JobContactRoute>(path: 'contact'),
                TypedGoRoute<JobApplyEmailRoute>(path: 'apply-email'),
              ],
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<ApplicationsBranch>(
      routes: [
        TypedGoRoute<ApplicationsRoute>(
          path: '/applications',
          routes: [
            TypedGoRoute<CompareOffersRoute>(path: 'compare'),
            TypedGoRoute<ApplicationDetailRoute>(
              path: ':id',
              routes: [
                TypedGoRoute<EmailDraftRoute>(path: 'email/:kind'),
                TypedGoRoute<NegotiationRoute>(path: 'negotiate'),
                TypedGoRoute<OfferFormRoute>(path: 'offer'),
                TypedGoRoute<InterviewNewRoute>(path: 'interview/new'),
                TypedGoRoute<InterviewEditRoute>(
                  path: 'interview/:interviewId',
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<ResumeBranch>(
      routes: [
        TypedGoRoute<ResumeRoute>(
          path: '/resume',
          routes: [
            TypedGoRoute<ProfileBasicsRoute>(path: 'basics'),
            TypedGoRoute<ProfileImportRoute>(path: 'import'),
            TypedGoRoute<ProfileReviewRoute>(path: 'review'),
            TypedGoRoute<LearningRoute>(
              path: 'learning',
              routes: [TypedGoRoute<LearningTopicRoute>(path: ':id')],
            ),
            TypedGoRoute<ImproveAchievementsRoute>(path: 'improve/:id'),
            TypedGoRoute<ExperienceNewRoute>(path: 'experience/new'),
            TypedGoRoute<ExperienceEditRoute>(path: 'experience/:id'),
            TypedGoRoute<EducationNewRoute>(path: 'education/new'),
            TypedGoRoute<EducationEditRoute>(path: 'education/:id'),
            TypedGoRoute<ProjectNewRoute>(path: 'project/new'),
            TypedGoRoute<ProjectEditRoute>(path: 'project/:id'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<MoreBranch>(
      routes: [
        TypedGoRoute<MoreRoute>(
          path: '/more',
          routes: [
            TypedGoRoute<SearchPreferencesRoute>(path: 'search'),
            TypedGoRoute<GmailRoute>(path: 'gmail'),
            TypedGoRoute<RemindersRoute>(path: 'reminders'),
            TypedGoRoute<AnswersRoute>(
              path: 'answers',
              routes: [
                TypedGoRoute<AnswerNewRoute>(path: 'new'),
                TypedGoRoute<AnswerEditRoute>(path: ':id'),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
)
class TabsShellRoute extends StatefulShellRouteData {
  const TabsShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) => TabsShell(shell: navigationShell);
}

class HomeBranch extends StatefulShellBranchData {
  const HomeBranch();
}

class JobsBranch extends StatefulShellBranchData {
  const JobsBranch();
}

class ApplicationsBranch extends StatefulShellBranchData {
  const ApplicationsBranch();
}

class ResumeBranch extends StatefulShellBranchData {
  const ResumeBranch();
}

class MoreBranch extends StatefulShellBranchData {
  const MoreBranch();
}

// Inicio

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class StatsRoute extends GoRouteData with $StatsRoute {
  const StatsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const StatsScreen();
}

// Ofertas

class JobsRoute extends GoRouteData with $JobsRoute {
  const JobsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const JobsScreen();
}

/// Añadir oferta; [shared] es el texto compartido desde otra app.
class JobNewRoute extends GoRouteData with $JobNewRoute {
  const JobNewRoute({this.shared});

  final String? shared;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      AddJobScreen(shared: shared);
}

class JobDetailRoute extends GoRouteData with $JobDetailRoute {
  const JobDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      JobDetailScreen(jobId: id);
}

class JobCompanyRoute extends GoRouteData with $JobCompanyRoute {
  const JobCompanyRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      CompanyBriefScreen(jobId: id);
}

class JobPracticeRoute extends GoRouteData with $JobPracticeRoute {
  const JobPracticeRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PracticeScreen(jobId: id);
}

class JobPrepareRoute extends GoRouteData with $JobPrepareRoute {
  const JobPrepareRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PrepareApplicationScreen(jobId: id);
}

/// Pegar la descripción completa de una oferta que llegó sin ella.
class JobCompleteRoute extends GoRouteData with $JobCompleteRoute {
  const JobCompleteRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      CompleteJobScreen(jobId: id);
}

/// Contacto del reclutador y forma de postular.
class JobContactRoute extends GoRouteData with $JobContactRoute {
  const JobContactRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      JobContactScreen(jobId: id);
}

/// Postular por correo con la HV adaptada.
class JobApplyEmailRoute extends GoRouteData with $JobApplyEmailRoute {
  const JobApplyEmailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ApplyEmailScreen(jobId: id);
}

// Procesos

class ApplicationsRoute extends GoRouteData with $ApplicationsRoute {
  const ApplicationsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ApplicationsScreen();
}

class CompareOffersRoute extends GoRouteData with $CompareOffersRoute {
  const CompareOffersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CompareOffersScreen();
}

class ApplicationDetailRoute extends GoRouteData with $ApplicationDetailRoute {
  const ApplicationDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ApplicationDetailScreen(applicationId: id);
}

class EmailDraftRoute extends GoRouteData with $EmailDraftRoute {
  const EmailDraftRoute({required this.id, required this.kind});

  final String id;
  final EmailDraftKind kind;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EmailDraftScreen(applicationId: id, kind: kind);
}

class NegotiationRoute extends GoRouteData with $NegotiationRoute {
  const NegotiationRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      NegotiationScreen(applicationId: id);
}

class OfferFormRoute extends GoRouteData with $OfferFormRoute {
  const OfferFormRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      OfferFormScreen(applicationId: id);
}

class InterviewNewRoute extends GoRouteData with $InterviewNewRoute {
  const InterviewNewRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      InterviewFormScreen(applicationId: id);
}

class InterviewEditRoute extends GoRouteData with $InterviewEditRoute {
  const InterviewEditRoute({required this.id, required this.interviewId});

  final String id;
  final String interviewId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      InterviewFormScreen(applicationId: id, interviewId: interviewId);
}

// HV

class ResumeRoute extends GoRouteData with $ResumeRoute {
  const ResumeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
}

class ProfileBasicsRoute extends GoRouteData with $ProfileBasicsRoute {
  const ProfileBasicsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BasicsFormScreen();
}

class ProfileImportRoute extends GoRouteData with $ProfileImportRoute {
  const ProfileImportRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ImportResumeScreen();
}

class ProfileReviewRoute extends GoRouteData with $ProfileReviewRoute {
  const ProfileReviewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ResumeReviewScreen();
}

class LearningRoute extends GoRouteData with $LearningRoute {
  const LearningRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LearningScreen();
}

class LearningTopicRoute extends GoRouteData with $LearningTopicRoute {
  const LearningTopicRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      LearningTopicScreen(topicId: id);
}

class ImproveAchievementsRoute extends GoRouteData
    with $ImproveAchievementsRoute {
  const ImproveAchievementsRoute({required this.id});

  /// Id de la experiencia.
  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ImproveAchievementsScreen(experienceId: id);
}

class ExperienceNewRoute extends GoRouteData with $ExperienceNewRoute {
  const ExperienceNewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ExperienceFormScreen();
}

class ExperienceEditRoute extends GoRouteData with $ExperienceEditRoute {
  const ExperienceEditRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ExperienceFormScreen(experienceId: id);
}

class EducationNewRoute extends GoRouteData with $EducationNewRoute {
  const EducationNewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EducationFormScreen();
}

class EducationEditRoute extends GoRouteData with $EducationEditRoute {
  const EducationEditRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EducationFormScreen(educationId: id);
}

class ProjectNewRoute extends GoRouteData with $ProjectNewRoute {
  const ProjectNewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProjectFormScreen();
}

class ProjectEditRoute extends GoRouteData with $ProjectEditRoute {
  const ProjectEditRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ProjectFormScreen(projectId: id);
}

// Más

class MoreRoute extends GoRouteData with $MoreRoute {
  const MoreRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const MoreScreen();
}

class SearchPreferencesRoute extends GoRouteData with $SearchPreferencesRoute {
  const SearchPreferencesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SearchPreferencesScreen();
}

class GmailRoute extends GoRouteData with $GmailRoute {
  const GmailRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const GmailConnectScreen();
}

class RemindersRoute extends GoRouteData with $RemindersRoute {
  const RemindersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RemindersScreen();
}

class AnswersRoute extends GoRouteData with $AnswersRoute {
  const AnswersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AnswersScreen();
}

/// Respuesta nueva; [$extra] es la pregunta con la que empieza.
class AnswerNewRoute extends GoRouteData with $AnswerNewRoute {
  const AnswerNewRoute({this.$extra});

  final String? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      AnswerFormScreen(initialQuestion: $extra);
}

class AnswerEditRoute extends GoRouteData with $AnswerEditRoute {
  const AnswerEditRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      AnswerFormScreen(answerId: id);
}
