import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'language/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appName.
  ///
  /// In es, this message translates to:
  /// **'Rumbo'**
  String get appName;

  /// No description provided for @tabHome.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get tabHome;

  /// No description provided for @tabJobs.
  ///
  /// In es, this message translates to:
  /// **'Ofertas'**
  String get tabJobs;

  /// No description provided for @tabApplications.
  ///
  /// In es, this message translates to:
  /// **'Procesos'**
  String get tabApplications;

  /// No description provided for @applicationsTitle.
  ///
  /// In es, this message translates to:
  /// **'Postulaciones'**
  String get applicationsTitle;

  /// No description provided for @tabResume.
  ///
  /// In es, this message translates to:
  /// **'HV'**
  String get tabResume;

  /// No description provided for @tabMore.
  ///
  /// In es, this message translates to:
  /// **'Más'**
  String get tabMore;

  /// No description provided for @signInTitle.
  ///
  /// In es, this message translates to:
  /// **'Entra a Rumbo'**
  String get signInTitle;

  /// No description provided for @signInSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Te enviamos un código de acceso a tu correo.'**
  String get signInSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo'**
  String get emailLabel;

  /// No description provided for @emailInvalid.
  ///
  /// In es, this message translates to:
  /// **'Escribe un correo válido'**
  String get emailInvalid;

  /// No description provided for @sendCode.
  ///
  /// In es, this message translates to:
  /// **'Enviar código'**
  String get sendCode;

  /// No description provided for @codeLabel.
  ///
  /// In es, this message translates to:
  /// **'Código del correo'**
  String get codeLabel;

  /// No description provided for @codeInvalid.
  ///
  /// In es, this message translates to:
  /// **'El código tiene entre 6 y 10 dígitos'**
  String get codeInvalid;

  /// No description provided for @verifyCode.
  ///
  /// In es, this message translates to:
  /// **'Entrar'**
  String get verifyCode;

  /// No description provided for @changeEmail.
  ///
  /// In es, this message translates to:
  /// **'Usar otro correo'**
  String get changeEmail;

  /// No description provided for @signInError.
  ///
  /// In es, this message translates to:
  /// **'No pudimos completar el acceso. Revisa el dato e inténtalo de nuevo.'**
  String get signInError;

  /// No description provided for @signOut.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get signOut;

  /// No description provided for @demoBanner.
  ///
  /// In es, this message translates to:
  /// **'Modo local: sin conexión al servidor. Los datos no se guardan.'**
  String get demoBanner;

  /// No description provided for @homeEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'Tu resumen del día'**
  String get homeEmptyTitle;

  /// No description provided for @jobsEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay ofertas'**
  String get jobsEmptyTitle;

  /// No description provided for @jobsEmptyBody.
  ///
  /// In es, this message translates to:
  /// **'Pega el enlace o la descripción de una oferta y verás si encaja con tu perfil.'**
  String get jobsEmptyBody;

  /// No description provided for @applicationsEmptyTitle.
  ///
  /// In es, this message translates to:
  /// **'Aún no tienes postulaciones'**
  String get applicationsEmptyTitle;

  /// No description provided for @applicationsEmptyBody.
  ///
  /// In es, this message translates to:
  /// **'Prepara una postulación desde una oferta o pulsa «Seguir esta oferta» en su detalle.'**
  String get applicationsEmptyBody;

  /// No description provided for @moreTitle.
  ///
  /// In es, this message translates to:
  /// **'Más'**
  String get moreTitle;

  /// No description provided for @statusSaved.
  ///
  /// In es, this message translates to:
  /// **'Guardada'**
  String get statusSaved;

  /// No description provided for @statusPreparing.
  ///
  /// In es, this message translates to:
  /// **'Preparando'**
  String get statusPreparing;

  /// No description provided for @statusApplied.
  ///
  /// In es, this message translates to:
  /// **'Postulada'**
  String get statusApplied;

  /// No description provided for @statusInReview.
  ///
  /// In es, this message translates to:
  /// **'En revisión'**
  String get statusInReview;

  /// No description provided for @statusTechnicalTest.
  ///
  /// In es, this message translates to:
  /// **'Prueba técnica'**
  String get statusTechnicalTest;

  /// No description provided for @statusInterview.
  ///
  /// In es, this message translates to:
  /// **'Entrevista'**
  String get statusInterview;

  /// No description provided for @statusOffer.
  ///
  /// In es, this message translates to:
  /// **'Oferta'**
  String get statusOffer;

  /// No description provided for @statusAccepted.
  ///
  /// In es, this message translates to:
  /// **'Aceptada'**
  String get statusAccepted;

  /// No description provided for @statusDeclined.
  ///
  /// In es, this message translates to:
  /// **'Declinada'**
  String get statusDeclined;

  /// No description provided for @statusRejected.
  ///
  /// In es, this message translates to:
  /// **'Rechazada'**
  String get statusRejected;

  /// No description provided for @statusNoResponse.
  ///
  /// In es, this message translates to:
  /// **'Sin respuesta'**
  String get statusNoResponse;

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Tu perfil'**
  String get profileTitle;

  /// No description provided for @profileCompleteness.
  ///
  /// In es, this message translates to:
  /// **'Perfil completo al {percent}%'**
  String profileCompleteness(int percent);

  /// No description provided for @profileCompleteHint.
  ///
  /// In es, this message translates to:
  /// **'Tu perfil tiene lo necesario para generar una buena HV.'**
  String get profileCompleteHint;

  /// No description provided for @gapName.
  ///
  /// In es, this message translates to:
  /// **'Añade tu nombre.'**
  String get gapName;

  /// No description provided for @gapHeadline.
  ///
  /// In es, this message translates to:
  /// **'Añade un titular, por ejemplo «Desarrollador Flutter Senior».'**
  String get gapHeadline;

  /// No description provided for @gapExperience.
  ///
  /// In es, this message translates to:
  /// **'Añade tu primera experiencia laboral.'**
  String get gapExperience;

  /// No description provided for @gapAchievements.
  ///
  /// In es, this message translates to:
  /// **'Añade logros a cada experiencia. Con cifras, mejor.'**
  String get gapAchievements;

  /// No description provided for @gapSkills.
  ///
  /// In es, this message translates to:
  /// **'Añade al menos {count} habilidades.'**
  String gapSkills(int count);

  /// No description provided for @gapSummary.
  ///
  /// In es, this message translates to:
  /// **'Escribe un resumen profesional de 2 o 3 frases.'**
  String get gapSummary;

  /// No description provided for @gapLink.
  ///
  /// In es, this message translates to:
  /// **'Añade tu LinkedIn, GitHub o portafolio.'**
  String get gapLink;

  /// No description provided for @sectionBasics.
  ///
  /// In es, this message translates to:
  /// **'Datos básicos'**
  String get sectionBasics;

  /// No description provided for @sectionExperience.
  ///
  /// In es, this message translates to:
  /// **'Experiencia'**
  String get sectionExperience;

  /// No description provided for @sectionProjects.
  ///
  /// In es, this message translates to:
  /// **'Proyectos'**
  String get sectionProjects;

  /// No description provided for @sectionSkills.
  ///
  /// In es, this message translates to:
  /// **'Habilidades'**
  String get sectionSkills;

  /// No description provided for @basicsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no has añadido tus datos.'**
  String get basicsEmpty;

  /// No description provided for @experienceEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no has añadido experiencia.'**
  String get experienceEmpty;

  /// No description provided for @projectsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no has añadido proyectos.'**
  String get projectsEmpty;

  /// No description provided for @skillsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no has añadido habilidades.'**
  String get skillsEmpty;

  /// No description provided for @edit.
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In es, this message translates to:
  /// **'Añadir'**
  String get add;

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @saveError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo guardar. Inténtalo de nuevo.'**
  String get saveError;

  /// No description provided for @loadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cargar tu perfil.'**
  String get loadError;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @requiredField.
  ///
  /// In es, this message translates to:
  /// **'Este campo es obligatorio'**
  String get requiredField;

  /// No description provided for @fullNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre completo'**
  String get fullNameLabel;

  /// No description provided for @headlineLabel.
  ///
  /// In es, this message translates to:
  /// **'Titular'**
  String get headlineLabel;

  /// No description provided for @headlineHint.
  ///
  /// In es, this message translates to:
  /// **'Desarrollador Flutter Senior'**
  String get headlineHint;

  /// No description provided for @locationLabel.
  ///
  /// In es, this message translates to:
  /// **'Ubicación'**
  String get locationLabel;

  /// No description provided for @locationHint.
  ///
  /// In es, this message translates to:
  /// **'Bogotá, Colombia'**
  String get locationHint;

  /// No description provided for @summaryLabel.
  ///
  /// In es, this message translates to:
  /// **'Resumen profesional'**
  String get summaryLabel;

  /// No description provided for @linkedinLabel.
  ///
  /// In es, this message translates to:
  /// **'LinkedIn'**
  String get linkedinLabel;

  /// No description provided for @githubLabel.
  ///
  /// In es, this message translates to:
  /// **'GitHub'**
  String get githubLabel;

  /// No description provided for @portfolioLabel.
  ///
  /// In es, this message translates to:
  /// **'Portafolio o sitio web'**
  String get portfolioLabel;

  /// No description provided for @urlInvalid.
  ///
  /// In es, this message translates to:
  /// **'Escribe un enlace completo, por ejemplo https://…'**
  String get urlInvalid;

  /// No description provided for @experienceNew.
  ///
  /// In es, this message translates to:
  /// **'Nueva experiencia'**
  String get experienceNew;

  /// No description provided for @experienceEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar experiencia'**
  String get experienceEdit;

  /// No description provided for @companyLabel.
  ///
  /// In es, this message translates to:
  /// **'Empresa'**
  String get companyLabel;

  /// No description provided for @roleLabel.
  ///
  /// In es, this message translates to:
  /// **'Cargo'**
  String get roleLabel;

  /// No description provided for @startDateLabel.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get startDateLabel;

  /// No description provided for @endDateLabel.
  ///
  /// In es, this message translates to:
  /// **'Fin'**
  String get endDateLabel;

  /// No description provided for @currentJob.
  ///
  /// In es, this message translates to:
  /// **'Trabajo aquí actualmente'**
  String get currentJob;

  /// No description provided for @present.
  ///
  /// In es, this message translates to:
  /// **'Actualidad'**
  String get present;

  /// No description provided for @endBeforeStart.
  ///
  /// In es, this message translates to:
  /// **'La fecha de fin debe ser posterior al inicio'**
  String get endBeforeStart;

  /// No description provided for @achievementsLabel.
  ///
  /// In es, this message translates to:
  /// **'Logros'**
  String get achievementsLabel;

  /// No description provided for @achievementsHelper.
  ///
  /// In es, this message translates to:
  /// **'Uno por línea. Ejemplo: Reduje el tiempo de arranque un 40 %.'**
  String get achievementsHelper;

  /// No description provided for @technologiesLabel.
  ///
  /// In es, this message translates to:
  /// **'Tecnologías'**
  String get technologiesLabel;

  /// No description provided for @technologiesHelper.
  ///
  /// In es, this message translates to:
  /// **'Separadas por comas: Flutter, Riverpod, Firebase'**
  String get technologiesHelper;

  /// No description provided for @projectNew.
  ///
  /// In es, this message translates to:
  /// **'Nuevo proyecto'**
  String get projectNew;

  /// No description provided for @projectEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar proyecto'**
  String get projectEdit;

  /// No description provided for @projectNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre del proyecto'**
  String get projectNameLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get descriptionLabel;

  /// No description provided for @projectUrlLabel.
  ///
  /// In es, this message translates to:
  /// **'Enlace'**
  String get projectUrlLabel;

  /// No description provided for @skillNew.
  ///
  /// In es, this message translates to:
  /// **'Nueva habilidad'**
  String get skillNew;

  /// No description provided for @skillEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar habilidad'**
  String get skillEdit;

  /// No description provided for @skillNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Habilidad'**
  String get skillNameLabel;

  /// No description provided for @skillCategoryLabel.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get skillCategoryLabel;

  /// No description provided for @skillYearsLabel.
  ///
  /// In es, this message translates to:
  /// **'Años de experiencia'**
  String get skillYearsLabel;

  /// No description provided for @skillYears.
  ///
  /// In es, this message translates to:
  /// **'{years, plural, =1{1 año} other{{years} años}}'**
  String skillYears(int years);

  /// No description provided for @categoryLanguage.
  ///
  /// In es, this message translates to:
  /// **'Lenguaje'**
  String get categoryLanguage;

  /// No description provided for @categoryFramework.
  ///
  /// In es, this message translates to:
  /// **'Framework'**
  String get categoryFramework;

  /// No description provided for @categoryTool.
  ///
  /// In es, this message translates to:
  /// **'Herramienta'**
  String get categoryTool;

  /// No description provided for @categoryOther.
  ///
  /// In es, this message translates to:
  /// **'Otra'**
  String get categoryOther;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar «{name}»?'**
  String deleteConfirmTitle(String name);

  /// No description provided for @deleteConfirmBody.
  ///
  /// In es, this message translates to:
  /// **'Esta acción no se puede deshacer.'**
  String get deleteConfirmBody;

  /// No description provided for @importResume.
  ///
  /// In es, this message translates to:
  /// **'Importar HV en PDF'**
  String get importResume;

  /// No description provided for @importTitle.
  ///
  /// In es, this message translates to:
  /// **'Importar tu HV'**
  String get importTitle;

  /// No description provided for @importIntro.
  ///
  /// In es, this message translates to:
  /// **'Elige tu hoja de vida en PDF. La IA la leerá y te mostrará lo que encontró antes de añadir nada a tu perfil.'**
  String get importIntro;

  /// No description provided for @importRules.
  ///
  /// In es, this message translates to:
  /// **'Solo se rellenan los campos vacíos y se añaden elementos nuevos. Lo que ya escribiste no cambia.'**
  String get importRules;

  /// No description provided for @importPick.
  ///
  /// In es, this message translates to:
  /// **'Elegir PDF'**
  String get importPick;

  /// No description provided for @importReading.
  ///
  /// In es, this message translates to:
  /// **'Leyendo tu HV…'**
  String get importReading;

  /// No description provided for @importReadingHint.
  ///
  /// In es, this message translates to:
  /// **'Puede tardar hasta un minuto.'**
  String get importReadingHint;

  /// No description provided for @importReviewTitle.
  ///
  /// In es, this message translates to:
  /// **'Esto se añadirá a tu perfil'**
  String get importReviewTitle;

  /// No description provided for @importNothingNew.
  ///
  /// In es, this message translates to:
  /// **'Tu perfil ya tiene todo lo que encontramos en el PDF.'**
  String get importNothingNew;

  /// No description provided for @importFields.
  ///
  /// In es, this message translates to:
  /// **'Datos básicos'**
  String get importFields;

  /// No description provided for @importApply.
  ///
  /// In es, this message translates to:
  /// **'Añadir a mi perfil'**
  String get importApply;

  /// No description provided for @importPickAnother.
  ///
  /// In es, this message translates to:
  /// **'Elegir otro PDF'**
  String get importPickAnother;

  /// No description provided for @importDone.
  ///
  /// In es, this message translates to:
  /// **'Perfil actualizado con tu HV.'**
  String get importDone;

  /// No description provided for @importErrorTooLarge.
  ///
  /// In es, this message translates to:
  /// **'El PDF pesa más de 5 MB. Exporta una versión más ligera e inténtalo de nuevo.'**
  String get importErrorTooLarge;

  /// No description provided for @importErrorUnreadable.
  ///
  /// In es, this message translates to:
  /// **'No se pudo leer el PDF. Comprueba que no esté protegido con contraseña ni sea una imagen escaneada.'**
  String get importErrorUnreadable;

  /// No description provided for @importErrorRateLimited.
  ///
  /// In es, this message translates to:
  /// **'Hay demasiadas peticiones ahora mismo. Espera un minuto e inténtalo de nuevo.'**
  String get importErrorRateLimited;

  /// No description provided for @importErrorOther.
  ///
  /// In es, this message translates to:
  /// **'No se pudo importar la HV. Revisa tu conexión e inténtalo de nuevo.'**
  String get importErrorOther;

  /// No description provided for @jobsLoadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudieron cargar tus ofertas.'**
  String get jobsLoadError;

  /// No description provided for @jobAdd.
  ///
  /// In es, this message translates to:
  /// **'Añadir oferta'**
  String get jobAdd;

  /// No description provided for @jobAddTitle.
  ///
  /// In es, this message translates to:
  /// **'Nueva oferta'**
  String get jobAddTitle;

  /// No description provided for @jobUrlLabel.
  ///
  /// In es, this message translates to:
  /// **'Enlace de la oferta'**
  String get jobUrlLabel;

  /// No description provided for @jobDescriptionLabel.
  ///
  /// In es, this message translates to:
  /// **'Descripción de la oferta'**
  String get jobDescriptionLabel;

  /// No description provided for @jobDescriptionHelper.
  ///
  /// In es, this message translates to:
  /// **'LinkedIn e Indeed no dejan leer sus páginas: copia la descripción y pégala aquí.'**
  String get jobDescriptionHelper;

  /// No description provided for @jobFormEmpty.
  ///
  /// In es, this message translates to:
  /// **'Pega el enlace o la descripción de la oferta.'**
  String get jobFormEmpty;

  /// No description provided for @jobAnalyze.
  ///
  /// In es, this message translates to:
  /// **'Analizar oferta'**
  String get jobAnalyze;

  /// No description provided for @jobAnalyzing.
  ///
  /// In es, this message translates to:
  /// **'Analizando la oferta…'**
  String get jobAnalyzing;

  /// No description provided for @jobAnalyzingHint.
  ///
  /// In es, this message translates to:
  /// **'Comparando los requisitos con tu perfil.'**
  String get jobAnalyzingHint;

  /// No description provided for @jobNoDescription.
  ///
  /// In es, this message translates to:
  /// **'No pudimos leer la oferta desde el enlace. Copia la descripción y pégala arriba.'**
  String get jobNoDescription;

  /// No description provided for @aiErrorRateLimited.
  ///
  /// In es, this message translates to:
  /// **'Se alcanzó el límite de uso de la IA. Espera un minuto e inténtalo de nuevo.'**
  String get aiErrorRateLimited;

  /// No description provided for @jobErrorOther.
  ///
  /// In es, this message translates to:
  /// **'No se pudo analizar la oferta. Revisa tu conexión e inténtalo de nuevo.'**
  String get jobErrorOther;

  /// No description provided for @jobSave.
  ///
  /// In es, this message translates to:
  /// **'Guardar oferta'**
  String get jobSave;

  /// No description provided for @jobSaved.
  ///
  /// In es, this message translates to:
  /// **'Oferta guardada.'**
  String get jobSaved;

  /// No description provided for @jobDuplicate.
  ///
  /// In es, this message translates to:
  /// **'Ya tienes guardada esta oferta.'**
  String get jobDuplicate;

  /// No description provided for @jobAnalyzeAnother.
  ///
  /// In es, this message translates to:
  /// **'Volver y editar'**
  String get jobAnalyzeAnother;

  /// No description provided for @jobDeleted.
  ///
  /// In es, this message translates to:
  /// **'Oferta eliminada.'**
  String get jobDeleted;

  /// No description provided for @jobNotFound.
  ///
  /// In es, this message translates to:
  /// **'Esta oferta ya no existe.'**
  String get jobNotFound;

  /// No description provided for @jobOpenLink.
  ///
  /// In es, this message translates to:
  /// **'Abrir oferta'**
  String get jobOpenLink;

  /// No description provided for @jobRequirements.
  ///
  /// In es, this message translates to:
  /// **'Requisitos'**
  String get jobRequirements;

  /// No description provided for @jobDescription.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get jobDescription;

  /// No description provided for @jobUnknownCompany.
  ///
  /// In es, this message translates to:
  /// **'Empresa sin indicar'**
  String get jobUnknownCompany;

  /// No description provided for @jobUntitled.
  ///
  /// In es, this message translates to:
  /// **'Oferta sin título'**
  String get jobUntitled;

  /// No description provided for @matchTitle.
  ///
  /// In es, this message translates to:
  /// **'Compatibilidad con tu perfil'**
  String get matchTitle;

  /// No description provided for @matchMet.
  ///
  /// In es, this message translates to:
  /// **'Cumples'**
  String get matchMet;

  /// No description provided for @matchMissing.
  ///
  /// In es, this message translates to:
  /// **'Te falta'**
  String get matchMissing;

  /// No description provided for @matchScoreSemantics.
  ///
  /// In es, this message translates to:
  /// **'Compatibilidad: {score} de 100'**
  String matchScoreSemantics(int score);

  /// No description provided for @matchLevelHigh.
  ///
  /// In es, this message translates to:
  /// **'Alta'**
  String get matchLevelHigh;

  /// No description provided for @matchLevelMedium.
  ///
  /// In es, this message translates to:
  /// **'Media'**
  String get matchLevelMedium;

  /// No description provided for @matchLevelLow.
  ///
  /// In es, this message translates to:
  /// **'Baja'**
  String get matchLevelLow;

  /// No description provided for @workModeRemote.
  ///
  /// In es, this message translates to:
  /// **'Remoto'**
  String get workModeRemote;

  /// No description provided for @workModeHybrid.
  ///
  /// In es, this message translates to:
  /// **'Híbrido'**
  String get workModeHybrid;

  /// No description provided for @workModeOnsite.
  ///
  /// In es, this message translates to:
  /// **'Presencial'**
  String get workModeOnsite;

  /// No description provided for @phoneLabel.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get phoneLabel;

  /// No description provided for @phoneHint.
  ///
  /// In es, this message translates to:
  /// **'+57 300 000 0000'**
  String get phoneHint;

  /// No description provided for @sectionEducation.
  ///
  /// In es, this message translates to:
  /// **'Estudios'**
  String get sectionEducation;

  /// No description provided for @educationEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no has añadido estudios.'**
  String get educationEmpty;

  /// No description provided for @educationNew.
  ///
  /// In es, this message translates to:
  /// **'Nuevos estudios'**
  String get educationNew;

  /// No description provided for @educationEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar estudios'**
  String get educationEdit;

  /// No description provided for @institutionLabel.
  ///
  /// In es, this message translates to:
  /// **'Institución'**
  String get institutionLabel;

  /// No description provided for @degreeLabel.
  ///
  /// In es, this message translates to:
  /// **'Título o programa'**
  String get degreeLabel;

  /// No description provided for @studyingNow.
  ///
  /// In es, this message translates to:
  /// **'Estudio aquí actualmente'**
  String get studyingNow;

  /// No description provided for @prepareApplication.
  ///
  /// In es, this message translates to:
  /// **'Preparar postulación'**
  String get prepareApplication;

  /// No description provided for @prepareTitle.
  ///
  /// In es, this message translates to:
  /// **'Preparar postulación'**
  String get prepareTitle;

  /// No description provided for @preparing.
  ///
  /// In es, this message translates to:
  /// **'Adaptando tu HV…'**
  String get preparing;

  /// No description provided for @preparingHint.
  ///
  /// In es, this message translates to:
  /// **'Puede tardar hasta un minuto.'**
  String get preparingHint;

  /// No description provided for @prepareEmptyProfile.
  ///
  /// In es, this message translates to:
  /// **'Añade al menos una experiencia a tu perfil para adaptar la HV.'**
  String get prepareEmptyProfile;

  /// No description provided for @prepareError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo preparar la postulación. Revisa tu conexión e inténtalo de nuevo.'**
  String get prepareError;

  /// No description provided for @tabResumePreview.
  ///
  /// In es, this message translates to:
  /// **'HV'**
  String get tabResumePreview;

  /// No description provided for @tabCoverLetter.
  ///
  /// In es, this message translates to:
  /// **'Carta'**
  String get tabCoverLetter;

  /// No description provided for @tabChanges.
  ///
  /// In es, this message translates to:
  /// **'Cambios'**
  String get tabChanges;

  /// No description provided for @letterHelper.
  ///
  /// In es, this message translates to:
  /// **'Revísala y ajústala antes de enviarla.'**
  String get letterHelper;

  /// No description provided for @copyLetter.
  ///
  /// In es, this message translates to:
  /// **'Copiar carta'**
  String get copyLetter;

  /// No description provided for @letterCopied.
  ///
  /// In es, this message translates to:
  /// **'Carta copiada.'**
  String get letterCopied;

  /// No description provided for @keywordsCovered.
  ///
  /// In es, this message translates to:
  /// **'Palabras clave de la oferta que cubre tu HV'**
  String get keywordsCovered;

  /// No description provided for @rejectedTitle.
  ///
  /// In es, this message translates to:
  /// **'Descartado por no estar en tu perfil'**
  String get rejectedTitle;

  /// No description provided for @rejectedBody.
  ///
  /// In es, this message translates to:
  /// **'La IA propuso esto, pero no se pudo comprobar con tus datos y no se usó.'**
  String get rejectedBody;

  /// No description provided for @saveVersion.
  ///
  /// In es, this message translates to:
  /// **'Guardar versión'**
  String get saveVersion;

  /// No description provided for @versionSavedShort.
  ///
  /// In es, this message translates to:
  /// **'Guardada'**
  String get versionSavedShort;

  /// No description provided for @exportPdf.
  ///
  /// In es, this message translates to:
  /// **'Exportar PDF'**
  String get exportPdf;

  /// No description provided for @pdfError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo generar el PDF. Inténtalo de nuevo.'**
  String get pdfError;

  /// No description provided for @aiErrorBusy.
  ///
  /// In es, this message translates to:
  /// **'La IA gratuita está saturada en este momento. Inténtalo de nuevo en unos minutos.'**
  String get aiErrorBusy;

  /// No description provided for @boardActive.
  ///
  /// In es, this message translates to:
  /// **'Activos'**
  String get boardActive;

  /// No description provided for @boardClosed.
  ///
  /// In es, this message translates to:
  /// **'Cerrados'**
  String get boardClosed;

  /// No description provided for @followUpDue.
  ///
  /// In es, this message translates to:
  /// **'Toca hacer seguimiento'**
  String get followUpDue;

  /// No description provided for @followUpOn.
  ///
  /// In es, this message translates to:
  /// **'Seguimiento: {date}'**
  String followUpOn(String date);

  /// No description provided for @appliedDaysAgo.
  ///
  /// In es, this message translates to:
  /// **'{days, plural, =0{Postulado hoy} =1{Postulado hace 1 día} other{Postulado hace {days} días}}'**
  String appliedDaysAgo(int days);

  /// No description provided for @nextStepTitle.
  ///
  /// In es, this message translates to:
  /// **'Actualizar estado'**
  String get nextStepTitle;

  /// No description provided for @followUpTitle.
  ///
  /// In es, this message translates to:
  /// **'Seguimiento'**
  String get followUpTitle;

  /// No description provided for @followUpDoneButton.
  ///
  /// In es, this message translates to:
  /// **'Hecho, recordar en 7 días'**
  String get followUpDoneButton;

  /// No description provided for @followUpChange.
  ///
  /// In es, this message translates to:
  /// **'Cambiar fecha'**
  String get followUpChange;

  /// No description provided for @followUpNone.
  ///
  /// In es, this message translates to:
  /// **'Sin seguimiento programado.'**
  String get followUpNone;

  /// No description provided for @noResponseHint.
  ///
  /// In es, this message translates to:
  /// **'Llevas {days} días sin respuesta. Puedes marcarlo como «Sin respuesta» y seguir con otras ofertas.'**
  String noResponseHint(int days);

  /// No description provided for @notesLabel.
  ///
  /// In es, this message translates to:
  /// **'Notas'**
  String get notesLabel;

  /// No description provided for @notesHint.
  ///
  /// In es, this message translates to:
  /// **'Contactos, impresiones, preguntas de la entrevista…'**
  String get notesHint;

  /// No description provided for @notesSaved.
  ///
  /// In es, this message translates to:
  /// **'Notas guardadas.'**
  String get notesSaved;

  /// No description provided for @historyTitle.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get historyTitle;

  /// No description provided for @historyCreated.
  ///
  /// In es, this message translates to:
  /// **'Creado como «{status}»'**
  String historyCreated(String status);

  /// No description provided for @viewJob.
  ///
  /// In es, this message translates to:
  /// **'Ver oferta'**
  String get viewJob;

  /// No description provided for @trackJob.
  ///
  /// In es, this message translates to:
  /// **'Seguir esta oferta'**
  String get trackJob;

  /// No description provided for @viewProcess.
  ///
  /// In es, this message translates to:
  /// **'Ver proceso'**
  String get viewProcess;

  /// No description provided for @processStatus.
  ///
  /// In es, this message translates to:
  /// **'Estado del proceso'**
  String get processStatus;

  /// No description provided for @actionPreparing.
  ///
  /// In es, this message translates to:
  /// **'Preparar'**
  String get actionPreparing;

  /// No description provided for @actionSaved.
  ///
  /// In es, this message translates to:
  /// **'Volver a guardada'**
  String get actionSaved;

  /// No description provided for @actionApplied.
  ///
  /// In es, this message translates to:
  /// **'Ya me postulé'**
  String get actionApplied;

  /// No description provided for @actionInReview.
  ///
  /// In es, this message translates to:
  /// **'Está en revisión'**
  String get actionInReview;

  /// No description provided for @actionTechnicalTest.
  ///
  /// In es, this message translates to:
  /// **'Me enviaron una prueba'**
  String get actionTechnicalTest;

  /// No description provided for @actionInterview.
  ///
  /// In es, this message translates to:
  /// **'Tengo entrevista'**
  String get actionInterview;

  /// No description provided for @actionOffer.
  ///
  /// In es, this message translates to:
  /// **'Recibí una oferta'**
  String get actionOffer;

  /// No description provided for @actionAccepted.
  ///
  /// In es, this message translates to:
  /// **'La acepté'**
  String get actionAccepted;

  /// No description provided for @actionDeclined.
  ///
  /// In es, this message translates to:
  /// **'La rechacé'**
  String get actionDeclined;

  /// No description provided for @actionRejected.
  ///
  /// In es, this message translates to:
  /// **'Me descartaron'**
  String get actionRejected;

  /// No description provided for @actionNoResponse.
  ///
  /// In es, this message translates to:
  /// **'Sin respuesta'**
  String get actionNoResponse;

  /// No description provided for @homeStart.
  ///
  /// In es, this message translates to:
  /// **'Empieza añadiendo una oferta en la pestaña Ofertas.'**
  String get homeStart;

  /// No description provided for @searchPrefsTitle.
  ///
  /// In es, this message translates to:
  /// **'Preferencias de búsqueda'**
  String get searchPrefsTitle;

  /// No description provided for @searchPrefsIntro.
  ///
  /// In es, this message translates to:
  /// **'Rumbo buscará ofertas en Get on Board, Remotive, Himalayas, Remote OK y We Work Remotely y te sugerirá las que encajen con tu perfil.'**
  String get searchPrefsIntro;

  /// No description provided for @searchRolesLabel.
  ///
  /// In es, this message translates to:
  /// **'Cargos'**
  String get searchRolesLabel;

  /// No description provided for @searchRolesHelper.
  ///
  /// In es, this message translates to:
  /// **'Separados por comas: Flutter Developer, Mobile Developer'**
  String get searchRolesHelper;

  /// No description provided for @searchTechLabel.
  ///
  /// In es, this message translates to:
  /// **'Tecnologías clave'**
  String get searchTechLabel;

  /// No description provided for @searchTechHelper.
  ///
  /// In es, this message translates to:
  /// **'Separadas por comas: Flutter, Dart'**
  String get searchTechHelper;

  /// No description provided for @searchCountriesLabel.
  ///
  /// In es, this message translates to:
  /// **'Países donde puedes trabajar'**
  String get searchCountriesLabel;

  /// No description provided for @searchCountriesHelper.
  ///
  /// In es, this message translates to:
  /// **'Separados por comas. Los remotos limitados a otros países se descartan.'**
  String get searchCountriesHelper;

  /// No description provided for @searchWorkModes.
  ///
  /// In es, this message translates to:
  /// **'Modalidad'**
  String get searchWorkModes;

  /// No description provided for @searchSources.
  ///
  /// In es, this message translates to:
  /// **'Portales'**
  String get searchSources;

  /// No description provided for @searchMinScore.
  ///
  /// In es, this message translates to:
  /// **'Sugerir desde {score} de compatibilidad'**
  String searchMinScore(int score);

  /// No description provided for @searchNeedsTerms.
  ///
  /// In es, this message translates to:
  /// **'Escribe al menos un cargo o una tecnología.'**
  String get searchNeedsTerms;

  /// No description provided for @searchNeedsMode.
  ///
  /// In es, this message translates to:
  /// **'Elige al menos una modalidad.'**
  String get searchNeedsMode;

  /// No description provided for @searchNeedsSource.
  ///
  /// In es, this message translates to:
  /// **'Elige al menos un portal.'**
  String get searchNeedsSource;

  /// No description provided for @searchSaved.
  ///
  /// In es, this message translates to:
  /// **'Preferencias guardadas.'**
  String get searchSaved;

  /// No description provided for @jobsTabSuggested.
  ///
  /// In es, this message translates to:
  /// **'Sugeridas ({count})'**
  String jobsTabSuggested(int count);

  /// No description provided for @jobsTabSaved.
  ///
  /// In es, this message translates to:
  /// **'Guardadas ({count})'**
  String jobsTabSaved(int count);

  /// No description provided for @searchNow.
  ///
  /// In es, this message translates to:
  /// **'Buscar ahora'**
  String get searchNow;

  /// No description provided for @searchRunning.
  ///
  /// In es, this message translates to:
  /// **'Buscando ofertas…'**
  String get searchRunning;

  /// No description provided for @searchLastRun.
  ///
  /// In es, this message translates to:
  /// **'Última búsqueda: {date}'**
  String searchLastRun(String date);

  /// No description provided for @searchSetupTitle.
  ///
  /// In es, this message translates to:
  /// **'Configura la búsqueda automática'**
  String get searchSetupTitle;

  /// No description provided for @searchSetupBody.
  ///
  /// In es, this message translates to:
  /// **'Dinos qué cargos y tecnologías buscas y Rumbo te sugerirá ofertas cada día.'**
  String get searchSetupBody;

  /// No description provided for @searchSetupButton.
  ///
  /// In es, this message translates to:
  /// **'Configurar búsqueda'**
  String get searchSetupButton;

  /// No description provided for @searchNoSuggestions.
  ///
  /// In es, this message translates to:
  /// **'No hay sugerencias pendientes. Pulsa «Buscar ahora» o vuelve más tarde.'**
  String get searchNoSuggestions;

  /// No description provided for @searchResult.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{No hay ofertas nuevas que encajen con tu perfil.} =1{1 oferta nueva sugerida.} other{{count} ofertas nuevas sugeridas.}}'**
  String searchResult(int count);

  /// No description provided for @searchSourcesFailed.
  ///
  /// In es, this message translates to:
  /// **'No respondieron: {sources}.'**
  String searchSourcesFailed(String sources);

  /// No description provided for @searchTooSoon.
  ///
  /// In es, this message translates to:
  /// **'Acabas de buscar. Espera unos minutos para volver a hacerlo.'**
  String get searchTooSoon;

  /// No description provided for @searchNoPreferences.
  ///
  /// In es, this message translates to:
  /// **'Configura tus preferencias de búsqueda primero.'**
  String get searchNoPreferences;

  /// No description provided for @searchError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo completar la búsqueda. Inténtalo de nuevo.'**
  String get searchError;

  /// No description provided for @suggestionKeep.
  ///
  /// In es, this message translates to:
  /// **'Guardar oferta'**
  String get suggestionKeep;

  /// No description provided for @suggestionDismiss.
  ///
  /// In es, this message translates to:
  /// **'Descartar'**
  String get suggestionDismiss;

  /// No description provided for @suggestionKept.
  ///
  /// In es, this message translates to:
  /// **'Oferta guardada.'**
  String get suggestionKept;

  /// No description provided for @suggestionDismissed.
  ///
  /// In es, this message translates to:
  /// **'Sugerencia descartada.'**
  String get suggestionDismissed;

  /// No description provided for @foundOn.
  ///
  /// In es, this message translates to:
  /// **'Encontrada en {source}'**
  String foundOn(String source);

  /// No description provided for @homeSuggestions.
  ///
  /// In es, this message translates to:
  /// **'Sugerencias nuevas'**
  String get homeSuggestions;

  /// No description provided for @watchedTitle.
  ///
  /// In es, this message translates to:
  /// **'Empresas que vigilas'**
  String get watchedTitle;

  /// No description provided for @watchedHelper.
  ///
  /// In es, this message translates to:
  /// **'Pega el enlace de su página de empleo en Greenhouse, Lever, Ashby, Workable, SmartRecruiters, Recruitee o Teamtailor. Por ejemplo: jobs.ashbyhq.com/truelogic o apply.workable.com/huggingface'**
  String get watchedHelper;

  /// No description provided for @watchedLabel.
  ///
  /// In es, this message translates to:
  /// **'Enlace de la página de empleo'**
  String get watchedLabel;

  /// No description provided for @watchedAdd.
  ///
  /// In es, this message translates to:
  /// **'Añadir empresa'**
  String get watchedAdd;

  /// No description provided for @watchedInvalid.
  ///
  /// In es, this message translates to:
  /// **'No reconocemos ese enlace. Debe ser de Greenhouse, Lever, Ashby, Workable, SmartRecruiters, Recruitee o Teamtailor.'**
  String get watchedInvalid;

  /// No description provided for @watchedDuplicate.
  ///
  /// In es, this message translates to:
  /// **'Ya vigilas esa empresa.'**
  String get watchedDuplicate;

  /// No description provided for @watchedLimit.
  ///
  /// In es, this message translates to:
  /// **'Puedes vigilar hasta {count} empresas.'**
  String watchedLimit(int count);

  /// No description provided for @watchedEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no vigilas ninguna empresa.'**
  String get watchedEmpty;

  /// No description provided for @watchedRemove.
  ///
  /// In es, this message translates to:
  /// **'Dejar de vigilar {name}'**
  String watchedRemove(String name);

  /// No description provided for @statsTitle.
  ///
  /// In es, this message translates to:
  /// **'Estadísticas'**
  String get statsTitle;

  /// No description provided for @statsOpen.
  ///
  /// In es, this message translates to:
  /// **'Ver estadísticas'**
  String get statsOpen;

  /// No description provided for @statsFunnel.
  ///
  /// In es, this message translates to:
  /// **'Embudo'**
  String get statsFunnel;

  /// No description provided for @statsFunnelSaved.
  ///
  /// In es, this message translates to:
  /// **'En el tablero'**
  String get statsFunnelSaved;

  /// No description provided for @statsFunnelApplied.
  ///
  /// In es, this message translates to:
  /// **'Postuladas'**
  String get statsFunnelApplied;

  /// No description provided for @statsFunnelResponded.
  ///
  /// In es, this message translates to:
  /// **'Con respuesta'**
  String get statsFunnelResponded;

  /// No description provided for @statsFunnelInterviews.
  ///
  /// In es, this message translates to:
  /// **'Entrevistas o pruebas'**
  String get statsFunnelInterviews;

  /// No description provided for @statsFunnelOffers.
  ///
  /// In es, this message translates to:
  /// **'Ofertas recibidas'**
  String get statsFunnelOffers;

  /// No description provided for @statsResponseRate.
  ///
  /// In es, this message translates to:
  /// **'{rate}% de tus postulaciones recibieron respuesta.'**
  String statsResponseRate(int rate);

  /// No description provided for @statsResponseTime.
  ///
  /// In es, this message translates to:
  /// **'Las empresas tardan {days} días de media en responder.'**
  String statsResponseTime(String days);

  /// No description provided for @statsNoApplications.
  ///
  /// In es, this message translates to:
  /// **'Cuando marques procesos como «Postulada» verás aquí qué porcentaje recibe respuesta y cuánto tardan las empresas.'**
  String get statsNoApplications;

  /// No description provided for @statsBySource.
  ///
  /// In es, this message translates to:
  /// **'Por origen'**
  String get statsBySource;

  /// No description provided for @statsSourceManual.
  ///
  /// In es, this message translates to:
  /// **'Añadidas por ti'**
  String get statsSourceManual;

  /// No description provided for @statsSourceRow.
  ///
  /// In es, this message translates to:
  /// **'{applied} postuladas · {responded} con respuesta'**
  String statsSourceRow(int applied, int responded);

  /// No description provided for @statsGaps.
  ///
  /// In es, this message translates to:
  /// **'Lo que más te piden y no tienes'**
  String get statsGaps;

  /// No description provided for @statsGapsHint.
  ///
  /// In es, this message translates to:
  /// **'Según {count, plural, =1{1 oferta analizada} other{{count} ofertas analizadas}}. Es lo que más rendiría aprender o destacar.'**
  String statsGapsHint(int count);

  /// No description provided for @statsGapsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Analiza o guarda más ofertas para ver qué requisitos se repiten.'**
  String get statsGapsEmpty;

  /// No description provided for @statsGapRow.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{en 1 oferta} other{en {count} ofertas}}'**
  String statsGapRow(int count);

  /// No description provided for @statsLoadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudieron cargar las estadísticas.'**
  String get statsLoadError;

  /// No description provided for @interviewsTitle.
  ///
  /// In es, this message translates to:
  /// **'Entrevistas'**
  String get interviewsTitle;

  /// No description provided for @interviewAdd.
  ///
  /// In es, this message translates to:
  /// **'Programar entrevista'**
  String get interviewAdd;

  /// No description provided for @interviewNew.
  ///
  /// In es, this message translates to:
  /// **'Nueva entrevista'**
  String get interviewNew;

  /// No description provided for @interviewEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar entrevista'**
  String get interviewEdit;

  /// No description provided for @interviewKind.
  ///
  /// In es, this message translates to:
  /// **'Tipo'**
  String get interviewKind;

  /// No description provided for @kindScreening.
  ///
  /// In es, this message translates to:
  /// **'Primera llamada'**
  String get kindScreening;

  /// No description provided for @kindTechnical.
  ///
  /// In es, this message translates to:
  /// **'Prueba técnica'**
  String get kindTechnical;

  /// No description provided for @kindHr.
  ///
  /// In es, this message translates to:
  /// **'Recursos humanos'**
  String get kindHr;

  /// No description provided for @kindFinal.
  ///
  /// In es, this message translates to:
  /// **'Entrevista final'**
  String get kindFinal;

  /// No description provided for @kindOther.
  ///
  /// In es, this message translates to:
  /// **'Otra'**
  String get kindOther;

  /// No description provided for @interviewDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get interviewDate;

  /// No description provided for @interviewTime.
  ///
  /// In es, this message translates to:
  /// **'Hora'**
  String get interviewTime;

  /// No description provided for @interviewDuration.
  ///
  /// In es, this message translates to:
  /// **'Duración (minutos)'**
  String get interviewDuration;

  /// No description provided for @interviewLocation.
  ///
  /// In es, this message translates to:
  /// **'Enlace o lugar'**
  String get interviewLocation;

  /// No description provided for @interviewLocationHint.
  ///
  /// In es, this message translates to:
  /// **'https://meet.google.com/… o dirección'**
  String get interviewLocationHint;

  /// No description provided for @interviewNotes.
  ///
  /// In es, this message translates to:
  /// **'Notas'**
  String get interviewNotes;

  /// No description provided for @interviewNotesHint.
  ///
  /// In es, this message translates to:
  /// **'Con quién, qué preparar, preguntas…'**
  String get interviewNotesHint;

  /// No description provided for @interviewOutcome.
  ///
  /// In es, this message translates to:
  /// **'Resultado'**
  String get interviewOutcome;

  /// No description provided for @outcomePending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get outcomePending;

  /// No description provided for @outcomePassed.
  ///
  /// In es, this message translates to:
  /// **'Superada'**
  String get outcomePassed;

  /// No description provided for @outcomeFailed.
  ///
  /// In es, this message translates to:
  /// **'No superada'**
  String get outcomeFailed;

  /// No description provided for @interviewStatusChanged.
  ///
  /// In es, this message translates to:
  /// **'Entrevista guardada. El proceso pasó a «{status}».'**
  String interviewStatusChanged(String status);

  /// No description provided for @interviewSaved.
  ///
  /// In es, this message translates to:
  /// **'Entrevista guardada.'**
  String get interviewSaved;

  /// No description provided for @interviewsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Sin entrevistas programadas.'**
  String get interviewsEmpty;

  /// No description provided for @homeUpcoming.
  ///
  /// In es, this message translates to:
  /// **'Próximas entrevistas'**
  String get homeUpcoming;

  /// No description provided for @homeNoUpcoming.
  ///
  /// In es, this message translates to:
  /// **'No tienes entrevistas próximas.'**
  String get homeNoUpcoming;

  /// No description provided for @interviewJoin.
  ///
  /// In es, this message translates to:
  /// **'Abrir enlace'**
  String get interviewJoin;

  /// No description provided for @interviewDurationInvalid.
  ///
  /// In es, this message translates to:
  /// **'Entre 5 y 600 minutos'**
  String get interviewDurationInvalid;

  /// No description provided for @gmailTitle.
  ///
  /// In es, this message translates to:
  /// **'Conectar Gmail'**
  String get gmailTitle;

  /// No description provided for @gmailIntro.
  ///
  /// In es, this message translates to:
  /// **'Rumbo puede leer los correos de las empresas de tus procesos activos y proponerte cambios de estado o entrevistas. Tú decides si aplicarlos.'**
  String get gmailIntro;

  /// No description provided for @gmailHow.
  ///
  /// In es, this message translates to:
  /// **'Un pequeño script en tu cuenta de Google revisa tu correo cada hora. Tu acceso a Gmail no sale de Google: solo se envían a Rumbo los correos que mencionan a las empresas de tus procesos y tus alertas de empleo de LinkedIn.'**
  String get gmailHow;

  /// No description provided for @gmailPrivacy.
  ///
  /// In es, this message translates to:
  /// **'Con la IA gratuita, Google puede usar esos correos para mejorar sus productos.'**
  String get gmailPrivacy;

  /// No description provided for @gmailStep1.
  ///
  /// In es, this message translates to:
  /// **'Pulsa «Copiar script». Incluye una clave personal: no la compartas.'**
  String get gmailStep1;

  /// No description provided for @gmailStep2.
  ///
  /// In es, this message translates to:
  /// **'Abre script.google.com, crea un proyecto nuevo, borra lo que trae y pega el script.'**
  String get gmailStep2;

  /// No description provided for @gmailStep3.
  ///
  /// In es, this message translates to:
  /// **'Arriba, elige la función «instalar» y pulsa Ejecutar.'**
  String get gmailStep3;

  /// No description provided for @gmailStep4.
  ///
  /// In es, this message translates to:
  /// **'Autoriza el acceso con tu cuenta de Google. Si ves «Google no ha verificado esta aplicación», entra en Configuración avanzada → Ir a (no seguro): el script es tuyo.'**
  String get gmailStep4;

  /// No description provided for @gmailCopy.
  ///
  /// In es, this message translates to:
  /// **'Copiar script'**
  String get gmailCopy;

  /// No description provided for @gmailCopied.
  ///
  /// In es, this message translates to:
  /// **'Script copiado. Pégalo en script.google.com.'**
  String get gmailCopied;

  /// No description provided for @gmailRegenerate.
  ///
  /// In es, this message translates to:
  /// **'Generar clave nueva y copiar'**
  String get gmailRegenerate;

  /// No description provided for @gmailRegenerateHint.
  ///
  /// In es, this message translates to:
  /// **'La clave anterior dejará de funcionar: tendrás que pegar el script nuevo.'**
  String get gmailRegenerateHint;

  /// No description provided for @gmailDisconnect.
  ///
  /// In es, this message translates to:
  /// **'Desconectar Gmail'**
  String get gmailDisconnect;

  /// No description provided for @gmailDisconnected.
  ///
  /// In es, this message translates to:
  /// **'Gmail desconectado.'**
  String get gmailDisconnected;

  /// No description provided for @gmailNotConnected.
  ///
  /// In es, this message translates to:
  /// **'Aún no has conectado Gmail.'**
  String get gmailNotConnected;

  /// No description provided for @gmailWaiting.
  ///
  /// In es, this message translates to:
  /// **'Clave creada el {date}. Esperando a que el script se ejecute por primera vez.'**
  String gmailWaiting(String date);

  /// No description provided for @gmailConnected.
  ///
  /// In es, this message translates to:
  /// **'Conectado. El script habló con Rumbo por última vez el {date}.'**
  String gmailConnected(String date);

  /// No description provided for @gmailOpenScript.
  ///
  /// In es, this message translates to:
  /// **'Abrir script.google.com'**
  String get gmailOpenScript;

  /// No description provided for @emailUpdatesTitle.
  ///
  /// In es, this message translates to:
  /// **'Novedades del correo'**
  String get emailUpdatesTitle;

  /// No description provided for @emailApply.
  ///
  /// In es, this message translates to:
  /// **'Aplicar'**
  String get emailApply;

  /// No description provided for @emailDismiss.
  ///
  /// In es, this message translates to:
  /// **'Ignorar'**
  String get emailDismiss;

  /// No description provided for @emailApplied.
  ///
  /// In es, this message translates to:
  /// **'Propuesta aplicada.'**
  String get emailApplied;

  /// No description provided for @emailDismissed.
  ///
  /// In es, this message translates to:
  /// **'Propuesta ignorada.'**
  String get emailDismissed;

  /// No description provided for @emailInterviewAt.
  ///
  /// In es, this message translates to:
  /// **'Fecha: {date}'**
  String emailInterviewAt(String date);

  /// No description provided for @practiceTitle.
  ///
  /// In es, this message translates to:
  /// **'Practicar entrevista'**
  String get practiceTitle;

  /// No description provided for @practiceOpen.
  ///
  /// In es, this message translates to:
  /// **'Practicar entrevista'**
  String get practiceOpen;

  /// No description provided for @practiceIntro.
  ///
  /// In es, this message translates to:
  /// **'Un entrevistador con IA te hará preguntas sobre esta oferta y evaluará cada respuesta. Responde como en una entrevista real; puedes dictar con el micrófono del teclado.'**
  String get practiceIntro;

  /// No description provided for @practiceMode.
  ///
  /// In es, this message translates to:
  /// **'Tipo de preguntas'**
  String get practiceMode;

  /// No description provided for @modeTechnical.
  ///
  /// In es, this message translates to:
  /// **'Técnicas'**
  String get modeTechnical;

  /// No description provided for @modeBehavioral.
  ///
  /// In es, this message translates to:
  /// **'Comportamiento'**
  String get modeBehavioral;

  /// No description provided for @modeMixed.
  ///
  /// In es, this message translates to:
  /// **'Mixtas'**
  String get modeMixed;

  /// No description provided for @practiceLanguage.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get practiceLanguage;

  /// No description provided for @languageEs.
  ///
  /// In es, this message translates to:
  /// **'Español'**
  String get languageEs;

  /// No description provided for @languageEn.
  ///
  /// In es, this message translates to:
  /// **'Inglés'**
  String get languageEn;

  /// No description provided for @practiceCount.
  ///
  /// In es, this message translates to:
  /// **'{count} preguntas'**
  String practiceCount(int count);

  /// No description provided for @practiceStart.
  ///
  /// In es, this message translates to:
  /// **'Empezar'**
  String get practiceStart;

  /// No description provided for @practiceThinking.
  ///
  /// In es, this message translates to:
  /// **'El entrevistador está pensando…'**
  String get practiceThinking;

  /// No description provided for @practiceAnswerHint.
  ///
  /// In es, this message translates to:
  /// **'Tu respuesta…'**
  String get practiceAnswerHint;

  /// No description provided for @practiceSend.
  ///
  /// In es, this message translates to:
  /// **'Responder'**
  String get practiceSend;

  /// No description provided for @practiceQuestion.
  ///
  /// In es, this message translates to:
  /// **'Pregunta {number} de {total}'**
  String practiceQuestion(int number, int total);

  /// No description provided for @practiceScore.
  ///
  /// In es, this message translates to:
  /// **'{score} de 5'**
  String practiceScore(int score);

  /// No description provided for @practiceStrengths.
  ///
  /// In es, this message translates to:
  /// **'Bien'**
  String get practiceStrengths;

  /// No description provided for @practiceImprove.
  ///
  /// In es, this message translates to:
  /// **'Mejora'**
  String get practiceImprove;

  /// No description provided for @practiceBetter.
  ///
  /// In es, this message translates to:
  /// **'Respuesta mejorada'**
  String get practiceBetter;

  /// No description provided for @practiceCopy.
  ///
  /// In es, this message translates to:
  /// **'Copiar'**
  String get practiceCopy;

  /// No description provided for @practiceCopied.
  ///
  /// In es, this message translates to:
  /// **'Respuesta copiada.'**
  String get practiceCopied;

  /// No description provided for @practiceSummary.
  ///
  /// In es, this message translates to:
  /// **'Resultado de la práctica'**
  String get practiceSummary;

  /// No description provided for @practiceAgain.
  ///
  /// In es, this message translates to:
  /// **'Practicar otra vez'**
  String get practiceAgain;

  /// No description provided for @practiceError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo continuar la práctica. Inténtalo de nuevo.'**
  String get practiceError;

  /// No description provided for @practiceRetry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get practiceRetry;

  /// No description provided for @answersTitle.
  ///
  /// In es, this message translates to:
  /// **'Banco de respuestas'**
  String get answersTitle;

  /// No description provided for @answersIntro.
  ///
  /// In es, this message translates to:
  /// **'Prepara tus respuestas a las preguntas que salen en casi todas las entrevistas y cópialas cuando las necesites.'**
  String get answersIntro;

  /// No description provided for @answersEmpty.
  ///
  /// In es, this message translates to:
  /// **'Empieza por una de estas preguntas habituales:'**
  String get answersEmpty;

  /// No description provided for @answersAdd.
  ///
  /// In es, this message translates to:
  /// **'Nueva respuesta'**
  String get answersAdd;

  /// No description provided for @answerNew.
  ///
  /// In es, this message translates to:
  /// **'Nueva respuesta'**
  String get answerNew;

  /// No description provided for @answerEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar respuesta'**
  String get answerEdit;

  /// No description provided for @answerQuestion.
  ///
  /// In es, this message translates to:
  /// **'Pregunta'**
  String get answerQuestion;

  /// No description provided for @answerText.
  ///
  /// In es, this message translates to:
  /// **'Tu respuesta'**
  String get answerText;

  /// No description provided for @answerCopy.
  ///
  /// In es, this message translates to:
  /// **'Copiar'**
  String get answerCopy;

  /// No description provided for @answerCopied.
  ///
  /// In es, this message translates to:
  /// **'Respuesta copiada.'**
  String get answerCopied;

  /// No description provided for @answerSaveToBank.
  ///
  /// In es, this message translates to:
  /// **'Guardar en el banco'**
  String get answerSaveToBank;

  /// No description provided for @answerSavedToBank.
  ///
  /// In es, this message translates to:
  /// **'Guardada en tu banco de respuestas.'**
  String get answerSavedToBank;

  /// No description provided for @commonAboutYou.
  ///
  /// In es, this message translates to:
  /// **'Háblame de ti'**
  String get commonAboutYou;

  /// No description provided for @commonWhyCompany.
  ///
  /// In es, this message translates to:
  /// **'¿Por qué quieres trabajar con nosotros?'**
  String get commonWhyCompany;

  /// No description provided for @commonSalary.
  ///
  /// In es, this message translates to:
  /// **'¿Cuál es tu expectativa salarial?'**
  String get commonSalary;

  /// No description provided for @commonWhyLeave.
  ///
  /// In es, this message translates to:
  /// **'¿Por qué quieres cambiar de trabajo?'**
  String get commonWhyLeave;

  /// No description provided for @commonChallenge.
  ///
  /// In es, this message translates to:
  /// **'Cuéntame un reto técnico que hayas resuelto'**
  String get commonChallenge;

  /// No description provided for @commonWeakness.
  ///
  /// In es, this message translates to:
  /// **'¿Cuál es tu mayor área de mejora?'**
  String get commonWeakness;

  /// No description provided for @commonConflict.
  ///
  /// In es, this message translates to:
  /// **'Cuéntame un desacuerdo con un compañero y cómo lo resolviste'**
  String get commonConflict;

  /// No description provided for @offerTitle.
  ///
  /// In es, this message translates to:
  /// **'Detalles de la oferta'**
  String get offerTitle;

  /// No description provided for @offerEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar condiciones'**
  String get offerEdit;

  /// No description provided for @offerSalary.
  ///
  /// In es, this message translates to:
  /// **'Salario'**
  String get offerSalary;

  /// No description provided for @offerCurrency.
  ///
  /// In es, this message translates to:
  /// **'Moneda'**
  String get offerCurrency;

  /// No description provided for @periodMonth.
  ///
  /// In es, this message translates to:
  /// **'Mensual'**
  String get periodMonth;

  /// No description provided for @periodYear.
  ///
  /// In es, this message translates to:
  /// **'Anual'**
  String get periodYear;

  /// No description provided for @offerWorkMode.
  ///
  /// In es, this message translates to:
  /// **'Modalidad'**
  String get offerWorkMode;

  /// No description provided for @offerStart.
  ///
  /// In es, this message translates to:
  /// **'Fecha de inicio'**
  String get offerStart;

  /// No description provided for @offerDeadline.
  ///
  /// In es, this message translates to:
  /// **'Responder antes del'**
  String get offerDeadline;

  /// No description provided for @offerBenefits.
  ///
  /// In es, this message translates to:
  /// **'Beneficios'**
  String get offerBenefits;

  /// No description provided for @offerBenefitsHint.
  ///
  /// In es, this message translates to:
  /// **'Seguro médico, vacaciones, equipo, bonos…'**
  String get offerBenefitsHint;

  /// No description provided for @offerNotes.
  ///
  /// In es, this message translates to:
  /// **'Notas'**
  String get offerNotes;

  /// No description provided for @offerSaved.
  ///
  /// In es, this message translates to:
  /// **'Condiciones guardadas.'**
  String get offerSaved;

  /// No description provided for @offerNoDetails.
  ///
  /// In es, this message translates to:
  /// **'Aún no has añadido las condiciones.'**
  String get offerNoDetails;

  /// No description provided for @offerCompare.
  ///
  /// In es, this message translates to:
  /// **'Comparar ofertas'**
  String get offerCompare;

  /// No description provided for @compareTitle.
  ///
  /// In es, this message translates to:
  /// **'Comparar ofertas'**
  String get compareTitle;

  /// No description provided for @compareEmpty.
  ///
  /// In es, this message translates to:
  /// **'Cuando marques un proceso como «Oferta» podrás comparar sus condiciones aquí.'**
  String get compareEmpty;

  /// No description provided for @compareMonthly.
  ///
  /// In es, this message translates to:
  /// **'{amount} al mes'**
  String compareMonthly(String amount);

  /// No description provided for @compareHighest.
  ///
  /// In es, this message translates to:
  /// **'Mejor salario en {currency}'**
  String compareHighest(String currency);

  /// No description provided for @compareMixedCurrencies.
  ///
  /// In es, this message translates to:
  /// **'Las ofertas están en monedas distintas: compáralas en la misma moneda antes de decidir.'**
  String get compareMixedCurrencies;

  /// No description provided for @compareFit.
  ///
  /// In es, this message translates to:
  /// **'Compatibilidad {score}'**
  String compareFit(int score);

  /// No description provided for @compareDeadline.
  ///
  /// In es, this message translates to:
  /// **'Responder antes del {date}'**
  String compareDeadline(String date);

  /// No description provided for @notSet.
  ///
  /// In es, this message translates to:
  /// **'Sin indicar'**
  String get notSet;

  /// No description provided for @negotiateTitle.
  ///
  /// In es, this message translates to:
  /// **'Preparar negociación'**
  String get negotiateTitle;

  /// No description provided for @negotiateOpen.
  ///
  /// In es, this message translates to:
  /// **'Preparar negociación'**
  String get negotiateOpen;

  /// No description provided for @negotiateIntro.
  ///
  /// In es, this message translates to:
  /// **'La IA prepara una respuesta a la empresa con tu contraoferta y los argumentos para defenderla, usando tus logros reales. Revísala antes de enviarla.'**
  String get negotiateIntro;

  /// No description provided for @negotiateTarget.
  ///
  /// In es, this message translates to:
  /// **'Salario que quieres proponer'**
  String get negotiateTarget;

  /// No description provided for @negotiateTargetHelper.
  ///
  /// In es, this message translates to:
  /// **'En la misma moneda y periodo que la oferta. Déjalo vacío para pedir revisar condiciones.'**
  String get negotiateTargetHelper;

  /// No description provided for @negotiatePriorities.
  ///
  /// In es, this message translates to:
  /// **'Qué más te importa'**
  String get negotiatePriorities;

  /// No description provided for @negotiatePrioritiesHint.
  ///
  /// In es, this message translates to:
  /// **'Fecha de inicio, días de vacaciones, equipo, horario…'**
  String get negotiatePrioritiesHint;

  /// No description provided for @negotiateEnglish.
  ///
  /// In es, this message translates to:
  /// **'Escribir la respuesta en inglés'**
  String get negotiateEnglish;

  /// No description provided for @negotiateGenerate.
  ///
  /// In es, this message translates to:
  /// **'Preparar respuesta'**
  String get negotiateGenerate;

  /// No description provided for @negotiateGenerating.
  ///
  /// In es, this message translates to:
  /// **'Preparando la respuesta…'**
  String get negotiateGenerating;

  /// No description provided for @negotiateEmail.
  ///
  /// In es, this message translates to:
  /// **'Respuesta para la empresa'**
  String get negotiateEmail;

  /// No description provided for @negotiatePoints.
  ///
  /// In es, this message translates to:
  /// **'Argumentos para la llamada'**
  String get negotiatePoints;

  /// No description provided for @negotiateRisks.
  ///
  /// In es, this message translates to:
  /// **'Antes de aceptar, confirma'**
  String get negotiateRisks;

  /// No description provided for @negotiateError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo preparar la respuesta. Inténtalo de nuevo.'**
  String get negotiateError;

  /// No description provided for @briefTitle.
  ///
  /// In es, this message translates to:
  /// **'Ficha de la empresa'**
  String get briefTitle;

  /// No description provided for @briefOpen.
  ///
  /// In es, this message translates to:
  /// **'Ficha de la empresa'**
  String get briefOpen;

  /// No description provided for @briefIntro.
  ///
  /// In es, this message translates to:
  /// **'Un resumen de la empresa y del puesto a partir de la oferta, con preguntas para la entrevista.'**
  String get briefIntro;

  /// No description provided for @briefGenerate.
  ///
  /// In es, this message translates to:
  /// **'Preparar ficha'**
  String get briefGenerate;

  /// No description provided for @briefRegenerate.
  ///
  /// In es, this message translates to:
  /// **'Volver a preparar'**
  String get briefRegenerate;

  /// No description provided for @briefGenerating.
  ///
  /// In es, this message translates to:
  /// **'Preparando la ficha…'**
  String get briefGenerating;

  /// No description provided for @briefError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo preparar la ficha. Inténtalo de nuevo.'**
  String get briefError;

  /// No description provided for @briefTeam.
  ///
  /// In es, this message translates to:
  /// **'Equipo y tecnología'**
  String get briefTeam;

  /// No description provided for @briefCulture.
  ///
  /// In es, this message translates to:
  /// **'Cultura y beneficios'**
  String get briefCulture;

  /// No description provided for @briefQuestions.
  ///
  /// In es, this message translates to:
  /// **'Preguntas para hacerles'**
  String get briefQuestions;

  /// No description provided for @briefRedFlags.
  ///
  /// In es, this message translates to:
  /// **'Conviene aclarar'**
  String get briefRedFlags;

  /// No description provided for @briefGeneral.
  ///
  /// In es, this message translates to:
  /// **'Información general (no viene de la oferta)'**
  String get briefGeneral;

  /// No description provided for @briefGeneratedAt.
  ///
  /// In es, this message translates to:
  /// **'Preparada el {date}'**
  String briefGeneratedAt(String date);

  /// No description provided for @homeGreeting.
  ///
  /// In es, this message translates to:
  /// **'Hola, {name}'**
  String homeGreeting(String name);

  /// No description provided for @homeGreetingNoName.
  ///
  /// In es, this message translates to:
  /// **'Hola'**
  String get homeGreetingNoName;

  /// No description provided for @homeToday.
  ///
  /// In es, this message translates to:
  /// **'Para hoy'**
  String get homeToday;

  /// No description provided for @homeTaskCount.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 tarea} other{{count} tareas}}'**
  String homeTaskCount(int count);

  /// No description provided for @homeAllDoneTitle.
  ///
  /// In es, this message translates to:
  /// **'Todo al día'**
  String get homeAllDoneTitle;

  /// No description provided for @homeAllDoneBody.
  ///
  /// In es, this message translates to:
  /// **'No tienes tareas pendientes. La próxima búsqueda automática es mañana a las 7:00.'**
  String get homeAllDoneBody;

  /// No description provided for @homeTaskFollowUp.
  ///
  /// In es, this message translates to:
  /// **'Seguimiento a {company}'**
  String homeTaskFollowUp(String company);

  /// No description provided for @homeTaskInterview.
  ///
  /// In es, this message translates to:
  /// **'Prepara tu entrevista'**
  String get homeTaskInterview;

  /// No description provided for @homeMetricActive.
  ///
  /// In es, this message translates to:
  /// **'Activos'**
  String get homeMetricActive;

  /// No description provided for @homeMetricInterviews.
  ///
  /// In es, this message translates to:
  /// **'Entrevistas'**
  String get homeMetricInterviews;

  /// No description provided for @homeMetricSuggested.
  ///
  /// In es, this message translates to:
  /// **'Sugeridas'**
  String get homeMetricSuggested;

  /// No description provided for @applicationsNeedsAction.
  ///
  /// In es, this message translates to:
  /// **'Necesita acción'**
  String get applicationsNeedsAction;

  /// No description provided for @profileCompleteLabel.
  ///
  /// In es, this message translates to:
  /// **'Perfil completo'**
  String get profileCompleteLabel;

  /// No description provided for @resumeMissingContact.
  ///
  /// In es, this message translates to:
  /// **'A tu HV le falta el correo o el teléfono. Añádelos en tus datos básicos para que la empresa pueda contactarte.'**
  String get resumeMissingContact;

  /// No description provided for @filterGoodMatch.
  ///
  /// In es, this message translates to:
  /// **'Nota ≥ {score}'**
  String filterGoodMatch(int score);

  /// No description provided for @filterRecent.
  ///
  /// In es, this message translates to:
  /// **'Últimos {days} días'**
  String filterRecent(int days);

  /// No description provided for @filterSource.
  ///
  /// In es, this message translates to:
  /// **'Portal'**
  String get filterSource;

  /// No description provided for @filterAllSources.
  ///
  /// In es, this message translates to:
  /// **'Todos los portales'**
  String get filterAllSources;

  /// No description provided for @filterClear.
  ///
  /// In es, this message translates to:
  /// **'Quitar filtros'**
  String get filterClear;

  /// No description provided for @filterNoResults.
  ///
  /// In es, this message translates to:
  /// **'Ninguna oferta coincide con estos filtros.'**
  String get filterNoResults;

  /// No description provided for @dismissedTitle.
  ///
  /// In es, this message translates to:
  /// **'Descartadas · {count}'**
  String dismissedTitle(int count);

  /// No description provided for @dismissedHint.
  ///
  /// In es, this message translates to:
  /// **'Las que descartaste en los últimos 30 días.'**
  String get dismissedHint;

  /// No description provided for @dismissedRestore.
  ///
  /// In es, this message translates to:
  /// **'Recuperar'**
  String get dismissedRestore;

  /// No description provided for @suggestionRestored.
  ///
  /// In es, this message translates to:
  /// **'Oferta recuperada: vuelve a estar en Sugeridas.'**
  String get suggestionRestored;

  /// No description provided for @pasteFromClipboard.
  ///
  /// In es, this message translates to:
  /// **'Pegar'**
  String get pasteFromClipboard;

  /// No description provided for @clipboardEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay texto copiado.'**
  String get clipboardEmpty;

  /// No description provided for @reviewTitle.
  ///
  /// In es, this message translates to:
  /// **'Revisión ATS'**
  String get reviewTitle;

  /// No description provided for @reviewCardBody.
  ///
  /// In es, this message translates to:
  /// **'Revisa tu HV base como la leería un ATS y mira qué mejorar.'**
  String get reviewCardBody;

  /// No description provided for @reviewScoreCaption.
  ///
  /// In es, this message translates to:
  /// **'Nota de tu HV base'**
  String get reviewScoreCaption;

  /// No description provided for @reviewAllGood.
  ///
  /// In es, this message translates to:
  /// **'Tu HV cumple todas las comprobaciones. Revisa ahora las palabras clave de tus cargos.'**
  String get reviewAllGood;

  /// No description provided for @reviewFix.
  ///
  /// In es, this message translates to:
  /// **'Corregir'**
  String get reviewFix;

  /// No description provided for @severityHigh.
  ///
  /// In es, this message translates to:
  /// **'Importante'**
  String get severityHigh;

  /// No description provided for @severityMedium.
  ///
  /// In es, this message translates to:
  /// **'Recomendado'**
  String get severityMedium;

  /// No description provided for @severityLow.
  ///
  /// In es, this message translates to:
  /// **'Detalle'**
  String get severityLow;

  /// No description provided for @issueNoName.
  ///
  /// In es, this message translates to:
  /// **'Falta tu nombre.'**
  String get issueNoName;

  /// No description provided for @issueNoEmail.
  ///
  /// In es, this message translates to:
  /// **'Falta tu correo: la empresa no podrá contactarte.'**
  String get issueNoEmail;

  /// No description provided for @issueNoPhone.
  ///
  /// In es, this message translates to:
  /// **'Falta tu teléfono.'**
  String get issueNoPhone;

  /// No description provided for @issueNoHeadline.
  ///
  /// In es, this message translates to:
  /// **'Falta un titular, por ejemplo «Flutter Developer»: es lo primero que lee el ATS.'**
  String get issueNoHeadline;

  /// No description provided for @issueNoSummary.
  ///
  /// In es, this message translates to:
  /// **'Falta el perfil profesional: 3 o 4 frases sobre qué haces y qué has logrado.'**
  String get issueNoSummary;

  /// No description provided for @issueShortSummary.
  ///
  /// In es, this message translates to:
  /// **'Tu perfil profesional es corto ({count} caracteres). Apunta a 300-600.'**
  String issueShortSummary(int count);

  /// No description provided for @issueLongSummary.
  ///
  /// In es, this message translates to:
  /// **'Tu perfil profesional es largo ({count} caracteres). Déjalo por debajo de 700.'**
  String issueLongSummary(int count);

  /// No description provided for @issueNoLink.
  ///
  /// In es, this message translates to:
  /// **'Añade tu LinkedIn, GitHub o portafolio.'**
  String get issueNoLink;

  /// No description provided for @issueNoExperience.
  ///
  /// In es, this message translates to:
  /// **'Añade tu experiencia laboral.'**
  String get issueNoExperience;

  /// No description provided for @issueNoAchievements.
  ///
  /// In es, this message translates to:
  /// **'{role} en {company}: no tiene logros.'**
  String issueNoAchievements(String role, String company);

  /// No description provided for @issueFewNumbers.
  ///
  /// In es, this message translates to:
  /// **'{role} en {company}: {count, plural, =1{1 logro sin cifras} other{{count} logros sin cifras}}. Añade porcentajes, tiempos, usuarios o volumen.'**
  String issueFewNumbers(String role, String company, int count);

  /// No description provided for @issueWeakStart.
  ///
  /// In es, this message translates to:
  /// **'{role} en {company}: {count, plural, =1{1 logro empieza} other{{count} logros empiezan}} como tarea («Responsable de…»). Empieza con un verbo de acción: «Reduje», «Lancé», «Automaticé».'**
  String issueWeakStart(String role, String company, int count);

  /// No description provided for @issueLongBullets.
  ///
  /// In es, this message translates to:
  /// **'{role} en {company}: {count, plural, =1{1 logro es demasiado largo} other{{count} logros son demasiado largos}}. Una o dos líneas por logro.'**
  String issueLongBullets(String role, String company, int count);

  /// No description provided for @issueFewSkills.
  ///
  /// In es, this message translates to:
  /// **'Tienes {count} habilidades. Añade al menos 5.'**
  String issueFewSkills(int count);

  /// No description provided for @issueNoEducation.
  ///
  /// In es, this message translates to:
  /// **'Añade tus estudios.'**
  String get issueNoEducation;

  /// No description provided for @keywordsTitle.
  ///
  /// In es, this message translates to:
  /// **'Palabras clave de tus cargos'**
  String get keywordsTitle;

  /// No description provided for @keywordsHint.
  ///
  /// In es, this message translates to:
  /// **'La IA lista lo que los ATS buscan para tus cargos y Rumbo comprueba cuáles aparecen en tu HV.'**
  String get keywordsHint;

  /// No description provided for @keywordsLoad.
  ///
  /// In es, this message translates to:
  /// **'Buscar palabras clave'**
  String get keywordsLoad;

  /// No description provided for @keywordsReload.
  ///
  /// In es, this message translates to:
  /// **'Volver a buscar'**
  String get keywordsReload;

  /// No description provided for @keywordsMissing.
  ///
  /// In es, this message translates to:
  /// **'No aparecen · {count}'**
  String keywordsMissing(int count);

  /// No description provided for @keywordsMissingHint.
  ///
  /// In es, this message translates to:
  /// **'Si de verdad las dominas, añádelas a tus logros o habilidades. Toca una para añadirla como habilidad.'**
  String get keywordsMissingHint;

  /// No description provided for @keywordsNoRoles.
  ///
  /// In es, this message translates to:
  /// **'Escribe tus cargos en Preferencias de búsqueda para buscar sus palabras clave.'**
  String get keywordsNoRoles;

  /// No description provided for @keywordsError.
  ///
  /// In es, this message translates to:
  /// **'No se pudieron obtener las palabras clave. Inténtalo de nuevo.'**
  String get keywordsError;

  /// No description provided for @remindersTitle.
  ///
  /// In es, this message translates to:
  /// **'Recordatorios'**
  String get remindersTitle;

  /// No description provided for @remindersHint.
  ///
  /// In es, this message translates to:
  /// **'Avisos en este teléfono, aunque Rumbo esté cerrado. No necesitan internet.'**
  String get remindersHint;

  /// No description provided for @remindersProcesses.
  ///
  /// In es, this message translates to:
  /// **'Seguimientos y entrevistas'**
  String get remindersProcesses;

  /// No description provided for @remindersProcessesHint.
  ///
  /// In es, this message translates to:
  /// **'El día del seguimiento a las 9:00, la víspera de cada entrevista a las 19:00 y una hora antes.'**
  String get remindersProcessesHint;

  /// No description provided for @remindersDaily.
  ///
  /// In es, this message translates to:
  /// **'Recordatorio diario'**
  String get remindersDaily;

  /// No description provided for @remindersDailyHint.
  ///
  /// In es, this message translates to:
  /// **'Cada día a las 8:00, para revisar sugerencias y tareas.'**
  String get remindersDailyHint;

  /// No description provided for @remindersDenied.
  ///
  /// In es, this message translates to:
  /// **'Las notificaciones de Rumbo están desactivadas. Actívalas en los ajustes del teléfono.'**
  String get remindersDenied;

  /// No description provided for @remindersPlanned.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{No hay avisos programados.} =1{1 aviso programado.} other{{count} avisos programados.}}'**
  String remindersPlanned(int count);

  /// No description provided for @remindersTest.
  ///
  /// In es, this message translates to:
  /// **'Enviar aviso de prueba'**
  String get remindersTest;

  /// No description provided for @reminderTestTitle.
  ///
  /// In es, this message translates to:
  /// **'Así se verán tus recordatorios'**
  String get reminderTestTitle;

  /// No description provided for @reminderTestBody.
  ///
  /// In es, this message translates to:
  /// **'Rumbo te avisará de seguimientos y entrevistas.'**
  String get reminderTestBody;

  /// No description provided for @reminderFollowUpTitle.
  ///
  /// In es, this message translates to:
  /// **'Toca hacer seguimiento'**
  String get reminderFollowUpTitle;

  /// No description provided for @reminderFollowUpBody.
  ///
  /// In es, this message translates to:
  /// **'{role} en {company}: escribe a la empresa para saber cómo va tu proceso.'**
  String reminderFollowUpBody(String role, String company);

  /// No description provided for @reminderEveTitle.
  ///
  /// In es, this message translates to:
  /// **'Mañana tienes entrevista'**
  String get reminderEveTitle;

  /// No description provided for @reminderEveBody.
  ///
  /// In es, this message translates to:
  /// **'{company} a las {time}. Repasa la ficha de la empresa y practica unos minutos.'**
  String reminderEveBody(String company, String time);

  /// No description provided for @reminderSoonTitle.
  ///
  /// In es, this message translates to:
  /// **'Entrevista en una hora'**
  String get reminderSoonTitle;

  /// No description provided for @reminderSoonBody.
  ///
  /// In es, this message translates to:
  /// **'{company} a las {time}. ¡Mucha suerte!'**
  String reminderSoonBody(String company, String time);

  /// No description provided for @reminderDailyTitle.
  ///
  /// In es, this message translates to:
  /// **'Revisa tu búsqueda'**
  String get reminderDailyTitle;

  /// No description provided for @reminderDailyBody.
  ///
  /// In es, this message translates to:
  /// **'Mira tus sugerencias nuevas y las tareas de hoy en Rumbo.'**
  String get reminderDailyBody;

  /// No description provided for @aiErrorDailyLimit.
  ///
  /// In es, this message translates to:
  /// **'Llegaste al límite diario de uso de la IA en Rumbo. Vuelve a intentarlo mañana.'**
  String get aiErrorDailyLimit;

  /// No description provided for @welcomeTitle.
  ///
  /// In es, this message translates to:
  /// **'Antes de empezar'**
  String get welcomeTitle;

  /// No description provided for @welcomeIntro.
  ///
  /// In es, this message translates to:
  /// **'Rumbo te ayuda a encontrar ofertas, adaptar tu HV con IA y seguir cada proceso hasta la oferta.'**
  String get welcomeIntro;

  /// No description provided for @welcomeDataTitle.
  ///
  /// In es, this message translates to:
  /// **'Cómo se usan tus datos'**
  String get welcomeDataTitle;

  /// No description provided for @welcomePrivate.
  ///
  /// In es, this message translates to:
  /// **'Tu perfil, tus ofertas y tus procesos se guardan en una base de datos privada: solo tú puedes verlos.'**
  String get welcomePrivate;

  /// No description provided for @welcomeAi.
  ///
  /// In es, this message translates to:
  /// **'Para analizar ofertas y adaptar tu HV, Rumbo envía el texto necesario a Google Gemini en su nivel gratuito. Google puede usar ese contenido para mejorar sus productos, así que no incluyas datos sensibles como tu número de documento.'**
  String get welcomeAi;

  /// No description provided for @welcomeLimit.
  ///
  /// In es, this message translates to:
  /// **'Cada persona puede usar la IA hasta {limit} veces al día.'**
  String welcomeLimit(int limit);

  /// No description provided for @welcomeDelete.
  ///
  /// In es, this message translates to:
  /// **'Puedes eliminar tu cuenta y todos tus datos cuando quieras desde Más.'**
  String get welcomeDelete;

  /// No description provided for @welcomeAccept.
  ///
  /// In es, this message translates to:
  /// **'Acepto y empiezo'**
  String get welcomeAccept;

  /// No description provided for @welcomeLeave.
  ///
  /// In es, this message translates to:
  /// **'Salir'**
  String get welcomeLeave;

  /// No description provided for @firstStepsTitle.
  ///
  /// In es, this message translates to:
  /// **'Primeros pasos'**
  String get firstStepsTitle;

  /// No description provided for @firstStepsProfile.
  ///
  /// In es, this message translates to:
  /// **'Completa tu HV: importa tu PDF o escribe tus datos'**
  String get firstStepsProfile;

  /// No description provided for @firstStepsSearch.
  ///
  /// In es, this message translates to:
  /// **'Dile a Rumbo qué cargos buscas'**
  String get firstStepsSearch;

  /// No description provided for @firstStepsGmail.
  ///
  /// In es, this message translates to:
  /// **'Opcional: conecta Gmail para detectar respuestas'**
  String get firstStepsGmail;

  /// No description provided for @updateAvailable.
  ///
  /// In es, this message translates to:
  /// **'Hay una versión nueva de Rumbo ({version}).'**
  String updateAvailable(String version);

  /// No description provided for @updateDownload.
  ///
  /// In es, this message translates to:
  /// **'Descargar'**
  String get updateDownload;

  /// No description provided for @deleteAccount.
  ///
  /// In es, this message translates to:
  /// **'Eliminar cuenta'**
  String get deleteAccount;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar tu cuenta?'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountBody.
  ///
  /// In es, this message translates to:
  /// **'Se borrarán tu perfil, tus ofertas, tus procesos, tus entrevistas y todo lo demás. No se puede deshacer.'**
  String get deleteAccountBody;

  /// No description provided for @deleteAccountConfirm.
  ///
  /// In es, this message translates to:
  /// **'Eliminar todo'**
  String get deleteAccountConfirm;

  /// No description provided for @deleteAccountError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo eliminar la cuenta. Inténtalo de nuevo.'**
  String get deleteAccountError;

  /// No description provided for @reviewRefresh.
  ///
  /// In es, this message translates to:
  /// **'Volver a revisar'**
  String get reviewRefresh;

  /// No description provided for @reviewScoreUp.
  ///
  /// In es, this message translates to:
  /// **'Revisión actualizada: tu nota subió de {from} a {to}.'**
  String reviewScoreUp(int from, int to);

  /// No description provided for @reviewScoreDown.
  ///
  /// In es, this message translates to:
  /// **'Revisión actualizada: tu nota bajó de {from} a {to}.'**
  String reviewScoreDown(int from, int to);

  /// No description provided for @reviewScoreSame.
  ///
  /// In es, this message translates to:
  /// **'Revisión actualizada: tu nota sigue en {score}.'**
  String reviewScoreSame(int score);

  /// No description provided for @categoryContact.
  ///
  /// In es, this message translates to:
  /// **'Contacto'**
  String get categoryContact;

  /// No description provided for @categoryStructure.
  ///
  /// In es, this message translates to:
  /// **'Estructura'**
  String get categoryStructure;

  /// No description provided for @categoryAchievements.
  ///
  /// In es, this message translates to:
  /// **'Logros'**
  String get categoryAchievements;

  /// No description provided for @categoryCoherence.
  ///
  /// In es, this message translates to:
  /// **'Coherencia y palabras clave'**
  String get categoryCoherence;

  /// No description provided for @categoryFormat.
  ///
  /// In es, this message translates to:
  /// **'Formato'**
  String get categoryFormat;

  /// No description provided for @reviewCategoriesTitle.
  ///
  /// In es, this message translates to:
  /// **'Nota por partes'**
  String get reviewCategoriesTitle;

  /// No description provided for @reviewCategoryIssues.
  ///
  /// In es, this message translates to:
  /// **'{category} · {count}'**
  String reviewCategoryIssues(String category, int count);

  /// No description provided for @reviewHistoryStart.
  ///
  /// In es, this message translates to:
  /// **'Empezaste en {score}'**
  String reviewHistoryStart(int score);

  /// No description provided for @issueInvalidEmail.
  ///
  /// In es, this message translates to:
  /// **'Tu correo no parece válido. Revisa que esté bien escrito.'**
  String get issueInvalidEmail;

  /// No description provided for @issuePhoneNoCountryCode.
  ///
  /// In es, this message translates to:
  /// **'Añade el indicativo a tu teléfono (+57): muchas empresas remotas son de otros países.'**
  String get issuePhoneNoCountryCode;

  /// No description provided for @issueNoLocation.
  ///
  /// In es, this message translates to:
  /// **'Añade tu ciudad y país: los ATS filtran por ubicación.'**
  String get issueNoLocation;

  /// No description provided for @issueInvalidLink.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{Un enlace no es válido} other{{count} enlaces no son válidos}}: deben empezar por https://.'**
  String issueInvalidLink(int count);

  /// No description provided for @issueEndBeforeStart.
  ///
  /// In es, this message translates to:
  /// **'{role} en {company}: la fecha de fin es anterior a la de inicio.'**
  String issueEndBeforeStart(String role, String company);

  /// No description provided for @issueFutureDate.
  ///
  /// In es, this message translates to:
  /// **'{role} en {company}: tiene una fecha en el futuro.'**
  String issueFutureDate(String role, String company);

  /// No description provided for @issueDateGap.
  ///
  /// In es, this message translates to:
  /// **'Hay un hueco de {count} meses antes de {role} en {company}. Si estudiaste o trabajaste por tu cuenta, añádelo.'**
  String issueDateGap(int count, String role, String company);

  /// No description provided for @issueSeveralCurrent.
  ///
  /// In es, this message translates to:
  /// **'Tienes {count} empleos marcados como actuales. Pon fecha de fin a los que terminaron.'**
  String issueSeveralCurrent(int count);

  /// No description provided for @issueFirstPerson.
  ///
  /// In es, this message translates to:
  /// **'{role} en {company}: {count, plural, =1{1 logro está escrito} other{{count} logros están escritos}} en primera persona («yo», «mi»). Escríbelos sin sujeto: «Reduje…», «Lancé…».'**
  String issueFirstPerson(String role, String company, int count);

  /// No description provided for @issueDuplicates.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{Hay 1 logro repetido} other{Hay {count} logros repetidos}} entre empleos.'**
  String issueDuplicates(int count);

  /// No description provided for @issueBuzzwords.
  ///
  /// In es, this message translates to:
  /// **'Evita frases vacías como «{words}»: demuéstralo con un logro concreto.'**
  String issueBuzzwords(String words);

  /// No description provided for @issueTechNotInSkills.
  ///
  /// In es, this message translates to:
  /// **'Usas {words} en tu experiencia pero no {count, plural, =1{está} other{están}} en Habilidades. Añádelas: los ATS buscan en esa sección.'**
  String issueTechNotInSkills(String words, int count);

  /// No description provided for @issueHeadlineNoRole.
  ///
  /// In es, this message translates to:
  /// **'Tu titular no menciona el cargo que buscas («{role}»). Los ATS comparan el titular con el puesto.'**
  String issueHeadlineNoRole(String role);

  /// No description provided for @issueSummaryNoTech.
  ///
  /// In es, this message translates to:
  /// **'Tu perfil profesional no menciona tus tecnologías principales.'**
  String get issueSummaryNoTech;

  /// No description provided for @issueSummaryNoYears.
  ///
  /// In es, this message translates to:
  /// **'Indica en tu perfil profesional cuántos años de experiencia tienes, por ejemplo «3 años con Flutter».'**
  String get issueSummaryNoYears;

  /// No description provided for @issueSpecialCharacters.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 texto tiene} other{{count} textos tienen}} emojis o símbolos (★, ✔, •) que los ATS leen mal.'**
  String issueSpecialCharacters(int count);

  /// No description provided for @issueAllCaps.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 texto está} other{{count} textos están}} en MAYÚSCULAS. Escríbelos en minúsculas normales.'**
  String issueAllCaps(int count);

  /// No description provided for @issueMixedLanguages.
  ///
  /// In es, this message translates to:
  /// **'Mezclas español e inglés en tu HV. Usa un solo idioma: Rumbo la traduce al adaptarla a cada oferta.'**
  String get issueMixedLanguages;

  /// No description provided for @issueTooLong.
  ///
  /// In es, this message translates to:
  /// **'Tu HV tiene {count} palabras: pasa de dos páginas. Recorta logros antiguos o poco relevantes.'**
  String issueTooLong(int count);

  /// No description provided for @issueTooShort.
  ///
  /// In es, this message translates to:
  /// **'Tu HV tiene solo {count} palabras. Añade logros para que el ATS tenga con qué compararte.'**
  String issueTooShort(int count);

  /// No description provided for @keywordsInExperience.
  ///
  /// In es, this message translates to:
  /// **'En tu experiencia · {count}'**
  String keywordsInExperience(int count);

  /// No description provided for @keywordsOnlySkills.
  ///
  /// In es, this message translates to:
  /// **'Solo en Habilidades · {count}'**
  String keywordsOnlySkills(int count);

  /// No description provided for @keywordsOnlySkillsHint.
  ///
  /// In es, this message translates to:
  /// **'Menciónalas en un logro: los ATS valoran más una tecnología usada en tu experiencia que en una lista.'**
  String get keywordsOnlySkillsHint;

  /// No description provided for @keywordsMarketHint.
  ///
  /// In es, this message translates to:
  /// **'El número indica en cuántas de tus {count} ofertas aparece.'**
  String keywordsMarketHint(int count);

  /// No description provided for @keywordsUpdated.
  ///
  /// In es, this message translates to:
  /// **'Actualizadas el {date}.'**
  String keywordsUpdated(String date);

  /// No description provided for @atsTest.
  ///
  /// In es, this message translates to:
  /// **'Probar cómo lo lee un ATS'**
  String get atsTest;

  /// No description provided for @atsTestTitle.
  ///
  /// In es, this message translates to:
  /// **'Así lee tu PDF un ATS'**
  String get atsTestTitle;

  /// No description provided for @atsTestSummary.
  ///
  /// In es, this message translates to:
  /// **'{passed} de {total} comprobaciones superadas'**
  String atsTestSummary(int passed, int total);

  /// No description provided for @atsName.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get atsName;

  /// No description provided for @atsEmail.
  ///
  /// In es, this message translates to:
  /// **'Correo'**
  String get atsEmail;

  /// No description provided for @atsPhone.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get atsPhone;

  /// No description provided for @atsLink.
  ///
  /// In es, this message translates to:
  /// **'Enlace (LinkedIn o portafolio)'**
  String get atsLink;

  /// No description provided for @atsLocation.
  ///
  /// In es, this message translates to:
  /// **'Ciudad y país'**
  String get atsLocation;

  /// No description provided for @atsSections.
  ///
  /// In es, this message translates to:
  /// **'Secciones: perfil, experiencia, estudios y habilidades'**
  String get atsSections;

  /// No description provided for @atsExperiences.
  ///
  /// In es, this message translates to:
  /// **'Cargos y empresas'**
  String get atsExperiences;

  /// No description provided for @atsDates.
  ///
  /// In es, this message translates to:
  /// **'Fechas de cada empleo'**
  String get atsDates;

  /// No description provided for @atsSkills.
  ///
  /// In es, this message translates to:
  /// **'Habilidades'**
  String get atsSkills;

  /// No description provided for @atsCharacters.
  ///
  /// In es, this message translates to:
  /// **'Sin caracteres rotos'**
  String get atsCharacters;

  /// No description provided for @atsCompleteness.
  ///
  /// In es, this message translates to:
  /// **'Texto completo ({percent} % leído)'**
  String atsCompleteness(String percent);

  /// No description provided for @atsPages.
  ///
  /// In es, this message translates to:
  /// **'Extensión: {pages} páginas (máximo 2)'**
  String atsPages(String pages);

  /// No description provided for @atsMissing.
  ///
  /// In es, this message translates to:
  /// **'No se encontró: {detail}'**
  String atsMissing(String detail);

  /// No description provided for @atsExtractedText.
  ///
  /// In es, this message translates to:
  /// **'Texto que lee el ATS'**
  String get atsExtractedText;

  /// No description provided for @atsError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo leer el PDF. Inténtalo de nuevo.'**
  String get atsError;

  /// No description provided for @coverageTitle.
  ///
  /// In es, this message translates to:
  /// **'Palabras clave de esta oferta'**
  String get coverageTitle;

  /// No description provided for @coverageHint.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 palabra clave detectada} other{{count} palabras clave detectadas}} en la oferta.'**
  String coverageHint(int count);

  /// No description provided for @coverageBase.
  ///
  /// In es, this message translates to:
  /// **'Tu HV base'**
  String get coverageBase;

  /// No description provided for @coverageTailored.
  ///
  /// In es, this message translates to:
  /// **'HV adaptada'**
  String get coverageTailored;

  /// No description provided for @coverageMissing.
  ///
  /// In es, this message translates to:
  /// **'Siguen faltando: {words}. Añádelas solo si de verdad las dominas.'**
  String coverageMissing(String words);

  /// No description provided for @improveWithAi.
  ///
  /// In es, this message translates to:
  /// **'Mejorar con IA'**
  String get improveWithAi;

  /// No description provided for @improveTitle.
  ///
  /// In es, this message translates to:
  /// **'Mejorar logros'**
  String get improveTitle;

  /// No description provided for @improveHint.
  ///
  /// In es, this message translates to:
  /// **'La IA propone y tú decides. Completa los huecos [entre corchetes] con tus datos reales: nunca inventa cifras.'**
  String get improveHint;

  /// No description provided for @improveBefore.
  ///
  /// In es, this message translates to:
  /// **'Antes'**
  String get improveBefore;

  /// No description provided for @improveNew.
  ///
  /// In es, this message translates to:
  /// **'Logro nuevo'**
  String get improveNew;

  /// No description provided for @improveUse.
  ///
  /// In es, this message translates to:
  /// **'Usar'**
  String get improveUse;

  /// No description provided for @improveFill.
  ///
  /// In es, this message translates to:
  /// **'Completa los huecos entre corchetes de los logros que vas a usar.'**
  String get improveFill;

  /// No description provided for @improveSave.
  ///
  /// In es, this message translates to:
  /// **'Guardar logros'**
  String get improveSave;

  /// No description provided for @improveSaved.
  ///
  /// In es, this message translates to:
  /// **'Logros actualizados.'**
  String get improveSaved;

  /// No description provided for @improveEmpty.
  ///
  /// In es, this message translates to:
  /// **'Tus logros ya están bien escritos: la IA no propone cambios.'**
  String get improveEmpty;

  /// No description provided for @improveLoading.
  ///
  /// In es, this message translates to:
  /// **'Revisando tus logros…'**
  String get improveLoading;

  /// No description provided for @emailDraftsTitle.
  ///
  /// In es, this message translates to:
  /// **'Escribir a la empresa'**
  String get emailDraftsTitle;

  /// No description provided for @emailDraftsHint.
  ///
  /// In es, this message translates to:
  /// **'La IA redacta el correo y tú lo revisas y lo envías desde tu correo.'**
  String get emailDraftsHint;

  /// No description provided for @emailKindFollowUp.
  ///
  /// In es, this message translates to:
  /// **'Seguimiento'**
  String get emailKindFollowUp;

  /// No description provided for @emailKindThankYou.
  ///
  /// In es, this message translates to:
  /// **'Agradecer la entrevista'**
  String get emailKindThankYou;

  /// No description provided for @emailKindRejection.
  ///
  /// In es, this message translates to:
  /// **'Responder al rechazo'**
  String get emailKindRejection;

  /// No description provided for @emailDraftWriting.
  ///
  /// In es, this message translates to:
  /// **'Redactando el correo…'**
  String get emailDraftWriting;

  /// No description provided for @emailTo.
  ///
  /// In es, this message translates to:
  /// **'Para'**
  String get emailTo;

  /// No description provided for @emailSubject.
  ///
  /// In es, this message translates to:
  /// **'Asunto'**
  String get emailSubject;

  /// No description provided for @emailBody.
  ///
  /// In es, this message translates to:
  /// **'Mensaje'**
  String get emailBody;

  /// No description provided for @emailCopy.
  ///
  /// In es, this message translates to:
  /// **'Copiar'**
  String get emailCopy;

  /// No description provided for @emailCopied.
  ///
  /// In es, this message translates to:
  /// **'Correo copiado. Pégalo en tu correo.'**
  String get emailCopied;

  /// No description provided for @emailOpen.
  ///
  /// In es, this message translates to:
  /// **'Abrir en el correo'**
  String get emailOpen;

  /// No description provided for @emailOpenError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo abrir la app de correo. Usa «Copiar».'**
  String get emailOpenError;

  /// No description provided for @emailRegenerate.
  ///
  /// In es, this message translates to:
  /// **'Otra versión'**
  String get emailRegenerate;

  /// No description provided for @emailReviewHint.
  ///
  /// In es, this message translates to:
  /// **'Revisa el texto antes de enviarlo: Rumbo nunca envía correos por ti.'**
  String get emailReviewHint;

  /// No description provided for @learningTitle.
  ///
  /// In es, this message translates to:
  /// **'Plan de aprendizaje'**
  String get learningTitle;

  /// No description provided for @learningCardEmpty.
  ///
  /// In es, this message translates to:
  /// **'Descubre qué aprender según lo que piden tus ofertas.'**
  String get learningCardEmpty;

  /// No description provided for @learningCardSummary.
  ///
  /// In es, this message translates to:
  /// **'{topics, plural, =1{1 tema} other{{topics} temas}} · {learning} aprendiendo · {mastered} dominados'**
  String learningCardSummary(int topics, int learning, int mastered);

  /// No description provided for @learningMine.
  ///
  /// In es, this message translates to:
  /// **'Tu plan'**
  String get learningMine;

  /// No description provided for @learningSuggestions.
  ///
  /// In es, this message translates to:
  /// **'Qué te conviene aprender'**
  String get learningSuggestions;

  /// No description provided for @learningSuggestionsHint.
  ///
  /// In es, this message translates to:
  /// **'Lo que piden tus ofertas y no aparece en tu HV. El número es en cuántas de tus ofertas sale.'**
  String get learningSuggestionsHint;

  /// No description provided for @learningNoSuggestions.
  ///
  /// In es, this message translates to:
  /// **'Sin sugerencias por ahora. Busca las palabras clave de tus cargos en la Revisión ATS o analiza más ofertas.'**
  String get learningNoSuggestions;

  /// No description provided for @learningOpenReview.
  ///
  /// In es, this message translates to:
  /// **'Ir a la Revisión ATS'**
  String get learningOpenReview;

  /// No description provided for @learningAdd.
  ///
  /// In es, this message translates to:
  /// **'Añadir al plan'**
  String get learningAdd;

  /// No description provided for @learningAdded.
  ///
  /// In es, this message translates to:
  /// **'«{topic}» añadido a tu plan.'**
  String learningAdded(String topic);

  /// No description provided for @learningDemand.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{No sale en tus ofertas} =1{Sale en 1 oferta} other{Sale en {count} ofertas}}'**
  String learningDemand(int count);

  /// No description provided for @learningStatusPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get learningStatusPending;

  /// No description provided for @learningStatusLearning.
  ///
  /// In es, this message translates to:
  /// **'Aprendiendo'**
  String get learningStatusLearning;

  /// No description provided for @learningStatusMastered.
  ///
  /// In es, this message translates to:
  /// **'Dominado'**
  String get learningStatusMastered;

  /// No description provided for @learningGenerate.
  ///
  /// In es, this message translates to:
  /// **'Crear plan con IA'**
  String get learningGenerate;

  /// No description provided for @learningGenerating.
  ///
  /// In es, this message translates to:
  /// **'Preparando tu plan…'**
  String get learningGenerating;

  /// No description provided for @learningRegenerate.
  ///
  /// In es, this message translates to:
  /// **'Otro plan'**
  String get learningRegenerate;

  /// No description provided for @learningWhy.
  ///
  /// In es, this message translates to:
  /// **'Por qué te lo piden'**
  String get learningWhy;

  /// No description provided for @learningSteps.
  ///
  /// In es, this message translates to:
  /// **'Pasos'**
  String get learningSteps;

  /// No description provided for @learningResources.
  ///
  /// In es, this message translates to:
  /// **'Recursos gratuitos'**
  String get learningResources;

  /// No description provided for @learningNoResources.
  ///
  /// In es, this message translates to:
  /// **'No se pudieron comprobar los enlaces. Busca la documentación oficial del tema.'**
  String get learningNoResources;

  /// No description provided for @learningProject.
  ///
  /// In es, this message translates to:
  /// **'Mini proyecto para demostrarlo'**
  String get learningProject;

  /// No description provided for @learningHours.
  ///
  /// In es, this message translates to:
  /// **'Unas {hours} horas'**
  String learningHours(int hours);

  /// No description provided for @learningMasteredTitle.
  ///
  /// In es, this message translates to:
  /// **'¡Lo dominas!'**
  String get learningMasteredTitle;

  /// No description provided for @learningMasteredBody.
  ///
  /// In es, this message translates to:
  /// **'Añádelo a tus habilidades y menciónalo en un logro de tu experiencia: así sube tu nota ATS y tu compatibilidad.'**
  String get learningMasteredBody;

  /// No description provided for @learningAddSkill.
  ///
  /// In es, this message translates to:
  /// **'Añadir a habilidades'**
  String get learningAddSkill;

  /// No description provided for @learningAlreadySkill.
  ///
  /// In es, this message translates to:
  /// **'Ya está en tus habilidades.'**
  String get learningAlreadySkill;

  /// No description provided for @learningDelete.
  ///
  /// In es, this message translates to:
  /// **'Quitar del plan'**
  String get learningDelete;

  /// No description provided for @learningPlanHint.
  ///
  /// In es, this message translates to:
  /// **'La IA propone pasos, recursos y un proyecto. Los enlaces se comprueban antes de mostrártelos.'**
  String get learningPlanHint;

  /// No description provided for @watchedSuggestions.
  ///
  /// In es, this message translates to:
  /// **'Sugerencias con Flutter'**
  String get watchedSuggestions;

  /// No description provided for @watchedSuggestionsHint.
  ///
  /// In es, this message translates to:
  /// **'Empresas que trabajan con Flutter y contratan en remoto desde Colombia.'**
  String get watchedSuggestionsHint;

  /// No description provided for @watchedSuggestionNote.
  ///
  /// In es, this message translates to:
  /// **'{company, select, canonical{Ubuntu usa Flutter · remoto mundial} flutterflow{Constructor de apps Flutter · remoto global} truelogic{Desarrolladores para EE. UU. · remoto LATAM y Bogotá} supabase{SDK de Flutter · remoto global y América} revenuecat{SDK de Flutter · remoto América} other{}}'**
  String watchedSuggestionNote(String company);

  /// No description provided for @gmailLinkedinTitle.
  ///
  /// In es, this message translates to:
  /// **'Alertas de empleo de LinkedIn'**
  String get gmailLinkedinTitle;

  /// No description provided for @gmailLinkedinBody.
  ///
  /// In es, this message translates to:
  /// **'Crea alertas de empleo en LinkedIn (por ejemplo «Flutter Developer» en remoto). Cuando lleguen a tu Gmail, Rumbo convertirá cada oferta en una sugerencia de Ofertas con su compatibilidad. La nota sale del título, porque el correo no trae la descripción completa.'**
  String get gmailLinkedinBody;

  /// No description provided for @gmailLinkedinUpdate.
  ///
  /// In es, this message translates to:
  /// **'Tu script es anterior a las alertas de LinkedIn. Pulsa «Generar clave nueva y copiar», pega el script otra vez en tu proyecto y ejecuta «instalar».'**
  String get gmailLinkedinUpdate;

  /// No description provided for @jobCompleteTitle.
  ///
  /// In es, this message translates to:
  /// **'Completar oferta'**
  String get jobCompleteTitle;

  /// No description provided for @jobCompleteHint.
  ///
  /// In es, this message translates to:
  /// **'Pega la descripción completa de la oferta: ábrela en LinkedIn o en su portal y copia el texto. Rumbo la analizará y recalculará tu compatibilidad. Se conservan el cargo, la empresa, el enlace y su proceso.'**
  String get jobCompleteHint;

  /// No description provided for @jobCompleteLabel.
  ///
  /// In es, this message translates to:
  /// **'Descripción completa'**
  String get jobCompleteLabel;

  /// No description provided for @jobCompleteAction.
  ///
  /// In es, this message translates to:
  /// **'Analizar y completar'**
  String get jobCompleteAction;

  /// No description provided for @jobCompleted.
  ///
  /// In es, this message translates to:
  /// **'Oferta completada. Compatibilidad: {score}.'**
  String jobCompleted(int score);

  /// No description provided for @jobCompleteTooShort.
  ///
  /// In es, this message translates to:
  /// **'Pega al menos {count} caracteres de la descripción.'**
  String jobCompleteTooShort(int count);

  /// No description provided for @jobNeedsDescription.
  ///
  /// In es, this message translates to:
  /// **'Esta oferta llegó sin la descripción completa: la compatibilidad sale solo del título.'**
  String get jobNeedsDescription;

  /// No description provided for @jobUpdateDescription.
  ///
  /// In es, this message translates to:
  /// **'Completar o cambiar la descripción'**
  String get jobUpdateDescription;

  /// No description provided for @englishLevelLabel.
  ///
  /// In es, this message translates to:
  /// **'Nivel de inglés'**
  String get englishLevelLabel;

  /// No description provided for @englishLevelHelper.
  ///
  /// In es, this message translates to:
  /// **'La IA lo usa cuando una oferta pide inglés.'**
  String get englishLevelHelper;

  /// No description provided for @englishLevelNone.
  ///
  /// In es, this message translates to:
  /// **'Sin indicar'**
  String get englishLevelNone;

  /// No description provided for @englishLevelA1.
  ///
  /// In es, this message translates to:
  /// **'Principiante (A1)'**
  String get englishLevelA1;

  /// No description provided for @englishLevelA2.
  ///
  /// In es, this message translates to:
  /// **'Básico (A2)'**
  String get englishLevelA2;

  /// No description provided for @englishLevelB1.
  ///
  /// In es, this message translates to:
  /// **'Intermedio (B1)'**
  String get englishLevelB1;

  /// No description provided for @englishLevelB2.
  ///
  /// In es, this message translates to:
  /// **'Intermedio alto (B2)'**
  String get englishLevelB2;

  /// No description provided for @englishLevelC1.
  ///
  /// In es, this message translates to:
  /// **'Avanzado (C1)'**
  String get englishLevelC1;

  /// No description provided for @englishLevelC2.
  ///
  /// In es, this message translates to:
  /// **'Muy avanzado (C2)'**
  String get englishLevelC2;

  /// No description provided for @englishLevelNative.
  ///
  /// In es, this message translates to:
  /// **'Nativo o bilingüe'**
  String get englishLevelNative;

  /// No description provided for @salaryTitle.
  ///
  /// In es, this message translates to:
  /// **'Expectativa salarial (bruto mensual)'**
  String get salaryTitle;

  /// No description provided for @salaryHelper.
  ///
  /// In es, this message translates to:
  /// **'La IA la compara con el salario de las ofertas. Puedes llenar solo una moneda.'**
  String get salaryHelper;

  /// No description provided for @salaryMinLabel.
  ///
  /// In es, this message translates to:
  /// **'Mínimo {currency}'**
  String salaryMinLabel(String currency);

  /// No description provided for @salaryMaxLabel.
  ///
  /// In es, this message translates to:
  /// **'Máximo {currency}'**
  String salaryMaxLabel(String currency);

  /// No description provided for @salaryRangeInvalid.
  ///
  /// In es, this message translates to:
  /// **'El máximo no puede ser menor que el mínimo.'**
  String get salaryRangeInvalid;

  /// No description provided for @profileEnglish.
  ///
  /// In es, this message translates to:
  /// **'Inglés: {level}'**
  String profileEnglish(String level);

  /// No description provided for @profileSalary.
  ///
  /// In es, this message translates to:
  /// **'Expectativa: {range} al mes'**
  String profileSalary(String range);

  /// No description provided for @contactTitle.
  ///
  /// In es, this message translates to:
  /// **'Contacto y postulación'**
  String get contactTitle;

  /// No description provided for @contactAdd.
  ///
  /// In es, this message translates to:
  /// **'Añadir contacto del reclutador'**
  String get contactAdd;

  /// No description provided for @contactEmailCopied.
  ///
  /// In es, this message translates to:
  /// **'Correo copiado.'**
  String get contactEmailCopied;

  /// No description provided for @contactLinkedin.
  ///
  /// In es, this message translates to:
  /// **'Perfil o publicación en LinkedIn'**
  String get contactLinkedin;

  /// No description provided for @contactSubject.
  ///
  /// In es, this message translates to:
  /// **'Asunto: «{subject}»'**
  String contactSubject(String subject);

  /// No description provided for @contactAsksSalary.
  ///
  /// In es, this message translates to:
  /// **'Piden tu expectativa salarial'**
  String get contactAsksSalary;

  /// No description provided for @contactNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Reclutador'**
  String get contactNameLabel;

  /// No description provided for @contactEmailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo para postular'**
  String get contactEmailLabel;

  /// No description provided for @contactLinkedinLabel.
  ///
  /// In es, this message translates to:
  /// **'LinkedIn del reclutador o de la publicación'**
  String get contactLinkedinLabel;

  /// No description provided for @contactLinkedinHelper.
  ///
  /// In es, this message translates to:
  /// **'Enlace de linkedin.com.'**
  String get contactLinkedinHelper;

  /// No description provided for @contactSubjectLabel.
  ///
  /// In es, this message translates to:
  /// **'Asunto que piden'**
  String get contactSubjectLabel;

  /// No description provided for @contactSubjectHelper.
  ///
  /// In es, this message translates to:
  /// **'Cópialo tal cual: algunos reclutadores filtran los correos por el asunto.'**
  String get contactSubjectHelper;

  /// No description provided for @contactAsksSalaryLabel.
  ///
  /// In es, this message translates to:
  /// **'Piden la expectativa salarial'**
  String get contactAsksSalaryLabel;

  /// No description provided for @applyMethodLabel.
  ///
  /// In es, this message translates to:
  /// **'Cómo postular'**
  String get applyMethodLabel;

  /// No description provided for @applyMethodNone.
  ///
  /// In es, this message translates to:
  /// **'Sin indicar'**
  String get applyMethodNone;

  /// No description provided for @applyMethodEmail.
  ///
  /// In es, this message translates to:
  /// **'Por correo'**
  String get applyMethodEmail;

  /// No description provided for @applyMethodDirectMessage.
  ///
  /// In es, this message translates to:
  /// **'Por mensaje directo en LinkedIn'**
  String get applyMethodDirectMessage;

  /// No description provided for @applyMethodPortal.
  ///
  /// In es, this message translates to:
  /// **'En su portal o formulario'**
  String get applyMethodPortal;

  /// No description provided for @applyEmailTitle.
  ///
  /// In es, this message translates to:
  /// **'Postular por correo'**
  String get applyEmailTitle;

  /// No description provided for @applyNeedsResume.
  ///
  /// In es, this message translates to:
  /// **'Primero prepara la HV adaptada a esta oferta: es la que se adjunta al correo.'**
  String get applyNeedsResume;

  /// No description provided for @applyPrepareResume.
  ///
  /// In es, this message translates to:
  /// **'Preparar HV adaptada'**
  String get applyPrepareResume;

  /// No description provided for @applyReviewHint.
  ///
  /// In es, this message translates to:
  /// **'Revisa el correo. Al abrirlo en tu app de correo se adjunta la HV adaptada en PDF; Rumbo no envía nada.'**
  String get applyReviewHint;

  /// No description provided for @applyPlaceholders.
  ///
  /// In es, this message translates to:
  /// **'Completa lo que está entre corchetes antes de abrir el correo.'**
  String get applyPlaceholders;

  /// No description provided for @applyOpen.
  ///
  /// In es, this message translates to:
  /// **'Abrir en el correo con la HV'**
  String get applyOpen;

  /// No description provided for @applyRecipientCopied.
  ///
  /// In es, this message translates to:
  /// **'Destinatario copiado: pégalo en «Para».'**
  String get applyRecipientCopied;

  /// No description provided for @applyWebHint.
  ///
  /// In es, this message translates to:
  /// **'Se descargó la HV: adjúntala en el correo que se abrió.'**
  String get applyWebHint;

  /// No description provided for @applySentQuestion.
  ///
  /// In es, this message translates to:
  /// **'¿Ya lo enviaste?'**
  String get applySentQuestion;

  /// No description provided for @applyMarkApplied.
  ///
  /// In es, this message translates to:
  /// **'Marcar como postulada'**
  String get applyMarkApplied;

  /// No description provided for @applyMarked.
  ///
  /// In es, this message translates to:
  /// **'Marcada como postulada.'**
  String get applyMarked;

  /// No description provided for @downloadResume.
  ///
  /// In es, this message translates to:
  /// **'Descargar HV'**
  String get downloadResume;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
