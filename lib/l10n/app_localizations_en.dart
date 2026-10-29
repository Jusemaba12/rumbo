// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Rumbo';

  @override
  String get tabHome => 'Home';

  @override
  String get tabJobs => 'Jobs';

  @override
  String get tabApplications => 'Tracker';

  @override
  String get applicationsTitle => 'Applications';

  @override
  String get tabResume => 'Resume';

  @override
  String get tabMore => 'More';

  @override
  String get signInTitle => 'Sign in to Rumbo';

  @override
  String get signInSubtitle => 'We\'ll email you a sign-in code.';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailInvalid => 'Enter a valid email';

  @override
  String get sendCode => 'Send code';

  @override
  String get codeLabel => 'Code from the email';

  @override
  String get codeInvalid => 'The code has 6 to 10 digits';

  @override
  String get verifyCode => 'Sign in';

  @override
  String get changeEmail => 'Use another email';

  @override
  String get signInError =>
      'We couldn\'t sign you in. Check the value and try again.';

  @override
  String get signOut => 'Sign out';

  @override
  String get demoBanner =>
      'Local mode: not connected to the server. Data is not saved.';

  @override
  String get homeEmptyTitle => 'Your daily summary';

  @override
  String get homeEmptyBody =>
      'New jobs, pending follow-ups and upcoming interviews will show here.';

  @override
  String get jobsEmptyTitle => 'No jobs yet';

  @override
  String get jobsEmptyBody =>
      'Paste a job link or description to see how well it fits your profile.';

  @override
  String get applicationsEmptyTitle => 'No applications yet';

  @override
  String get applicationsEmptyBody =>
      'Prepare an application from a job, or tap “Track this job” in its details.';

  @override
  String get moreTitle => 'More';

  @override
  String get statusSaved => 'Saved';

  @override
  String get statusPreparing => 'Preparing';

  @override
  String get statusApplied => 'Applied';

  @override
  String get statusInReview => 'In review';

  @override
  String get statusTechnicalTest => 'Technical test';

  @override
  String get statusInterview => 'Interview';

  @override
  String get statusOffer => 'Offer';

  @override
  String get statusAccepted => 'Accepted';

  @override
  String get statusDeclined => 'Declined';

  @override
  String get statusRejected => 'Rejected';

  @override
  String get statusNoResponse => 'No response';

  @override
  String get profileTitle => 'Your profile';

  @override
  String profileCompleteness(int percent) {
    return 'Profile $percent% complete';
  }

  @override
  String get profileCompleteHint =>
      'Your profile has what it takes to build a good resume.';

  @override
  String get gapName => 'Add your name.';

  @override
  String get gapHeadline => 'Add a headline, e.g. “Senior Flutter Developer”.';

  @override
  String get gapExperience => 'Add your first work experience.';

  @override
  String get gapAchievements =>
      'Add achievements to every experience. Numbers help.';

  @override
  String gapSkills(int count) {
    return 'Add at least $count skills.';
  }

  @override
  String get gapSummary => 'Write a 2–3 sentence professional summary.';

  @override
  String get gapLink => 'Add your LinkedIn, GitHub or portfolio.';

  @override
  String get sectionBasics => 'Basics';

  @override
  String get sectionExperience => 'Experience';

  @override
  String get sectionProjects => 'Projects';

  @override
  String get sectionSkills => 'Skills';

  @override
  String get basicsEmpty => 'You haven\'t added your details yet.';

  @override
  String get experienceEmpty => 'No experience added yet.';

  @override
  String get projectsEmpty => 'No projects added yet.';

  @override
  String get skillsEmpty => 'No skills added yet.';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get saveError => 'Couldn\'t save. Try again.';

  @override
  String get loadError => 'Couldn\'t load your profile.';

  @override
  String get retry => 'Retry';

  @override
  String get requiredField => 'This field is required';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get headlineLabel => 'Headline';

  @override
  String get headlineHint => 'Senior Flutter Developer';

  @override
  String get locationLabel => 'Location';

  @override
  String get locationHint => 'Bogotá, Colombia';

  @override
  String get summaryLabel => 'Professional summary';

  @override
  String get linkedinLabel => 'LinkedIn';

  @override
  String get githubLabel => 'GitHub';

  @override
  String get portfolioLabel => 'Portfolio or website';

  @override
  String get urlInvalid => 'Enter a full link, e.g. https://…';

  @override
  String get experienceNew => 'New experience';

  @override
  String get experienceEdit => 'Edit experience';

  @override
  String get companyLabel => 'Company';

  @override
  String get roleLabel => 'Role';

  @override
  String get startDateLabel => 'Start';

  @override
  String get endDateLabel => 'End';

  @override
  String get currentJob => 'I currently work here';

  @override
  String get present => 'Present';

  @override
  String get endBeforeStart => 'End date must be after the start date';

  @override
  String get achievementsLabel => 'Achievements';

  @override
  String get achievementsHelper =>
      'One per line. Example: Cut startup time by 40%.';

  @override
  String get technologiesLabel => 'Technologies';

  @override
  String get technologiesHelper =>
      'Comma-separated: Flutter, Riverpod, Firebase';

  @override
  String get projectNew => 'New project';

  @override
  String get projectEdit => 'Edit project';

  @override
  String get projectNameLabel => 'Project name';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get projectUrlLabel => 'Link';

  @override
  String get skillNew => 'New skill';

  @override
  String get skillEdit => 'Edit skill';

  @override
  String get skillNameLabel => 'Skill';

  @override
  String get skillCategoryLabel => 'Category';

  @override
  String get skillYearsLabel => 'Years of experience';

  @override
  String skillYears(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years years',
      one: '1 year',
    );
    return '$_temp0';
  }

  @override
  String get categoryLanguage => 'Language';

  @override
  String get categoryFramework => 'Framework';

  @override
  String get categoryTool => 'Tool';

  @override
  String get categoryOther => 'Other';

  @override
  String deleteConfirmTitle(String name) {
    return 'Delete “$name”?';
  }

  @override
  String get deleteConfirmBody => 'This can\'t be undone.';

  @override
  String get importResume => 'Import resume PDF';

  @override
  String get importTitle => 'Import your resume';

  @override
  String get importIntro =>
      'Choose your resume as a PDF. AI will read it and show you what it found before adding anything to your profile.';

  @override
  String get importRules =>
      'Only empty fields are filled and new items added. What you already wrote stays as is.';

  @override
  String get importPick => 'Choose PDF';

  @override
  String get importReading => 'Reading your resume…';

  @override
  String get importReadingHint => 'This can take up to a minute.';

  @override
  String get importReviewTitle => 'This will be added to your profile';

  @override
  String get importNothingNew =>
      'Your profile already has everything we found in the PDF.';

  @override
  String get importFields => 'Basics';

  @override
  String get importApply => 'Add to my profile';

  @override
  String get importPickAnother => 'Choose another PDF';

  @override
  String get importDone => 'Profile updated from your resume.';

  @override
  String get importErrorTooLarge =>
      'The PDF is larger than 5 MB. Export a lighter version and try again.';

  @override
  String get importErrorUnreadable =>
      'Couldn\'t read the PDF. Make sure it isn\'t password-protected or a scanned image.';

  @override
  String get importErrorRateLimited =>
      'Too many requests right now. Wait a minute and try again.';

  @override
  String get importErrorOther =>
      'Couldn\'t import the resume. Check your connection and try again.';

  @override
  String get jobsLoadError => 'Couldn\'t load your jobs.';

  @override
  String get jobAdd => 'Add job';

  @override
  String get jobAddTitle => 'New job';

  @override
  String get jobUrlLabel => 'Job link';

  @override
  String get jobDescriptionLabel => 'Job description';

  @override
  String get jobDescriptionHelper =>
      'LinkedIn and Indeed block reading their pages: copy the description and paste it here.';

  @override
  String get jobFormEmpty => 'Paste the job link or description.';

  @override
  String get jobAnalyze => 'Analyze job';

  @override
  String get jobAnalyzing => 'Analyzing the job…';

  @override
  String get jobAnalyzingHint =>
      'Comparing the requirements with your profile.';

  @override
  String get jobNoDescription =>
      'We couldn\'t read the job from the link. Copy the description and paste it above.';

  @override
  String get aiErrorRateLimited =>
      'The AI usage limit was reached. Wait a minute and try again.';

  @override
  String get jobErrorOther =>
      'Couldn\'t analyze the job. Check your connection and try again.';

  @override
  String get jobSave => 'Save job';

  @override
  String get jobSaved => 'Job saved.';

  @override
  String get jobDuplicate => 'You already saved this job.';

  @override
  String get jobAnalyzeAnother => 'Go back and edit';

  @override
  String get jobDeleted => 'Job deleted.';

  @override
  String get jobNotFound => 'This job no longer exists.';

  @override
  String get jobOpenLink => 'Open job';

  @override
  String get jobRequirements => 'Requirements';

  @override
  String get jobDescription => 'Description';

  @override
  String get jobUnknownCompany => 'Company not listed';

  @override
  String get jobUntitled => 'Untitled job';

  @override
  String get matchTitle => 'Fit with your profile';

  @override
  String get matchMet => 'You have';

  @override
  String get matchMissing => 'You\'re missing';

  @override
  String matchScoreSemantics(int score) {
    return 'Fit: $score out of 100';
  }

  @override
  String get matchLevelHigh => 'High';

  @override
  String get matchLevelMedium => 'Medium';

  @override
  String get matchLevelLow => 'Low';

  @override
  String get workModeRemote => 'Remote';

  @override
  String get workModeHybrid => 'Hybrid';

  @override
  String get workModeOnsite => 'On-site';

  @override
  String get phoneLabel => 'Phone';

  @override
  String get phoneHint => '+1 555 000 0000';

  @override
  String get sectionEducation => 'Education';

  @override
  String get educationEmpty => 'No education added yet.';

  @override
  String get educationNew => 'New education';

  @override
  String get educationEdit => 'Edit education';

  @override
  String get institutionLabel => 'Institution';

  @override
  String get degreeLabel => 'Degree or program';

  @override
  String get studyingNow => 'I\'m currently studying here';

  @override
  String get prepareApplication => 'Prepare application';

  @override
  String get prepareTitle => 'Prepare application';

  @override
  String get preparing => 'Tailoring your resume…';

  @override
  String get preparingHint => 'This can take up to a minute.';

  @override
  String get prepareEmptyProfile =>
      'Add at least one work experience to your profile to tailor your resume.';

  @override
  String get prepareError =>
      'Couldn\'t prepare the application. Check your connection and try again.';

  @override
  String get tabResumePreview => 'Resume';

  @override
  String get tabCoverLetter => 'Letter';

  @override
  String get tabChanges => 'Changes';

  @override
  String get letterHelper => 'Review and adjust it before sending.';

  @override
  String get copyLetter => 'Copy letter';

  @override
  String get letterCopied => 'Letter copied.';

  @override
  String get keywordsCovered => 'Job keywords your resume covers';

  @override
  String get rejectedTitle => 'Discarded because it\'s not in your profile';

  @override
  String get rejectedBody =>
      'The AI suggested this, but it couldn\'t be checked against your data, so it wasn\'t used.';

  @override
  String get saveVersion => 'Save version';

  @override
  String get versionSavedShort => 'Saved';

  @override
  String get exportPdf => 'Export PDF';

  @override
  String get pdfError => 'Couldn\'t create the PDF. Try again.';

  @override
  String get aiErrorBusy =>
      'The free AI is overloaded right now. Try again in a few minutes.';

  @override
  String get boardActive => 'Active';

  @override
  String get boardClosed => 'Closed';

  @override
  String get followUpDue => 'Time to follow up';

  @override
  String followUpOn(String date) {
    return 'Follow up: $date';
  }

  @override
  String appliedDaysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Applied $days days ago',
      one: 'Applied 1 day ago',
      zero: 'Applied today',
    );
    return '$_temp0';
  }

  @override
  String get nextStepTitle => 'Update status';

  @override
  String get followUpTitle => 'Follow-up';

  @override
  String get followUpDoneButton => 'Done, remind me in 7 days';

  @override
  String get followUpChange => 'Change date';

  @override
  String get followUpNone => 'No follow-up scheduled.';

  @override
  String noResponseHint(int days) {
    return 'No response for $days days. You can mark it as “No response” and move on.';
  }

  @override
  String get notesLabel => 'Notes';

  @override
  String get notesHint => 'Contacts, impressions, interview questions…';

  @override
  String get notesSaved => 'Notes saved.';

  @override
  String get historyTitle => 'History';

  @override
  String historyCreated(String status) {
    return 'Created as “$status”';
  }

  @override
  String get viewJob => 'View job';

  @override
  String get trackJob => 'Track this job';

  @override
  String get viewProcess => 'View process';

  @override
  String get processStatus => 'Process status';

  @override
  String get actionPreparing => 'Prepare';

  @override
  String get actionSaved => 'Back to saved';

  @override
  String get actionApplied => 'I applied';

  @override
  String get actionInReview => 'It\'s in review';

  @override
  String get actionTechnicalTest => 'I got a test';

  @override
  String get actionInterview => 'I have an interview';

  @override
  String get actionOffer => 'I got an offer';

  @override
  String get actionAccepted => 'I accepted';

  @override
  String get actionDeclined => 'I declined';

  @override
  String get actionRejected => 'I was rejected';

  @override
  String get actionNoResponse => 'No response';

  @override
  String get homeFollowUps => 'Pending follow-ups';

  @override
  String get homeActive => 'Active processes';

  @override
  String get homeInterviews => 'Interviews and tests';

  @override
  String get homeJobs => 'Saved jobs';

  @override
  String get homeAllClear => 'No pending follow-ups.';

  @override
  String get homeStart => 'Start by adding a job in the Jobs tab.';

  @override
  String get searchPrefsTitle => 'Search preferences';

  @override
  String get searchPrefsIntro =>
      'Rumbo will search Get on Board, Remotive, Himalayas, Remote OK and We Work Remotely and suggest jobs that fit your profile.';

  @override
  String get searchRolesLabel => 'Roles';

  @override
  String get searchRolesHelper =>
      'Comma-separated: Flutter Developer, Mobile Developer';

  @override
  String get searchTechLabel => 'Key technologies';

  @override
  String get searchTechHelper => 'Comma-separated: Flutter, Dart';

  @override
  String get searchCountriesLabel => 'Countries you can work from';

  @override
  String get searchCountriesHelper =>
      'Comma-separated. Remote jobs limited to other countries are skipped.';

  @override
  String get searchWorkModes => 'Work mode';

  @override
  String get searchSources => 'Job boards';

  @override
  String searchMinScore(int score) {
    return 'Suggest from a fit of $score';
  }

  @override
  String get searchNeedsTerms => 'Enter at least one role or technology.';

  @override
  String get searchNeedsMode => 'Pick at least one work mode.';

  @override
  String get searchNeedsSource => 'Pick at least one job board.';

  @override
  String get searchSaved => 'Preferences saved.';

  @override
  String jobsTabSuggested(int count) {
    return 'Suggested ($count)';
  }

  @override
  String jobsTabSaved(int count) {
    return 'Saved ($count)';
  }

  @override
  String get searchNow => 'Search now';

  @override
  String get searchRunning => 'Searching for jobs…';

  @override
  String searchLastRun(String date) {
    return 'Last search: $date';
  }

  @override
  String get searchSetupTitle => 'Set up automatic search';

  @override
  String get searchSetupBody =>
      'Tell us which roles and technologies you\'re after and Rumbo will suggest jobs every day.';

  @override
  String get searchSetupButton => 'Set up search';

  @override
  String get searchNoSuggestions =>
      'No pending suggestions. Tap “Search now” or check back later.';

  @override
  String searchResult(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count new jobs suggested.',
      one: '1 new job suggested.',
      zero: 'No new jobs that fit your profile.',
    );
    return '$_temp0';
  }

  @override
  String searchSourcesFailed(String sources) {
    return 'Didn\'t respond: $sources.';
  }

  @override
  String get searchTooSoon =>
      'You just searched. Wait a few minutes to search again.';

  @override
  String get searchNoPreferences => 'Set up your search preferences first.';

  @override
  String get searchError => 'Couldn\'t finish the search. Try again.';

  @override
  String get suggestionKeep => 'Save job';

  @override
  String get suggestionDismiss => 'Dismiss';

  @override
  String get suggestionKept => 'Job saved.';

  @override
  String get suggestionDismissed => 'Suggestion dismissed.';

  @override
  String foundOn(String source) {
    return 'Found on $source';
  }

  @override
  String get homeSuggestions => 'New suggestions';

  @override
  String get watchedTitle => 'Companies you watch';

  @override
  String get watchedHelper =>
      'Paste the link to their jobs page on Greenhouse, Lever, Ashby, Workable, SmartRecruiters, Recruitee or Teamtailor. For example: jobs.ashbyhq.com/truelogic or apply.workable.com/huggingface';

  @override
  String get watchedLabel => 'Jobs page link';

  @override
  String get watchedAdd => 'Add company';

  @override
  String get watchedInvalid =>
      'We don\'t recognize that link. It must be from Greenhouse, Lever, Ashby, Workable, SmartRecruiters, Recruitee or Teamtailor.';

  @override
  String get watchedDuplicate => 'You already watch that company.';

  @override
  String watchedLimit(int count) {
    return 'You can watch up to $count companies.';
  }

  @override
  String get watchedEmpty => 'You don\'t watch any company yet.';

  @override
  String watchedRemove(String name) {
    return 'Stop watching $name';
  }

  @override
  String get statsTitle => 'Statistics';

  @override
  String get statsOpen => 'View statistics';

  @override
  String get statsFunnel => 'Funnel';

  @override
  String get statsFunnelSaved => 'On the board';

  @override
  String get statsFunnelApplied => 'Applied';

  @override
  String get statsFunnelResponded => 'Got a response';

  @override
  String get statsFunnelInterviews => 'Interviews or tests';

  @override
  String get statsFunnelOffers => 'Offers received';

  @override
  String statsResponseRate(int rate) {
    return '$rate% of your applications got a response.';
  }

  @override
  String statsResponseTime(String days) {
    return 'Companies take $days days on average to respond.';
  }

  @override
  String get statsNoApplications =>
      'Once you mark processes as “Applied” you\'ll see what share gets a response and how long companies take.';

  @override
  String get statsBySource => 'By source';

  @override
  String get statsSourceManual => 'Added by you';

  @override
  String statsSourceRow(int applied, int responded) {
    return '$applied applied · $responded responded';
  }

  @override
  String get statsGaps => 'What\'s asked most that you\'re missing';

  @override
  String statsGapsHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count analyzed jobs',
      one: '1 analyzed job',
    );
    return 'Based on $_temp0. Learning or highlighting these would pay off most.';
  }

  @override
  String get statsGapsEmpty =>
      'Analyze or save more jobs to see which requirements repeat.';

  @override
  String statsGapRow(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'in $count jobs',
      one: 'in 1 job',
    );
    return '$_temp0';
  }

  @override
  String get statsLoadError => 'Couldn\'t load statistics.';

  @override
  String get interviewsTitle => 'Interviews';

  @override
  String get interviewAdd => 'Schedule interview';

  @override
  String get interviewNew => 'New interview';

  @override
  String get interviewEdit => 'Edit interview';

  @override
  String get interviewKind => 'Type';

  @override
  String get kindScreening => 'Screening call';

  @override
  String get kindTechnical => 'Technical test';

  @override
  String get kindHr => 'HR';

  @override
  String get kindFinal => 'Final interview';

  @override
  String get kindOther => 'Other';

  @override
  String get interviewDate => 'Date';

  @override
  String get interviewTime => 'Time';

  @override
  String get interviewDuration => 'Duration (minutes)';

  @override
  String get interviewLocation => 'Link or place';

  @override
  String get interviewLocationHint => 'https://meet.google.com/… or address';

  @override
  String get interviewNotes => 'Notes';

  @override
  String get interviewNotesHint => 'Who with, what to prepare, questions…';

  @override
  String get interviewOutcome => 'Outcome';

  @override
  String get outcomePending => 'Pending';

  @override
  String get outcomePassed => 'Passed';

  @override
  String get outcomeFailed => 'Not passed';

  @override
  String interviewStatusChanged(String status) {
    return 'Interview saved. The process moved to “$status”.';
  }

  @override
  String get interviewSaved => 'Interview saved.';

  @override
  String get interviewsEmpty => 'No interviews scheduled.';

  @override
  String get homeUpcoming => 'Upcoming interviews';

  @override
  String get homeNoUpcoming => 'No upcoming interviews.';

  @override
  String get interviewJoin => 'Open link';

  @override
  String get interviewDurationInvalid => 'Between 5 and 600 minutes';

  @override
  String get gmailTitle => 'Connect Gmail';

  @override
  String get gmailIntro =>
      'Rumbo can read emails from the companies in your active processes and suggest status changes or interviews. You decide whether to apply them.';

  @override
  String get gmailHow =>
      'A small script in your Google account checks your email every hour. Your Gmail access never leaves Google: only emails that mention the companies in your processes and your LinkedIn job alerts are sent to Rumbo.';

  @override
  String get gmailPrivacy =>
      'With the free AI, Google may use those emails to improve its products.';

  @override
  String get gmailStep1 =>
      'Tap “Copy script”. It includes a personal key: don\'t share it.';

  @override
  String get gmailStep2 =>
      'Open script.google.com, create a new project, delete what\'s there and paste the script.';

  @override
  String get gmailStep3 =>
      'At the top, choose the “instalar” function and tap Run.';

  @override
  String get gmailStep4 =>
      'Authorize access with your Google account. If you see “Google hasn\'t verified this app”, go to Advanced → Go to (unsafe): the script is yours.';

  @override
  String get gmailCopy => 'Copy script';

  @override
  String get gmailCopied => 'Script copied. Paste it into script.google.com.';

  @override
  String get gmailRegenerate => 'Create a new key and copy';

  @override
  String get gmailRegenerateHint =>
      'The previous key will stop working: you\'ll need to paste the new script.';

  @override
  String get gmailDisconnect => 'Disconnect Gmail';

  @override
  String get gmailDisconnected => 'Gmail disconnected.';

  @override
  String get gmailNotConnected => 'You haven\'t connected Gmail yet.';

  @override
  String gmailWaiting(String date) {
    return 'Key created on $date. Waiting for the script to run for the first time.';
  }

  @override
  String gmailConnected(String date) {
    return 'Connected. The script last talked to Rumbo on $date.';
  }

  @override
  String get gmailOpenScript => 'Open script.google.com';

  @override
  String get emailUpdatesTitle => 'News from your email';

  @override
  String get emailApply => 'Apply';

  @override
  String get emailDismiss => 'Ignore';

  @override
  String get emailApplied => 'Suggestion applied.';

  @override
  String get emailDismissed => 'Suggestion ignored.';

  @override
  String emailProposal(String status) {
    return 'Suggests: $status';
  }

  @override
  String emailInterviewAt(String date) {
    return 'Date: $date';
  }

  @override
  String get practiceTitle => 'Interview practice';

  @override
  String get practiceOpen => 'Practice interview';

  @override
  String get practiceIntro =>
      'An AI interviewer will ask you questions about this job and assess each answer. Answer as in a real interview; you can dictate with the keyboard microphone.';

  @override
  String get practiceMode => 'Question type';

  @override
  String get modeTechnical => 'Technical';

  @override
  String get modeBehavioral => 'Behavioral';

  @override
  String get modeMixed => 'Mixed';

  @override
  String get practiceLanguage => 'Language';

  @override
  String get languageEs => 'Spanish';

  @override
  String get languageEn => 'English';

  @override
  String practiceCount(int count) {
    return '$count questions';
  }

  @override
  String get practiceStart => 'Start';

  @override
  String get practiceThinking => 'The interviewer is thinking…';

  @override
  String get practiceAnswerHint => 'Your answer…';

  @override
  String get practiceSend => 'Answer';

  @override
  String practiceQuestion(int number, int total) {
    return 'Question $number of $total';
  }

  @override
  String practiceScore(int score) {
    return '$score out of 5';
  }

  @override
  String get practiceStrengths => 'Good';

  @override
  String get practiceImprove => 'Improve';

  @override
  String get practiceBetter => 'Improved answer';

  @override
  String get practiceCopy => 'Copy';

  @override
  String get practiceCopied => 'Answer copied.';

  @override
  String get practiceSummary => 'Practice result';

  @override
  String get practiceAgain => 'Practice again';

  @override
  String get practiceError => 'Couldn\'t continue the practice. Try again.';

  @override
  String get practiceRetry => 'Retry';

  @override
  String get answersTitle => 'Answer bank';

  @override
  String get answersIntro =>
      'Prepare your answers to the questions that come up in almost every interview and copy them when you need them.';

  @override
  String get answersEmpty => 'Start with one of these common questions:';

  @override
  String get answersAdd => 'New answer';

  @override
  String get answerNew => 'New answer';

  @override
  String get answerEdit => 'Edit answer';

  @override
  String get answerQuestion => 'Question';

  @override
  String get answerText => 'Your answer';

  @override
  String get answerCopy => 'Copy';

  @override
  String get answerCopied => 'Answer copied.';

  @override
  String get answerSaveToBank => 'Save to bank';

  @override
  String get answerSavedToBank => 'Saved to your answer bank.';

  @override
  String get commonAboutYou => 'Tell me about yourself';

  @override
  String get commonWhyCompany => 'Why do you want to work with us?';

  @override
  String get commonSalary => 'What are your salary expectations?';

  @override
  String get commonWhyLeave => 'Why do you want to change jobs?';

  @override
  String get commonChallenge =>
      'Tell me about a technical challenge you solved';

  @override
  String get commonWeakness => 'What\'s your biggest area for improvement?';

  @override
  String get commonConflict =>
      'Tell me about a disagreement with a teammate and how you handled it';

  @override
  String get offerTitle => 'Offer details';

  @override
  String get offerEdit => 'Edit terms';

  @override
  String get offerAddDetails => 'Add terms';

  @override
  String get offerSalary => 'Salary';

  @override
  String get offerCurrency => 'Currency';

  @override
  String get offerPeriod => 'Period';

  @override
  String get periodMonth => 'Monthly';

  @override
  String get periodYear => 'Yearly';

  @override
  String get offerWorkMode => 'Work mode';

  @override
  String get offerStart => 'Start date';

  @override
  String get offerDeadline => 'Reply by';

  @override
  String get offerBenefits => 'Benefits';

  @override
  String get offerBenefitsHint =>
      'Health insurance, vacation, equipment, bonuses…';

  @override
  String get offerNotes => 'Notes';

  @override
  String get offerSaved => 'Terms saved.';

  @override
  String get offerNoDetails => 'You haven\'t added the terms yet.';

  @override
  String get offerSalaryInvalid => 'Enter a number without dots or symbols';

  @override
  String get offerCompare => 'Compare offers';

  @override
  String get compareTitle => 'Compare offers';

  @override
  String get compareEmpty =>
      'Once you mark a process as “Offer” you can compare its terms here.';

  @override
  String compareMonthly(String amount) {
    return '$amount per month';
  }

  @override
  String compareHighest(String currency) {
    return 'Best salary in $currency';
  }

  @override
  String get compareMixedCurrencies =>
      'The offers are in different currencies: compare them in the same currency before deciding.';

  @override
  String compareFit(int score) {
    return 'Fit $score';
  }

  @override
  String compareDeadline(String date) {
    return 'Reply by $date';
  }

  @override
  String get notSet => 'Not set';

  @override
  String get negotiateTitle => 'Prepare negotiation';

  @override
  String get negotiateOpen => 'Prepare negotiation';

  @override
  String get negotiateIntro =>
      'The AI drafts a reply to the company with your counteroffer and the arguments to back it, using your real achievements. Review it before sending.';

  @override
  String get negotiateTarget => 'Salary you want to propose';

  @override
  String get negotiateTargetHelper =>
      'Same currency and period as the offer. Leave empty to ask to review the terms.';

  @override
  String get negotiatePriorities => 'What else matters to you';

  @override
  String get negotiatePrioritiesHint =>
      'Start date, vacation days, equipment, schedule…';

  @override
  String get negotiateEnglish => 'Write the reply in English';

  @override
  String get negotiateGenerate => 'Prepare reply';

  @override
  String get negotiateGenerating => 'Preparing the reply…';

  @override
  String get negotiateEmail => 'Reply to the company';

  @override
  String get negotiatePoints => 'Points for the call';

  @override
  String get negotiateRisks => 'Before accepting, confirm';

  @override
  String get negotiateError => 'Couldn\'t prepare the reply. Try again.';

  @override
  String get briefTitle => 'Company brief';

  @override
  String get briefOpen => 'Company brief';

  @override
  String get briefIntro =>
      'A summary of the company and the role based on the job post, with questions for the interview.';

  @override
  String get briefGenerate => 'Prepare brief';

  @override
  String get briefRegenerate => 'Prepare again';

  @override
  String get briefGenerating => 'Preparing the brief…';

  @override
  String get briefError => 'Couldn\'t prepare the brief. Try again.';

  @override
  String get briefTeam => 'Team and tech';

  @override
  String get briefCulture => 'Culture and benefits';

  @override
  String get briefQuestions => 'Questions to ask them';

  @override
  String get briefRedFlags => 'Worth clarifying';

  @override
  String get briefGeneral => 'General information (not from the job post)';

  @override
  String briefGeneratedAt(String date) {
    return 'Prepared on $date';
  }

  @override
  String homeGreeting(String name) {
    return 'Hi, $name';
  }

  @override
  String get homeGreetingNoName => 'Hi';

  @override
  String get homeToday => 'For today';

  @override
  String homeTaskCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks',
      one: '1 task',
    );
    return '$_temp0';
  }

  @override
  String get homeAllDoneTitle => 'All caught up';

  @override
  String get homeAllDoneBody =>
      'Nothing pending. The next automatic search runs tomorrow at 7:00.';

  @override
  String homeTaskFollowUp(String company) {
    return 'Follow up with $company';
  }

  @override
  String get homeTaskInterview => 'Prepare your interview';

  @override
  String get homeMetricActive => 'Active';

  @override
  String get homeMetricInterviews => 'Interviews';

  @override
  String get homeMetricSuggested => 'Suggested';

  @override
  String get applicationsNeedsAction => 'Needs action';

  @override
  String get profileCompleteLabel => 'Profile complete';

  @override
  String get resumeMissingContact =>
      'Your resume is missing your email or phone. Add them to your basic details so companies can reach you.';

  @override
  String filterGoodMatch(int score) {
    return 'Score ≥ $score';
  }

  @override
  String filterRecent(int days) {
    return 'Last $days days';
  }

  @override
  String get filterSource => 'Source';

  @override
  String get filterAllSources => 'All sources';

  @override
  String get filterClear => 'Clear filters';

  @override
  String get filterNoResults => 'No jobs match these filters.';

  @override
  String dismissedTitle(int count) {
    return 'Dismissed · $count';
  }

  @override
  String get dismissedHint => 'The ones you dismissed in the last 30 days.';

  @override
  String get dismissedRestore => 'Restore';

  @override
  String get suggestionRestored => 'Job restored: it\'s back in Suggested.';

  @override
  String get pasteFromClipboard => 'Paste';

  @override
  String get clipboardEmpty => 'Nothing copied.';

  @override
  String get reviewTitle => 'ATS review';

  @override
  String get reviewCardBody =>
      'Check your base resume the way an ATS reads it and see what to improve.';

  @override
  String get reviewScoreCaption => 'Your base resume score';

  @override
  String get reviewAllGood =>
      'Your resume passes every check. Now look at the keywords for your target roles.';

  @override
  String reviewIssuesTitle(int count) {
    return 'To improve · $count';
  }

  @override
  String get reviewFix => 'Fix';

  @override
  String get severityHigh => 'Important';

  @override
  String get severityMedium => 'Recommended';

  @override
  String get severityLow => 'Detail';

  @override
  String get issueNoName => 'Your name is missing.';

  @override
  String get issueNoEmail =>
      'Your email is missing: companies can\'t reach you.';

  @override
  String get issueNoPhone => 'Your phone is missing.';

  @override
  String get issueNoHeadline =>
      'Add a headline such as “Flutter Developer”: it\'s the first thing an ATS reads.';

  @override
  String get issueNoSummary =>
      'Add a summary: 3 or 4 sentences on what you do and what you\'ve achieved.';

  @override
  String issueShortSummary(int count) {
    return 'Your summary is short ($count characters). Aim for 300-600.';
  }

  @override
  String issueLongSummary(int count) {
    return 'Your summary is long ($count characters). Keep it under 700.';
  }

  @override
  String get issueNoLink => 'Add your LinkedIn, GitHub or portfolio.';

  @override
  String get issueNoExperience => 'Add your work experience.';

  @override
  String issueNoAchievements(String role, String company) {
    return '$role at $company: no achievements yet.';
  }

  @override
  String issueFewNumbers(String role, String company, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count achievements without numbers',
      one: '1 achievement without numbers',
    );
    return '$role at $company: $_temp0. Add percentages, times, users or volume.';
  }

  @override
  String issueWeakStart(String role, String company, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count achievements start',
      one: '1 achievement starts',
    );
    return '$role at $company: $_temp0 as a duty (“Responsible for…”). Start with an action verb: “Reduced”, “Launched”, “Automated”.';
  }

  @override
  String issueLongBullets(String role, String company, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count achievements are too long',
      one: '1 achievement is too long',
    );
    return '$role at $company: $_temp0. One or two lines each.';
  }

  @override
  String issueFewSkills(int count) {
    return 'You have $count skills. Add at least 5.';
  }

  @override
  String get issueNoEducation => 'Add your education.';

  @override
  String get keywordsTitle => 'Keywords for your roles';

  @override
  String get keywordsHint =>
      'AI lists what ATS look for in your target roles and Rumbo checks which ones appear in your resume.';

  @override
  String get keywordsLoad => 'Find keywords';

  @override
  String get keywordsReload => 'Search again';

  @override
  String keywordsPresent(int count) {
    return 'In your resume · $count';
  }

  @override
  String keywordsMissing(int count) {
    return 'Missing · $count';
  }

  @override
  String get keywordsMissingHint =>
      'If you really know them, add them to your achievements or skills. Tap one to add it as a skill.';

  @override
  String get keywordsNoRoles =>
      'Add your target roles in Search preferences to find their keywords.';

  @override
  String get keywordsError => 'Couldn\'t get the keywords. Please try again.';

  @override
  String get remindersTitle => 'Reminders';

  @override
  String get remindersHint =>
      'Alerts on this phone, even when Rumbo is closed. No internet needed.';

  @override
  String get remindersProcesses => 'Follow-ups and interviews';

  @override
  String get remindersProcessesHint =>
      'On follow-up day at 9:00, the evening before each interview at 19:00 and one hour before.';

  @override
  String get remindersDaily => 'Daily reminder';

  @override
  String get remindersDailyHint =>
      'Every day at 8:00, to check suggestions and tasks.';

  @override
  String get remindersDenied =>
      'Rumbo notifications are turned off. Turn them on in your phone settings.';

  @override
  String remindersPlanned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reminders scheduled.',
      one: '1 reminder scheduled.',
      zero: 'No reminders scheduled.',
    );
    return '$_temp0';
  }

  @override
  String get remindersTest => 'Send a test reminder';

  @override
  String get reminderTestTitle => 'This is how your reminders will look';

  @override
  String get reminderTestBody =>
      'Rumbo will remind you of follow-ups and interviews.';

  @override
  String get reminderFollowUpTitle => 'Time to follow up';

  @override
  String reminderFollowUpBody(String role, String company) {
    return '$role at $company: write to the company to ask how it\'s going.';
  }

  @override
  String get reminderEveTitle => 'Interview tomorrow';

  @override
  String reminderEveBody(String company, String time) {
    return '$company at $time. Review the company brief and practice a few minutes.';
  }

  @override
  String get reminderSoonTitle => 'Interview in one hour';

  @override
  String reminderSoonBody(String company, String time) {
    return '$company at $time. Good luck!';
  }

  @override
  String get reminderDailyTitle => 'Check your search';

  @override
  String get reminderDailyBody =>
      'Look at your new suggestions and today\'s tasks in Rumbo.';

  @override
  String get aiErrorDailyLimit =>
      'You\'ve reached today\'s AI limit in Rumbo. Please try again tomorrow.';

  @override
  String get welcomeTitle => 'Before you start';

  @override
  String get welcomeIntro =>
      'Rumbo helps you find jobs, tailor your resume with AI and track every process up to the offer.';

  @override
  String get welcomeDataTitle => 'How your data is used';

  @override
  String get welcomePrivate =>
      'Your profile, jobs and processes are stored in a private database: only you can see them.';

  @override
  String get welcomeAi =>
      'To analyze jobs and tailor your resume, Rumbo sends the needed text to Google Gemini on its free tier. Google may use that content to improve its products, so don\'t include sensitive data such as your ID number.';

  @override
  String welcomeLimit(int limit) {
    return 'Each person can use the AI up to $limit times a day.';
  }

  @override
  String get welcomeDelete =>
      'You can delete your account and all your data at any time from More.';

  @override
  String get welcomeAccept => 'I agree, let\'s start';

  @override
  String get welcomeLeave => 'Leave';

  @override
  String get firstStepsTitle => 'First steps';

  @override
  String get firstStepsProfile =>
      'Complete your resume: import your PDF or type your details';

  @override
  String get firstStepsSearch => 'Tell Rumbo which roles you\'re looking for';

  @override
  String get firstStepsGmail => 'Optional: connect Gmail to detect replies';

  @override
  String updateAvailable(String version) {
    return 'A new version of Rumbo is available ($version).';
  }

  @override
  String get updateDownload => 'Download';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get deleteAccountTitle => 'Delete your account?';

  @override
  String get deleteAccountBody =>
      'Your profile, jobs, processes, interviews and everything else will be deleted. This can\'t be undone.';

  @override
  String get deleteAccountConfirm => 'Delete everything';

  @override
  String get deleteAccountError =>
      'Couldn\'t delete the account. Please try again.';

  @override
  String get reviewRefresh => 'Review again';

  @override
  String reviewScoreUp(int from, int to) {
    return 'Review updated: your score went up from $from to $to.';
  }

  @override
  String reviewScoreDown(int from, int to) {
    return 'Review updated: your score went down from $from to $to.';
  }

  @override
  String reviewScoreSame(int score) {
    return 'Review updated: your score is still $score.';
  }

  @override
  String get categoryContact => 'Contact';

  @override
  String get categoryStructure => 'Structure';

  @override
  String get categoryAchievements => 'Achievements';

  @override
  String get categoryCoherence => 'Consistency and keywords';

  @override
  String get categoryFormat => 'Format';

  @override
  String get reviewCategoriesTitle => 'Score by part';

  @override
  String reviewCategoryIssues(String category, int count) {
    return '$category · $count';
  }

  @override
  String reviewHistoryStart(int score) {
    return 'You started at $score';
  }

  @override
  String get issueInvalidEmail =>
      'Your email doesn\'t look valid. Check it\'s spelled correctly.';

  @override
  String get issuePhoneNoCountryCode =>
      'Add your country code (+57): many remote companies are abroad.';

  @override
  String get issueNoLocation =>
      'Add your city and country: ATS filter by location.';

  @override
  String issueInvalidLink(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count links aren\'t valid',
      one: 'One link isn\'t valid',
    );
    return '$_temp0: they must start with https://.';
  }

  @override
  String issueEndBeforeStart(String role, String company) {
    return '$role at $company: the end date is before the start date.';
  }

  @override
  String issueFutureDate(String role, String company) {
    return '$role at $company: it has a date in the future.';
  }

  @override
  String issueDateGap(int count, String role, String company) {
    return 'There\'s a $count-month gap before $role at $company. If you studied or freelanced, add it.';
  }

  @override
  String issueSeveralCurrent(int count) {
    return 'You have $count jobs marked as current. Add an end date to the ones that ended.';
  }

  @override
  String issueFirstPerson(String role, String company, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count achievements are',
      one: '1 achievement is',
    );
    return '$role at $company: $_temp0 written in first person (“I”, “my”). Write them without a subject: “Reduced…”, “Launched…”.';
  }

  @override
  String issueDuplicates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count achievements are repeated',
      one: '1 achievement is repeated',
    );
    return '$_temp0 across jobs.';
  }

  @override
  String issueBuzzwords(String words) {
    return 'Avoid empty phrases like “$words”: prove it with a concrete achievement.';
  }

  @override
  String issueTechNotInSkills(String words, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'they aren\'t',
      one: 'it isn\'t',
    );
    return 'You use $words in your experience but $_temp0 in Skills. Add them: ATS search that section.';
  }

  @override
  String issueHeadlineNoRole(String role) {
    return 'Your headline doesn\'t mention the role you want (“$role”). ATS compare the headline with the job.';
  }

  @override
  String get issueSummaryNoTech =>
      'Your summary doesn\'t mention your main technologies.';

  @override
  String get issueSummaryNoYears =>
      'Say in your summary how many years of experience you have, e.g. “3 years with Flutter”.';

  @override
  String issueSpecialCharacters(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count texts have',
      one: '1 text has',
    );
    return '$_temp0 emojis or symbols (★, ✔, •) that ATS read poorly.';
  }

  @override
  String issueAllCaps(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count texts are',
      one: '1 text is',
    );
    return '$_temp0 in CAPITALS. Write them in normal case.';
  }

  @override
  String get issueMixedLanguages =>
      'You mix Spanish and English in your resume. Use one language: Rumbo translates it when tailoring.';

  @override
  String issueTooLong(int count) {
    return 'Your resume has $count words: over two pages. Trim old or less relevant achievements.';
  }

  @override
  String issueTooShort(int count) {
    return 'Your resume has only $count words. Add achievements so the ATS has something to compare.';
  }

  @override
  String keywordsInExperience(int count) {
    return 'In your experience · $count';
  }

  @override
  String keywordsOnlySkills(int count) {
    return 'Only in Skills · $count';
  }

  @override
  String get keywordsOnlySkillsHint =>
      'Mention them in an achievement: ATS value a technology used in your experience more than one in a list.';

  @override
  String keywordsMarketHint(int count) {
    return 'The number is how many of your $count jobs mention it.';
  }

  @override
  String keywordsUpdated(String date) {
    return 'Updated on $date.';
  }

  @override
  String get atsTest => 'Test how an ATS reads it';

  @override
  String get atsTestTitle => 'How an ATS reads your PDF';

  @override
  String atsTestSummary(int passed, int total) {
    return '$passed of $total checks passed';
  }

  @override
  String get atsName => 'Name';

  @override
  String get atsEmail => 'Email';

  @override
  String get atsPhone => 'Phone';

  @override
  String get atsLink => 'Link (LinkedIn or portfolio)';

  @override
  String get atsLocation => 'City and country';

  @override
  String get atsSections =>
      'Sections: summary, experience, education and skills';

  @override
  String get atsExperiences => 'Roles and companies';

  @override
  String get atsDates => 'Dates of each job';

  @override
  String get atsSkills => 'Skills';

  @override
  String get atsCharacters => 'No broken characters';

  @override
  String atsCompleteness(String percent) {
    return 'Complete text ($percent% read)';
  }

  @override
  String atsPages(String pages) {
    return 'Length: $pages pages (max 2)';
  }

  @override
  String atsMissing(String detail) {
    return 'Not found: $detail';
  }

  @override
  String get atsExtractedText => 'Text the ATS reads';

  @override
  String get atsError => 'Couldn\'t read the PDF. Please try again.';

  @override
  String get coverageTitle => 'Keywords for this job';

  @override
  String coverageHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count keywords found',
      one: '1 keyword found',
    );
    return '$_temp0 in the job.';
  }

  @override
  String get coverageBase => 'Your base resume';

  @override
  String get coverageTailored => 'Tailored resume';

  @override
  String coverageMissing(String words) {
    return 'Still missing: $words. Add them only if you really know them.';
  }

  @override
  String get improveWithAi => 'Improve with AI';

  @override
  String get improveTitle => 'Improve achievements';

  @override
  String get improveHint =>
      'AI suggests and you decide. Fill the [bracketed] gaps with your real data: it never invents numbers.';

  @override
  String get improveBefore => 'Before';

  @override
  String get improveNew => 'New achievement';

  @override
  String get improveUse => 'Use';

  @override
  String get improveFill =>
      'Fill the bracketed gaps in the achievements you\'re going to use.';

  @override
  String get improveSave => 'Save achievements';

  @override
  String get improveSaved => 'Achievements updated.';

  @override
  String get improveEmpty =>
      'Your achievements are already well written: AI suggests no changes.';

  @override
  String get improveLoading => 'Reviewing your achievements…';

  @override
  String get emailDraftsTitle => 'Write to the company';

  @override
  String get emailDraftsHint =>
      'AI drafts the email; you review it and send it from your mail app.';

  @override
  String get emailKindFollowUp => 'Follow-up';

  @override
  String get emailKindThankYou => 'Thank for the interview';

  @override
  String get emailKindRejection => 'Reply to rejection';

  @override
  String get emailDraftTitle => 'Email draft';

  @override
  String get emailDraftWriting => 'Writing the email…';

  @override
  String get emailTo => 'To';

  @override
  String get emailSubject => 'Subject';

  @override
  String get emailBody => 'Message';

  @override
  String get emailCopy => 'Copy';

  @override
  String get emailCopied => 'Email copied. Paste it in your mail app.';

  @override
  String get emailOpen => 'Open in mail';

  @override
  String get emailOpenError => 'Couldn\'t open the mail app. Use “Copy”.';

  @override
  String get emailRegenerate => 'Another version';

  @override
  String get emailReviewHint =>
      'Review the text before sending: Rumbo never sends emails for you.';

  @override
  String get learningTitle => 'Learning plan';

  @override
  String get learningCardEmpty =>
      'Find out what to learn based on what your jobs ask for.';

  @override
  String learningCardSummary(int topics, int learning, int mastered) {
    String _temp0 = intl.Intl.pluralLogic(
      topics,
      locale: localeName,
      other: '$topics topics',
      one: '1 topic',
    );
    return '$_temp0 · $learning learning · $mastered mastered';
  }

  @override
  String get learningMine => 'Your plan';

  @override
  String get learningSuggestions => 'What you should learn';

  @override
  String get learningSuggestionsHint =>
      'What your jobs ask for that isn\'t in your resume. The number is how many of your jobs mention it.';

  @override
  String get learningNoSuggestions =>
      'No suggestions yet. Find your roles\' keywords in the ATS review or analyze more jobs.';

  @override
  String get learningOpenReview => 'Go to ATS review';

  @override
  String get learningAdd => 'Add to plan';

  @override
  String learningAdded(String topic) {
    return '“$topic” added to your plan.';
  }

  @override
  String learningDemand(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'In $count jobs',
      one: 'In 1 job',
      zero: 'Not in your jobs',
    );
    return '$_temp0';
  }

  @override
  String get learningStatusPending => 'To do';

  @override
  String get learningStatusLearning => 'Learning';

  @override
  String get learningStatusMastered => 'Mastered';

  @override
  String get learningGenerate => 'Create plan with AI';

  @override
  String get learningGenerating => 'Preparing your plan…';

  @override
  String get learningRegenerate => 'Another plan';

  @override
  String get learningWhy => 'Why they ask for it';

  @override
  String get learningSteps => 'Steps';

  @override
  String get learningResources => 'Free resources';

  @override
  String get learningNoResources =>
      'The links couldn\'t be verified. Look for the topic\'s official documentation.';

  @override
  String get learningProject => 'Mini project to prove it';

  @override
  String learningHours(int hours) {
    return 'About $hours hours';
  }

  @override
  String get learningMasteredTitle => 'You\'ve got it!';

  @override
  String get learningMasteredBody =>
      'Add it to your skills and mention it in an achievement: your ATS score and match go up.';

  @override
  String get learningAddSkill => 'Add to skills';

  @override
  String get learningAlreadySkill => 'It\'s already in your skills.';

  @override
  String get learningDelete => 'Remove from plan';

  @override
  String get learningPlanHint =>
      'AI suggests steps, resources and a project. Links are checked before you see them.';

  @override
  String get watchedSuggestions => 'Flutter suggestions';

  @override
  String get watchedSuggestionsHint =>
      'Companies that work with Flutter and hire remotely from Colombia.';

  @override
  String watchedSuggestionNote(String company) {
    String _temp0 = intl.Intl.selectLogic(company, {
      'canonical': 'Ubuntu uses Flutter · remote worldwide',
      'flutterflow': 'Flutter app builder · remote global',
      'truelogic': 'Developers for US clients · remote LATAM and Bogotá',
      'supabase': 'Flutter SDK · remote global and Americas',
      'revenuecat': 'Flutter SDK · remote Americas',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get gmailLinkedinTitle => 'LinkedIn job alerts';

  @override
  String get gmailLinkedinBody =>
      'Create job alerts on LinkedIn (for example «Flutter Developer», remote). When they reach your Gmail, Rumbo turns each job into a suggestion in Jobs with its match. The score comes from the title, since the email doesn\'t include the full description.';

  @override
  String get gmailLinkedinUpdate =>
      'Your script predates LinkedIn alerts. Tap «Generate new key and copy», paste the script again into your project and run «instalar».';

  @override
  String get jobCompleteTitle => 'Complete job';

  @override
  String get jobCompleteHint =>
      'Paste the full job description: open it on LinkedIn or its job board and copy the text. Rumbo will analyze it and recalculate your match. The title, company, link and its process are kept.';

  @override
  String get jobCompleteLabel => 'Full description';

  @override
  String get jobCompleteAction => 'Analyze and complete';

  @override
  String jobCompleted(int score) {
    return 'Job completed. Match: $score.';
  }

  @override
  String jobCompleteTooShort(int count) {
    return 'Paste at least $count characters of the description.';
  }

  @override
  String get jobNeedsDescription =>
      'This job arrived without its full description: the match comes only from the title.';

  @override
  String get jobUpdateDescription => 'Complete or change the description';

  @override
  String get englishLevelLabel => 'English level';

  @override
  String get englishLevelHelper =>
      'The AI uses it when a job asks for English.';

  @override
  String get englishLevelNone => 'Not specified';

  @override
  String get englishLevelA1 => 'Beginner (A1)';

  @override
  String get englishLevelA2 => 'Elementary (A2)';

  @override
  String get englishLevelB1 => 'Intermediate (B1)';

  @override
  String get englishLevelB2 => 'Upper intermediate (B2)';

  @override
  String get englishLevelC1 => 'Advanced (C1)';

  @override
  String get englishLevelC2 => 'Proficient (C2)';

  @override
  String get englishLevelNative => 'Native or bilingual';

  @override
  String get salaryTitle => 'Salary expectation (gross per month)';

  @override
  String get salaryHelper =>
      'The AI compares it with the salary in each job. You can fill in just one currency.';

  @override
  String salaryMinLabel(String currency) {
    return 'Minimum $currency';
  }

  @override
  String salaryMaxLabel(String currency) {
    return 'Maximum $currency';
  }

  @override
  String get salaryRangeInvalid =>
      'The maximum can\'t be lower than the minimum.';

  @override
  String profileEnglish(String level) {
    return 'English: $level';
  }

  @override
  String profileSalary(String range) {
    return 'Expectation: $range per month';
  }

  @override
  String get contactTitle => 'Contact and how to apply';

  @override
  String get contactAdd => 'Add recruiter contact';

  @override
  String get contactEmailCopied => 'Email copied.';

  @override
  String get contactLinkedin => 'LinkedIn profile or post';

  @override
  String contactSubject(String subject) {
    return 'Subject: «$subject»';
  }

  @override
  String get contactAsksSalary => 'They ask for your salary expectation';

  @override
  String get contactNameLabel => 'Recruiter';

  @override
  String get contactEmailLabel => 'Email to apply';

  @override
  String get contactLinkedinLabel => 'Recruiter\'s LinkedIn or the post';

  @override
  String get contactLinkedinHelper => 'A linkedin.com link.';

  @override
  String get contactSubjectLabel => 'Requested subject';

  @override
  String get contactSubjectHelper =>
      'Copy it exactly: some recruiters filter emails by subject.';

  @override
  String get contactAsksSalaryLabel => 'They ask for a salary expectation';

  @override
  String get applyMethodLabel => 'How to apply';

  @override
  String get applyMethodNone => 'Not specified';

  @override
  String get applyMethodEmail => 'By email';

  @override
  String get applyMethodDirectMessage => 'By direct message on LinkedIn';

  @override
  String get applyMethodPortal => 'On their site or form';

  @override
  String get applyEmailTitle => 'Apply by email';

  @override
  String get applyNeedsResume =>
      'First prepare the resume tailored to this job: it\'s the one attached to the email.';

  @override
  String get applyPrepareResume => 'Prepare tailored resume';

  @override
  String get applyReviewHint =>
      'Review the email. Opening it in your mail app attaches the tailored resume as a PDF; Rumbo sends nothing.';

  @override
  String get applyPlaceholders =>
      'Fill in what\'s in brackets before opening the email.';

  @override
  String get applyOpen => 'Open in mail with the resume';

  @override
  String get applyRecipientCopied => 'Recipient copied: paste it in «To».';

  @override
  String get applyWebHint =>
      'The resume was downloaded: attach it to the email that opened.';

  @override
  String get applySentQuestion => 'Did you send it?';

  @override
  String get applyMarkApplied => 'Mark as applied';

  @override
  String get applyMarked => 'Marked as applied.';

  @override
  String get downloadResume => 'Download resume';
}
