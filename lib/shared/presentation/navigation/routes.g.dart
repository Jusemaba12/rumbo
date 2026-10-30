// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $signInRoute,
  $welcomeRoute,
  $tabsShellRoute,
];

RouteBase get $signInRoute => GoRouteData.$route(
  path: '/sign-in',
  hasOverriddenOnExit: false,
  factory: $SignInRoute._fromState,
);

mixin $SignInRoute on GoRouteData {
  static SignInRoute _fromState(GoRouterState state) => const SignInRoute();

  @override
  String get location => GoRouteData.$location('/sign-in');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $welcomeRoute => GoRouteData.$route(
  path: '/welcome',
  hasOverriddenOnExit: false,
  factory: $WelcomeRoute._fromState,
);

mixin $WelcomeRoute on GoRouteData {
  static WelcomeRoute _fromState(GoRouterState state) => const WelcomeRoute();

  @override
  String get location => GoRouteData.$location('/welcome');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $tabsShellRoute => StatefulShellRouteData.$route(
  factory: $TabsShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/home',
          hasOverriddenOnExit: false,
          factory: $HomeRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'stats',
              hasOverriddenOnExit: false,
              factory: $StatsRoute._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/jobs',
          hasOverriddenOnExit: false,
          factory: $JobsRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'new',
              hasOverriddenOnExit: false,
              factory: $JobNewRoute._fromState,
            ),
            GoRouteData.$route(
              path: ':id',
              hasOverriddenOnExit: false,
              factory: $JobDetailRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'company',
                  hasOverriddenOnExit: false,
                  factory: $JobCompanyRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'practice',
                  hasOverriddenOnExit: false,
                  factory: $JobPracticeRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'prepare',
                  hasOverriddenOnExit: false,
                  factory: $JobPrepareRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'complete',
                  hasOverriddenOnExit: false,
                  factory: $JobCompleteRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'contact',
                  hasOverriddenOnExit: false,
                  factory: $JobContactRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'apply-email',
                  hasOverriddenOnExit: false,
                  factory: $JobApplyEmailRoute._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/applications',
          hasOverriddenOnExit: false,
          factory: $ApplicationsRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'compare',
              hasOverriddenOnExit: false,
              factory: $CompareOffersRoute._fromState,
            ),
            GoRouteData.$route(
              path: ':id',
              hasOverriddenOnExit: false,
              factory: $ApplicationDetailRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'email/:kind',
                  hasOverriddenOnExit: false,
                  factory: $EmailDraftRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'negotiate',
                  hasOverriddenOnExit: false,
                  factory: $NegotiationRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'offer',
                  hasOverriddenOnExit: false,
                  factory: $OfferFormRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'interview/new',
                  hasOverriddenOnExit: false,
                  factory: $InterviewNewRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'interview/:interviewId',
                  hasOverriddenOnExit: false,
                  factory: $InterviewEditRoute._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/resume',
          hasOverriddenOnExit: false,
          factory: $ResumeRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'basics',
              hasOverriddenOnExit: false,
              factory: $ProfileBasicsRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'import',
              hasOverriddenOnExit: false,
              factory: $ProfileImportRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'review',
              hasOverriddenOnExit: false,
              factory: $ProfileReviewRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'learning',
              hasOverriddenOnExit: false,
              factory: $LearningRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':id',
                  hasOverriddenOnExit: false,
                  factory: $LearningTopicRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'improve/:id',
              hasOverriddenOnExit: false,
              factory: $ImproveAchievementsRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'experience/new',
              hasOverriddenOnExit: false,
              factory: $ExperienceNewRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'experience/:id',
              hasOverriddenOnExit: false,
              factory: $ExperienceEditRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'education/new',
              hasOverriddenOnExit: false,
              factory: $EducationNewRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'education/:id',
              hasOverriddenOnExit: false,
              factory: $EducationEditRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'project/new',
              hasOverriddenOnExit: false,
              factory: $ProjectNewRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'project/:id',
              hasOverriddenOnExit: false,
              factory: $ProjectEditRoute._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/more',
          hasOverriddenOnExit: false,
          factory: $MoreRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'search',
              hasOverriddenOnExit: false,
              factory: $SearchPreferencesRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'gmail',
              hasOverriddenOnExit: false,
              factory: $GmailRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'reminders',
              hasOverriddenOnExit: false,
              factory: $RemindersRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'answers',
              hasOverriddenOnExit: false,
              factory: $AnswersRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'new',
                  hasOverriddenOnExit: false,
                  factory: $AnswerNewRoute._fromState,
                ),
                GoRouteData.$route(
                  path: ':id',
                  hasOverriddenOnExit: false,
                  factory: $AnswerEditRoute._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

extension $TabsShellRouteExtension on TabsShellRoute {
  static TabsShellRoute _fromState(GoRouterState state) =>
      const TabsShellRoute();
}

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $StatsRoute on GoRouteData {
  static StatsRoute _fromState(GoRouterState state) => const StatsRoute();

  @override
  String get location => GoRouteData.$location('/home/stats');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $JobsRoute on GoRouteData {
  static JobsRoute _fromState(GoRouterState state) => const JobsRoute();

  @override
  String get location => GoRouteData.$location('/jobs');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $JobNewRoute on GoRouteData {
  static JobNewRoute _fromState(GoRouterState state) =>
      JobNewRoute(shared: state.uri.queryParameters['shared']);

  JobNewRoute get _self => this as JobNewRoute;

  @override
  String get location => GoRouteData.$location(
    '/jobs/new',
    queryParams: {if (_self.shared != null) 'shared': _self.shared},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $JobDetailRoute on GoRouteData {
  static JobDetailRoute _fromState(GoRouterState state) =>
      JobDetailRoute(id: state.pathParameters['id']!);

  JobDetailRoute get _self => this as JobDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/jobs/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $JobCompanyRoute on GoRouteData {
  static JobCompanyRoute _fromState(GoRouterState state) =>
      JobCompanyRoute(id: state.pathParameters['id']!);

  JobCompanyRoute get _self => this as JobCompanyRoute;

  @override
  String get location =>
      GoRouteData.$location('/jobs/${Uri.encodeComponent(_self.id)}/company');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $JobPracticeRoute on GoRouteData {
  static JobPracticeRoute _fromState(GoRouterState state) =>
      JobPracticeRoute(id: state.pathParameters['id']!);

  JobPracticeRoute get _self => this as JobPracticeRoute;

  @override
  String get location =>
      GoRouteData.$location('/jobs/${Uri.encodeComponent(_self.id)}/practice');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $JobPrepareRoute on GoRouteData {
  static JobPrepareRoute _fromState(GoRouterState state) =>
      JobPrepareRoute(id: state.pathParameters['id']!);

  JobPrepareRoute get _self => this as JobPrepareRoute;

  @override
  String get location =>
      GoRouteData.$location('/jobs/${Uri.encodeComponent(_self.id)}/prepare');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $JobCompleteRoute on GoRouteData {
  static JobCompleteRoute _fromState(GoRouterState state) =>
      JobCompleteRoute(id: state.pathParameters['id']!);

  JobCompleteRoute get _self => this as JobCompleteRoute;

  @override
  String get location =>
      GoRouteData.$location('/jobs/${Uri.encodeComponent(_self.id)}/complete');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $JobContactRoute on GoRouteData {
  static JobContactRoute _fromState(GoRouterState state) =>
      JobContactRoute(id: state.pathParameters['id']!);

  JobContactRoute get _self => this as JobContactRoute;

  @override
  String get location =>
      GoRouteData.$location('/jobs/${Uri.encodeComponent(_self.id)}/contact');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $JobApplyEmailRoute on GoRouteData {
  static JobApplyEmailRoute _fromState(GoRouterState state) =>
      JobApplyEmailRoute(id: state.pathParameters['id']!);

  JobApplyEmailRoute get _self => this as JobApplyEmailRoute;

  @override
  String get location => GoRouteData.$location(
    '/jobs/${Uri.encodeComponent(_self.id)}/apply-email',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ApplicationsRoute on GoRouteData {
  static ApplicationsRoute _fromState(GoRouterState state) =>
      const ApplicationsRoute();

  @override
  String get location => GoRouteData.$location('/applications');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CompareOffersRoute on GoRouteData {
  static CompareOffersRoute _fromState(GoRouterState state) =>
      const CompareOffersRoute();

  @override
  String get location => GoRouteData.$location('/applications/compare');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ApplicationDetailRoute on GoRouteData {
  static ApplicationDetailRoute _fromState(GoRouterState state) =>
      ApplicationDetailRoute(id: state.pathParameters['id']!);

  ApplicationDetailRoute get _self => this as ApplicationDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/applications/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EmailDraftRoute on GoRouteData {
  static EmailDraftRoute _fromState(GoRouterState state) => EmailDraftRoute(
    id: state.pathParameters['id']!,
    kind: _$EmailDraftKindEnumMap._$fromName(state.pathParameters['kind']!)!,
  );

  EmailDraftRoute get _self => this as EmailDraftRoute;

  @override
  String get location => GoRouteData.$location(
    '/applications/${Uri.encodeComponent(_self.id)}/email/${Uri.encodeComponent(_$EmailDraftKindEnumMap[_self.kind]!)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

const _$EmailDraftKindEnumMap = {
  EmailDraftKind.followUp: 'follow-up',
  EmailDraftKind.thankYou: 'thank-you',
  EmailDraftKind.rejectionReply: 'rejection-reply',
};

mixin $NegotiationRoute on GoRouteData {
  static NegotiationRoute _fromState(GoRouterState state) =>
      NegotiationRoute(id: state.pathParameters['id']!);

  NegotiationRoute get _self => this as NegotiationRoute;

  @override
  String get location => GoRouteData.$location(
    '/applications/${Uri.encodeComponent(_self.id)}/negotiate',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $OfferFormRoute on GoRouteData {
  static OfferFormRoute _fromState(GoRouterState state) =>
      OfferFormRoute(id: state.pathParameters['id']!);

  OfferFormRoute get _self => this as OfferFormRoute;

  @override
  String get location => GoRouteData.$location(
    '/applications/${Uri.encodeComponent(_self.id)}/offer',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $InterviewNewRoute on GoRouteData {
  static InterviewNewRoute _fromState(GoRouterState state) =>
      InterviewNewRoute(id: state.pathParameters['id']!);

  InterviewNewRoute get _self => this as InterviewNewRoute;

  @override
  String get location => GoRouteData.$location(
    '/applications/${Uri.encodeComponent(_self.id)}/interview/new',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $InterviewEditRoute on GoRouteData {
  static InterviewEditRoute _fromState(GoRouterState state) =>
      InterviewEditRoute(
        id: state.pathParameters['id']!,
        interviewId: state.pathParameters['interviewId']!,
      );

  InterviewEditRoute get _self => this as InterviewEditRoute;

  @override
  String get location => GoRouteData.$location(
    '/applications/${Uri.encodeComponent(_self.id)}/interview/${Uri.encodeComponent(_self.interviewId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ResumeRoute on GoRouteData {
  static ResumeRoute _fromState(GoRouterState state) => const ResumeRoute();

  @override
  String get location => GoRouteData.$location('/resume');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProfileBasicsRoute on GoRouteData {
  static ProfileBasicsRoute _fromState(GoRouterState state) =>
      const ProfileBasicsRoute();

  @override
  String get location => GoRouteData.$location('/resume/basics');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProfileImportRoute on GoRouteData {
  static ProfileImportRoute _fromState(GoRouterState state) =>
      const ProfileImportRoute();

  @override
  String get location => GoRouteData.$location('/resume/import');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProfileReviewRoute on GoRouteData {
  static ProfileReviewRoute _fromState(GoRouterState state) =>
      const ProfileReviewRoute();

  @override
  String get location => GoRouteData.$location('/resume/review');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $LearningRoute on GoRouteData {
  static LearningRoute _fromState(GoRouterState state) => const LearningRoute();

  @override
  String get location => GoRouteData.$location('/resume/learning');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $LearningTopicRoute on GoRouteData {
  static LearningTopicRoute _fromState(GoRouterState state) =>
      LearningTopicRoute(id: state.pathParameters['id']!);

  LearningTopicRoute get _self => this as LearningTopicRoute;

  @override
  String get location => GoRouteData.$location(
    '/resume/learning/${Uri.encodeComponent(_self.id)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ImproveAchievementsRoute on GoRouteData {
  static ImproveAchievementsRoute _fromState(GoRouterState state) =>
      ImproveAchievementsRoute(id: state.pathParameters['id']!);

  ImproveAchievementsRoute get _self => this as ImproveAchievementsRoute;

  @override
  String get location =>
      GoRouteData.$location('/resume/improve/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ExperienceNewRoute on GoRouteData {
  static ExperienceNewRoute _fromState(GoRouterState state) =>
      const ExperienceNewRoute();

  @override
  String get location => GoRouteData.$location('/resume/experience/new');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ExperienceEditRoute on GoRouteData {
  static ExperienceEditRoute _fromState(GoRouterState state) =>
      ExperienceEditRoute(id: state.pathParameters['id']!);

  ExperienceEditRoute get _self => this as ExperienceEditRoute;

  @override
  String get location => GoRouteData.$location(
    '/resume/experience/${Uri.encodeComponent(_self.id)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EducationNewRoute on GoRouteData {
  static EducationNewRoute _fromState(GoRouterState state) =>
      const EducationNewRoute();

  @override
  String get location => GoRouteData.$location('/resume/education/new');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EducationEditRoute on GoRouteData {
  static EducationEditRoute _fromState(GoRouterState state) =>
      EducationEditRoute(id: state.pathParameters['id']!);

  EducationEditRoute get _self => this as EducationEditRoute;

  @override
  String get location => GoRouteData.$location(
    '/resume/education/${Uri.encodeComponent(_self.id)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProjectNewRoute on GoRouteData {
  static ProjectNewRoute _fromState(GoRouterState state) =>
      const ProjectNewRoute();

  @override
  String get location => GoRouteData.$location('/resume/project/new');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProjectEditRoute on GoRouteData {
  static ProjectEditRoute _fromState(GoRouterState state) =>
      ProjectEditRoute(id: state.pathParameters['id']!);

  ProjectEditRoute get _self => this as ProjectEditRoute;

  @override
  String get location =>
      GoRouteData.$location('/resume/project/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $MoreRoute on GoRouteData {
  static MoreRoute _fromState(GoRouterState state) => const MoreRoute();

  @override
  String get location => GoRouteData.$location('/more');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SearchPreferencesRoute on GoRouteData {
  static SearchPreferencesRoute _fromState(GoRouterState state) =>
      const SearchPreferencesRoute();

  @override
  String get location => GoRouteData.$location('/more/search');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $GmailRoute on GoRouteData {
  static GmailRoute _fromState(GoRouterState state) => const GmailRoute();

  @override
  String get location => GoRouteData.$location('/more/gmail');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $RemindersRoute on GoRouteData {
  static RemindersRoute _fromState(GoRouterState state) =>
      const RemindersRoute();

  @override
  String get location => GoRouteData.$location('/more/reminders');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AnswersRoute on GoRouteData {
  static AnswersRoute _fromState(GoRouterState state) => const AnswersRoute();

  @override
  String get location => GoRouteData.$location('/more/answers');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AnswerNewRoute on GoRouteData {
  static AnswerNewRoute _fromState(GoRouterState state) =>
      AnswerNewRoute($extra: state.extra as String?);

  AnswerNewRoute get _self => this as AnswerNewRoute;

  @override
  String get location => GoRouteData.$location('/more/answers/new');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $AnswerEditRoute on GoRouteData {
  static AnswerEditRoute _fromState(GoRouterState state) =>
      AnswerEditRoute(id: state.pathParameters['id']!);

  AnswerEditRoute get _self => this as AnswerEditRoute;

  @override
  String get location =>
      GoRouteData.$location('/more/answers/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

extension<T extends Enum> on Map<T, String> {
  T? _$fromName(String? value) =>
      entries.where((element) => element.value == value).firstOrNull?.key;
}
