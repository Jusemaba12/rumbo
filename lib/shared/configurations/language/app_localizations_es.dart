// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Rumbo';

  @override
  String get tabHome => 'Inicio';

  @override
  String get tabJobs => 'Ofertas';

  @override
  String get tabApplications => 'Procesos';

  @override
  String get applicationsTitle => 'Postulaciones';

  @override
  String get tabResume => 'HV';

  @override
  String get tabMore => 'Más';

  @override
  String get signInTitle => 'Entra a Rumbo';

  @override
  String get signInSubtitle => 'Te enviamos un código de acceso a tu correo.';

  @override
  String get emailLabel => 'Correo';

  @override
  String get emailInvalid => 'Escribe un correo válido';

  @override
  String get sendCode => 'Enviar código';

  @override
  String get codeLabel => 'Código del correo';

  @override
  String get codeInvalid => 'El código tiene entre 6 y 10 dígitos';

  @override
  String get verifyCode => 'Entrar';

  @override
  String get changeEmail => 'Usar otro correo';

  @override
  String get signInError =>
      'No pudimos completar el acceso. Revisa el dato e inténtalo de nuevo.';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get demoBanner =>
      'Modo local: sin conexión al servidor. Los datos no se guardan.';

  @override
  String get homeEmptyTitle => 'Tu resumen del día';

  @override
  String get jobsEmptyTitle => 'Aún no hay ofertas';

  @override
  String get jobsEmptyBody =>
      'Pega el enlace o la descripción de una oferta y verás si encaja con tu perfil.';

  @override
  String get applicationsEmptyTitle => 'Aún no tienes postulaciones';

  @override
  String get applicationsEmptyBody =>
      'Prepara una postulación desde una oferta o pulsa «Seguir esta oferta» en su detalle.';

  @override
  String get moreTitle => 'Más';

  @override
  String get statusSaved => 'Guardada';

  @override
  String get statusPreparing => 'Preparando';

  @override
  String get statusApplied => 'Postulada';

  @override
  String get statusInReview => 'En revisión';

  @override
  String get statusTechnicalTest => 'Prueba técnica';

  @override
  String get statusInterview => 'Entrevista';

  @override
  String get statusOffer => 'Oferta';

  @override
  String get statusAccepted => 'Aceptada';

  @override
  String get statusDeclined => 'Declinada';

  @override
  String get statusRejected => 'Rechazada';

  @override
  String get statusNoResponse => 'Sin respuesta';

  @override
  String get profileTitle => 'Tu perfil';

  @override
  String profileCompleteness(int percent) {
    return 'Perfil completo al $percent%';
  }

  @override
  String get profileCompleteHint =>
      'Tu perfil tiene lo necesario para generar una buena HV.';

  @override
  String get gapName => 'Añade tu nombre.';

  @override
  String get gapHeadline =>
      'Añade un titular, por ejemplo «Desarrollador Flutter Senior».';

  @override
  String get gapExperience => 'Añade tu primera experiencia laboral.';

  @override
  String get gapAchievements =>
      'Añade logros a cada experiencia. Con cifras, mejor.';

  @override
  String gapSkills(int count) {
    return 'Añade al menos $count habilidades.';
  }

  @override
  String get gapSummary => 'Escribe un resumen profesional de 2 o 3 frases.';

  @override
  String get gapLink => 'Añade tu LinkedIn, GitHub o portafolio.';

  @override
  String get sectionBasics => 'Datos básicos';

  @override
  String get sectionExperience => 'Experiencia';

  @override
  String get sectionProjects => 'Proyectos';

  @override
  String get sectionSkills => 'Habilidades';

  @override
  String get basicsEmpty => 'Aún no has añadido tus datos.';

  @override
  String get experienceEmpty => 'Aún no has añadido experiencia.';

  @override
  String get projectsEmpty => 'Aún no has añadido proyectos.';

  @override
  String get skillsEmpty => 'Aún no has añadido habilidades.';

  @override
  String get edit => 'Editar';

  @override
  String get add => 'Añadir';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get saveError => 'No se pudo guardar. Inténtalo de nuevo.';

  @override
  String get loadError => 'No se pudo cargar tu perfil.';

  @override
  String get retry => 'Reintentar';

  @override
  String get requiredField => 'Este campo es obligatorio';

  @override
  String get fullNameLabel => 'Nombre completo';

  @override
  String get headlineLabel => 'Titular';

  @override
  String get headlineHint => 'Desarrollador Flutter Senior';

  @override
  String get locationLabel => 'Ubicación';

  @override
  String get locationHint => 'Bogotá, Colombia';

  @override
  String get summaryLabel => 'Resumen profesional';

  @override
  String get linkedinLabel => 'LinkedIn';

  @override
  String get githubLabel => 'GitHub';

  @override
  String get portfolioLabel => 'Portafolio o sitio web';

  @override
  String get urlInvalid => 'Escribe un enlace completo, por ejemplo https://…';

  @override
  String get experienceNew => 'Nueva experiencia';

  @override
  String get experienceEdit => 'Editar experiencia';

  @override
  String get companyLabel => 'Empresa';

  @override
  String get roleLabel => 'Cargo';

  @override
  String get startDateLabel => 'Inicio';

  @override
  String get endDateLabel => 'Fin';

  @override
  String get currentJob => 'Trabajo aquí actualmente';

  @override
  String get present => 'Actualidad';

  @override
  String get endBeforeStart => 'La fecha de fin debe ser posterior al inicio';

  @override
  String get achievementsLabel => 'Logros';

  @override
  String get achievementsHelper =>
      'Uno por línea. Ejemplo: Reduje el tiempo de arranque un 40 %.';

  @override
  String get technologiesLabel => 'Tecnologías';

  @override
  String get technologiesHelper =>
      'Separadas por comas: Flutter, Riverpod, Firebase';

  @override
  String get projectNew => 'Nuevo proyecto';

  @override
  String get projectEdit => 'Editar proyecto';

  @override
  String get projectNameLabel => 'Nombre del proyecto';

  @override
  String get descriptionLabel => 'Descripción';

  @override
  String get projectUrlLabel => 'Enlace';

  @override
  String get skillNew => 'Nueva habilidad';

  @override
  String get skillEdit => 'Editar habilidad';

  @override
  String get skillNameLabel => 'Habilidad';

  @override
  String get skillCategoryLabel => 'Categoría';

  @override
  String get skillYearsLabel => 'Años de experiencia';

  @override
  String skillYears(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years años',
      one: '1 año',
    );
    return '$_temp0';
  }

  @override
  String get categoryLanguage => 'Lenguaje';

  @override
  String get categoryFramework => 'Framework';

  @override
  String get categoryTool => 'Herramienta';

  @override
  String get categoryOther => 'Otra';

  @override
  String deleteConfirmTitle(String name) {
    return '¿Eliminar «$name»?';
  }

  @override
  String get deleteConfirmBody => 'Esta acción no se puede deshacer.';

  @override
  String get importResume => 'Importar HV en PDF';

  @override
  String get importTitle => 'Importar tu HV';

  @override
  String get importIntro =>
      'Elige tu hoja de vida en PDF. La IA la leerá y te mostrará lo que encontró antes de añadir nada a tu perfil.';

  @override
  String get importRules =>
      'Solo se rellenan los campos vacíos y se añaden elementos nuevos. Lo que ya escribiste no cambia.';

  @override
  String get importPick => 'Elegir PDF';

  @override
  String get importReading => 'Leyendo tu HV…';

  @override
  String get importReadingHint => 'Puede tardar hasta un minuto.';

  @override
  String get importReviewTitle => 'Esto se añadirá a tu perfil';

  @override
  String get importNothingNew =>
      'Tu perfil ya tiene todo lo que encontramos en el PDF.';

  @override
  String get importFields => 'Datos básicos';

  @override
  String get importApply => 'Añadir a mi perfil';

  @override
  String get importPickAnother => 'Elegir otro PDF';

  @override
  String get importDone => 'Perfil actualizado con tu HV.';

  @override
  String get importErrorTooLarge =>
      'El PDF pesa más de 5 MB. Exporta una versión más ligera e inténtalo de nuevo.';

  @override
  String get importErrorUnreadable =>
      'No se pudo leer el PDF. Comprueba que no esté protegido con contraseña ni sea una imagen escaneada.';

  @override
  String get importErrorRateLimited =>
      'Hay demasiadas peticiones ahora mismo. Espera un minuto e inténtalo de nuevo.';

  @override
  String get importErrorOther =>
      'No se pudo importar la HV. Revisa tu conexión e inténtalo de nuevo.';

  @override
  String get jobsLoadError => 'No se pudieron cargar tus ofertas.';

  @override
  String get jobAdd => 'Añadir oferta';

  @override
  String get jobAddTitle => 'Nueva oferta';

  @override
  String get jobUrlLabel => 'Enlace de la oferta';

  @override
  String get jobDescriptionLabel => 'Descripción de la oferta';

  @override
  String get jobDescriptionHelper =>
      'LinkedIn e Indeed no dejan leer sus páginas: copia la descripción y pégala aquí.';

  @override
  String get jobFormEmpty => 'Pega el enlace o la descripción de la oferta.';

  @override
  String get jobAnalyze => 'Analizar oferta';

  @override
  String get jobAnalyzing => 'Analizando la oferta…';

  @override
  String get jobAnalyzingHint => 'Comparando los requisitos con tu perfil.';

  @override
  String get jobNoDescription =>
      'No pudimos leer la oferta desde el enlace. Copia la descripción y pégala arriba.';

  @override
  String get aiErrorRateLimited =>
      'Se alcanzó el límite de uso de la IA. Espera un minuto e inténtalo de nuevo.';

  @override
  String get jobErrorOther =>
      'No se pudo analizar la oferta. Revisa tu conexión e inténtalo de nuevo.';

  @override
  String get jobSave => 'Guardar oferta';

  @override
  String get jobSaved => 'Oferta guardada.';

  @override
  String get jobDuplicate => 'Ya tienes guardada esta oferta.';

  @override
  String get jobAnalyzeAnother => 'Volver y editar';

  @override
  String get jobDeleted => 'Oferta eliminada.';

  @override
  String get jobNotFound => 'Esta oferta ya no existe.';

  @override
  String get jobOpenLink => 'Abrir oferta';

  @override
  String get jobRequirements => 'Requisitos';

  @override
  String get jobDescription => 'Descripción';

  @override
  String get jobUnknownCompany => 'Empresa sin indicar';

  @override
  String get jobUntitled => 'Oferta sin título';

  @override
  String get matchTitle => 'Compatibilidad con tu perfil';

  @override
  String get matchMet => 'Cumples';

  @override
  String get matchMissing => 'Te falta';

  @override
  String matchScoreSemantics(int score) {
    return 'Compatibilidad: $score de 100';
  }

  @override
  String get matchLevelHigh => 'Alta';

  @override
  String get matchLevelMedium => 'Media';

  @override
  String get matchLevelLow => 'Baja';

  @override
  String get workModeRemote => 'Remoto';

  @override
  String get workModeHybrid => 'Híbrido';

  @override
  String get workModeOnsite => 'Presencial';

  @override
  String get phoneLabel => 'Teléfono';

  @override
  String get phoneHint => '+57 300 000 0000';

  @override
  String get sectionEducation => 'Estudios';

  @override
  String get educationEmpty => 'Aún no has añadido estudios.';

  @override
  String get educationNew => 'Nuevos estudios';

  @override
  String get educationEdit => 'Editar estudios';

  @override
  String get institutionLabel => 'Institución';

  @override
  String get degreeLabel => 'Título o programa';

  @override
  String get studyingNow => 'Estudio aquí actualmente';

  @override
  String get prepareApplication => 'Preparar postulación';

  @override
  String get prepareTitle => 'Preparar postulación';

  @override
  String get preparing => 'Adaptando tu HV…';

  @override
  String get preparingHint => 'Puede tardar hasta un minuto.';

  @override
  String get prepareEmptyProfile =>
      'Añade al menos una experiencia a tu perfil para adaptar la HV.';

  @override
  String get prepareError =>
      'No se pudo preparar la postulación. Revisa tu conexión e inténtalo de nuevo.';

  @override
  String get tabResumePreview => 'HV';

  @override
  String get tabCoverLetter => 'Carta';

  @override
  String get tabChanges => 'Cambios';

  @override
  String get letterHelper => 'Revísala y ajústala antes de enviarla.';

  @override
  String get copyLetter => 'Copiar carta';

  @override
  String get letterCopied => 'Carta copiada.';

  @override
  String get keywordsCovered => 'Palabras clave de la oferta que cubre tu HV';

  @override
  String get rejectedTitle => 'Descartado por no estar en tu perfil';

  @override
  String get rejectedBody =>
      'La IA propuso esto, pero no se pudo comprobar con tus datos y no se usó.';

  @override
  String get saveVersion => 'Guardar versión';

  @override
  String get versionSavedShort => 'Guardada';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get pdfError => 'No se pudo generar el PDF. Inténtalo de nuevo.';

  @override
  String get aiErrorBusy =>
      'La IA gratuita está saturada en este momento. Inténtalo de nuevo en unos minutos.';

  @override
  String get boardActive => 'Activos';

  @override
  String get boardClosed => 'Cerrados';

  @override
  String get followUpDue => 'Toca hacer seguimiento';

  @override
  String followUpOn(String date) {
    return 'Seguimiento: $date';
  }

  @override
  String appliedDaysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Postulado hace $days días',
      one: 'Postulado hace 1 día',
      zero: 'Postulado hoy',
    );
    return '$_temp0';
  }

  @override
  String get nextStepTitle => 'Actualizar estado';

  @override
  String get followUpTitle => 'Seguimiento';

  @override
  String get followUpDoneButton => 'Hecho, recordar en 7 días';

  @override
  String get followUpChange => 'Cambiar fecha';

  @override
  String get followUpNone => 'Sin seguimiento programado.';

  @override
  String noResponseHint(int days) {
    return 'Llevas $days días sin respuesta. Puedes marcarlo como «Sin respuesta» y seguir con otras ofertas.';
  }

  @override
  String get notesLabel => 'Notas';

  @override
  String get notesHint => 'Contactos, impresiones, preguntas de la entrevista…';

  @override
  String get notesSaved => 'Notas guardadas.';

  @override
  String get historyTitle => 'Historial';

  @override
  String historyCreated(String status) {
    return 'Creado como «$status»';
  }

  @override
  String get viewJob => 'Ver oferta';

  @override
  String get trackJob => 'Seguir esta oferta';

  @override
  String get viewProcess => 'Ver proceso';

  @override
  String get processStatus => 'Estado del proceso';

  @override
  String get actionPreparing => 'Preparar';

  @override
  String get actionSaved => 'Volver a guardada';

  @override
  String get actionApplied => 'Ya me postulé';

  @override
  String get actionInReview => 'Está en revisión';

  @override
  String get actionTechnicalTest => 'Me enviaron una prueba';

  @override
  String get actionInterview => 'Tengo entrevista';

  @override
  String get actionOffer => 'Recibí una oferta';

  @override
  String get actionAccepted => 'La acepté';

  @override
  String get actionDeclined => 'La rechacé';

  @override
  String get actionRejected => 'Me descartaron';

  @override
  String get actionNoResponse => 'Sin respuesta';

  @override
  String get homeStart => 'Empieza añadiendo una oferta en la pestaña Ofertas.';

  @override
  String get searchPrefsTitle => 'Preferencias de búsqueda';

  @override
  String get searchPrefsIntro =>
      'Rumbo buscará ofertas en Get on Board, Remotive, Himalayas, Remote OK y We Work Remotely y te sugerirá las que encajen con tu perfil.';

  @override
  String get searchRolesLabel => 'Cargos';

  @override
  String get searchRolesHelper =>
      'Separados por comas: Flutter Developer, Mobile Developer';

  @override
  String get searchTechLabel => 'Tecnologías clave';

  @override
  String get searchTechHelper => 'Separadas por comas: Flutter, Dart';

  @override
  String get searchCountriesLabel => 'Países donde puedes trabajar';

  @override
  String get searchCountriesHelper =>
      'Separados por comas. Los remotos limitados a otros países se descartan.';

  @override
  String get searchWorkModes => 'Modalidad';

  @override
  String get searchSources => 'Portales';

  @override
  String searchMinScore(int score) {
    return 'Sugerir desde $score de compatibilidad';
  }

  @override
  String get searchNeedsTerms => 'Escribe al menos un cargo o una tecnología.';

  @override
  String get searchNeedsMode => 'Elige al menos una modalidad.';

  @override
  String get searchNeedsSource => 'Elige al menos un portal.';

  @override
  String get searchSaved => 'Preferencias guardadas.';

  @override
  String jobsTabSuggested(int count) {
    return 'Sugeridas ($count)';
  }

  @override
  String jobsTabSaved(int count) {
    return 'Guardadas ($count)';
  }

  @override
  String get searchNow => 'Buscar ahora';

  @override
  String get searchRunning => 'Buscando ofertas…';

  @override
  String searchLastRun(String date) {
    return 'Última búsqueda: $date';
  }

  @override
  String get searchSetupTitle => 'Configura la búsqueda automática';

  @override
  String get searchSetupBody =>
      'Dinos qué cargos y tecnologías buscas y Rumbo te sugerirá ofertas cada día.';

  @override
  String get searchSetupButton => 'Configurar búsqueda';

  @override
  String get searchNoSuggestions =>
      'No hay sugerencias pendientes. Pulsa «Buscar ahora» o vuelve más tarde.';

  @override
  String searchResult(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ofertas nuevas sugeridas.',
      one: '1 oferta nueva sugerida.',
      zero: 'No hay ofertas nuevas que encajen con tu perfil.',
    );
    return '$_temp0';
  }

  @override
  String searchSourcesFailed(String sources) {
    return 'No respondieron: $sources.';
  }

  @override
  String get searchTooSoon =>
      'Acabas de buscar. Espera unos minutos para volver a hacerlo.';

  @override
  String get searchNoPreferences =>
      'Configura tus preferencias de búsqueda primero.';

  @override
  String get searchError =>
      'No se pudo completar la búsqueda. Inténtalo de nuevo.';

  @override
  String get suggestionKeep => 'Guardar oferta';

  @override
  String get suggestionDismiss => 'Descartar';

  @override
  String get suggestionKept => 'Oferta guardada.';

  @override
  String get suggestionDismissed => 'Sugerencia descartada.';

  @override
  String foundOn(String source) {
    return 'Encontrada en $source';
  }

  @override
  String get homeSuggestions => 'Sugerencias nuevas';

  @override
  String get watchedTitle => 'Empresas que vigilas';

  @override
  String get watchedHelper =>
      'Pega el enlace de su página de empleo en Greenhouse, Lever, Ashby, Workable, SmartRecruiters, Recruitee o Teamtailor. Por ejemplo: jobs.ashbyhq.com/truelogic o apply.workable.com/huggingface';

  @override
  String get watchedLabel => 'Enlace de la página de empleo';

  @override
  String get watchedAdd => 'Añadir empresa';

  @override
  String get watchedInvalid =>
      'No reconocemos ese enlace. Debe ser de Greenhouse, Lever, Ashby, Workable, SmartRecruiters, Recruitee o Teamtailor.';

  @override
  String get watchedDuplicate => 'Ya vigilas esa empresa.';

  @override
  String watchedLimit(int count) {
    return 'Puedes vigilar hasta $count empresas.';
  }

  @override
  String get watchedEmpty => 'Aún no vigilas ninguna empresa.';

  @override
  String watchedRemove(String name) {
    return 'Dejar de vigilar $name';
  }

  @override
  String get statsTitle => 'Estadísticas';

  @override
  String get statsOpen => 'Ver estadísticas';

  @override
  String get statsFunnel => 'Embudo';

  @override
  String get statsFunnelSaved => 'En el tablero';

  @override
  String get statsFunnelApplied => 'Postuladas';

  @override
  String get statsFunnelResponded => 'Con respuesta';

  @override
  String get statsFunnelInterviews => 'Entrevistas o pruebas';

  @override
  String get statsFunnelOffers => 'Ofertas recibidas';

  @override
  String statsResponseRate(int rate) {
    return '$rate% de tus postulaciones recibieron respuesta.';
  }

  @override
  String statsResponseTime(String days) {
    return 'Las empresas tardan $days días de media en responder.';
  }

  @override
  String get statsNoApplications =>
      'Cuando marques procesos como «Postulada» verás aquí qué porcentaje recibe respuesta y cuánto tardan las empresas.';

  @override
  String get statsBySource => 'Por origen';

  @override
  String get statsSourceManual => 'Añadidas por ti';

  @override
  String statsSourceRow(int applied, int responded) {
    return '$applied postuladas · $responded con respuesta';
  }

  @override
  String get statsGaps => 'Lo que más te piden y no tienes';

  @override
  String statsGapsHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ofertas analizadas',
      one: '1 oferta analizada',
    );
    return 'Según $_temp0. Es lo que más rendiría aprender o destacar.';
  }

  @override
  String get statsGapsEmpty =>
      'Analiza o guarda más ofertas para ver qué requisitos se repiten.';

  @override
  String statsGapRow(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'en $count ofertas',
      one: 'en 1 oferta',
    );
    return '$_temp0';
  }

  @override
  String get statsLoadError => 'No se pudieron cargar las estadísticas.';

  @override
  String get interviewsTitle => 'Entrevistas';

  @override
  String get interviewAdd => 'Programar entrevista';

  @override
  String get interviewNew => 'Nueva entrevista';

  @override
  String get interviewEdit => 'Editar entrevista';

  @override
  String get interviewKind => 'Tipo';

  @override
  String get kindScreening => 'Primera llamada';

  @override
  String get kindTechnical => 'Prueba técnica';

  @override
  String get kindHr => 'Recursos humanos';

  @override
  String get kindFinal => 'Entrevista final';

  @override
  String get kindOther => 'Otra';

  @override
  String get interviewDate => 'Fecha';

  @override
  String get interviewTime => 'Hora';

  @override
  String get interviewDuration => 'Duración (minutos)';

  @override
  String get interviewLocation => 'Enlace o lugar';

  @override
  String get interviewLocationHint => 'https://meet.google.com/… o dirección';

  @override
  String get interviewNotes => 'Notas';

  @override
  String get interviewNotesHint => 'Con quién, qué preparar, preguntas…';

  @override
  String get interviewOutcome => 'Resultado';

  @override
  String get outcomePending => 'Pendiente';

  @override
  String get outcomePassed => 'Superada';

  @override
  String get outcomeFailed => 'No superada';

  @override
  String interviewStatusChanged(String status) {
    return 'Entrevista guardada. El proceso pasó a «$status».';
  }

  @override
  String get interviewSaved => 'Entrevista guardada.';

  @override
  String get interviewsEmpty => 'Sin entrevistas programadas.';

  @override
  String get homeUpcoming => 'Próximas entrevistas';

  @override
  String get homeNoUpcoming => 'No tienes entrevistas próximas.';

  @override
  String get interviewJoin => 'Abrir enlace';

  @override
  String get interviewDurationInvalid => 'Entre 5 y 600 minutos';

  @override
  String get gmailTitle => 'Conectar Gmail';

  @override
  String get gmailIntro =>
      'Rumbo puede leer los correos de las empresas de tus procesos activos y proponerte cambios de estado o entrevistas. Tú decides si aplicarlos.';

  @override
  String get gmailHow =>
      'Un pequeño script en tu cuenta de Google revisa tu correo cada hora. Tu acceso a Gmail no sale de Google: solo se envían a Rumbo los correos que mencionan a las empresas de tus procesos y tus alertas de empleo de LinkedIn.';

  @override
  String get gmailPrivacy =>
      'Con la IA gratuita, Google puede usar esos correos para mejorar sus productos.';

  @override
  String get gmailStep1 =>
      'Pulsa «Copiar script». Incluye una clave personal: no la compartas.';

  @override
  String get gmailStep2 =>
      'Abre script.google.com, crea un proyecto nuevo, borra lo que trae y pega el script.';

  @override
  String get gmailStep3 =>
      'Arriba, elige la función «instalar» y pulsa Ejecutar.';

  @override
  String get gmailStep4 =>
      'Autoriza el acceso con tu cuenta de Google. Si ves «Google no ha verificado esta aplicación», entra en Configuración avanzada → Ir a (no seguro): el script es tuyo.';

  @override
  String get gmailCopy => 'Copiar script';

  @override
  String get gmailCopied => 'Script copiado. Pégalo en script.google.com.';

  @override
  String get gmailRegenerate => 'Generar clave nueva y copiar';

  @override
  String get gmailRegenerateHint =>
      'La clave anterior dejará de funcionar: tendrás que pegar el script nuevo.';

  @override
  String get gmailDisconnect => 'Desconectar Gmail';

  @override
  String get gmailDisconnected => 'Gmail desconectado.';

  @override
  String get gmailNotConnected => 'Aún no has conectado Gmail.';

  @override
  String gmailWaiting(String date) {
    return 'Clave creada el $date. Esperando a que el script se ejecute por primera vez.';
  }

  @override
  String gmailConnected(String date) {
    return 'Conectado. El script habló con Rumbo por última vez el $date.';
  }

  @override
  String get gmailOpenScript => 'Abrir script.google.com';

  @override
  String get emailUpdatesTitle => 'Novedades del correo';

  @override
  String get emailApply => 'Aplicar';

  @override
  String get emailDismiss => 'Ignorar';

  @override
  String get emailApplied => 'Propuesta aplicada.';

  @override
  String get emailDismissed => 'Propuesta ignorada.';

  @override
  String emailInterviewAt(String date) {
    return 'Fecha: $date';
  }

  @override
  String get practiceTitle => 'Practicar entrevista';

  @override
  String get practiceOpen => 'Practicar entrevista';

  @override
  String get practiceIntro =>
      'Un entrevistador con IA te hará preguntas sobre esta oferta y evaluará cada respuesta. Responde como en una entrevista real; puedes dictar con el micrófono del teclado.';

  @override
  String get practiceMode => 'Tipo de preguntas';

  @override
  String get modeTechnical => 'Técnicas';

  @override
  String get modeBehavioral => 'Comportamiento';

  @override
  String get modeMixed => 'Mixtas';

  @override
  String get practiceLanguage => 'Idioma';

  @override
  String get languageEs => 'Español';

  @override
  String get languageEn => 'Inglés';

  @override
  String practiceCount(int count) {
    return '$count preguntas';
  }

  @override
  String get practiceStart => 'Empezar';

  @override
  String get practiceThinking => 'El entrevistador está pensando…';

  @override
  String get practiceAnswerHint => 'Tu respuesta…';

  @override
  String get practiceSend => 'Responder';

  @override
  String practiceQuestion(int number, int total) {
    return 'Pregunta $number de $total';
  }

  @override
  String practiceScore(int score) {
    return '$score de 5';
  }

  @override
  String get practiceStrengths => 'Bien';

  @override
  String get practiceImprove => 'Mejora';

  @override
  String get practiceBetter => 'Respuesta mejorada';

  @override
  String get practiceCopy => 'Copiar';

  @override
  String get practiceCopied => 'Respuesta copiada.';

  @override
  String get practiceSummary => 'Resultado de la práctica';

  @override
  String get practiceAgain => 'Practicar otra vez';

  @override
  String get practiceError =>
      'No se pudo continuar la práctica. Inténtalo de nuevo.';

  @override
  String get practiceRetry => 'Reintentar';

  @override
  String get answersTitle => 'Banco de respuestas';

  @override
  String get answersIntro =>
      'Prepara tus respuestas a las preguntas que salen en casi todas las entrevistas y cópialas cuando las necesites.';

  @override
  String get answersEmpty => 'Empieza por una de estas preguntas habituales:';

  @override
  String get answersAdd => 'Nueva respuesta';

  @override
  String get answerNew => 'Nueva respuesta';

  @override
  String get answerEdit => 'Editar respuesta';

  @override
  String get answerQuestion => 'Pregunta';

  @override
  String get answerText => 'Tu respuesta';

  @override
  String get answerCopy => 'Copiar';

  @override
  String get answerCopied => 'Respuesta copiada.';

  @override
  String get answerSaveToBank => 'Guardar en el banco';

  @override
  String get answerSavedToBank => 'Guardada en tu banco de respuestas.';

  @override
  String get commonAboutYou => 'Háblame de ti';

  @override
  String get commonWhyCompany => '¿Por qué quieres trabajar con nosotros?';

  @override
  String get commonSalary => '¿Cuál es tu expectativa salarial?';

  @override
  String get commonWhyLeave => '¿Por qué quieres cambiar de trabajo?';

  @override
  String get commonChallenge => 'Cuéntame un reto técnico que hayas resuelto';

  @override
  String get commonWeakness => '¿Cuál es tu mayor área de mejora?';

  @override
  String get commonConflict =>
      'Cuéntame un desacuerdo con un compañero y cómo lo resolviste';

  @override
  String get offerTitle => 'Detalles de la oferta';

  @override
  String get offerEdit => 'Editar condiciones';

  @override
  String get offerSalary => 'Salario';

  @override
  String get offerCurrency => 'Moneda';

  @override
  String get periodMonth => 'Mensual';

  @override
  String get periodYear => 'Anual';

  @override
  String get offerWorkMode => 'Modalidad';

  @override
  String get offerStart => 'Fecha de inicio';

  @override
  String get offerDeadline => 'Responder antes del';

  @override
  String get offerBenefits => 'Beneficios';

  @override
  String get offerBenefitsHint => 'Seguro médico, vacaciones, equipo, bonos…';

  @override
  String get offerNotes => 'Notas';

  @override
  String get offerSaved => 'Condiciones guardadas.';

  @override
  String get offerNoDetails => 'Aún no has añadido las condiciones.';

  @override
  String get offerCompare => 'Comparar ofertas';

  @override
  String get compareTitle => 'Comparar ofertas';

  @override
  String get compareEmpty =>
      'Cuando marques un proceso como «Oferta» podrás comparar sus condiciones aquí.';

  @override
  String compareMonthly(String amount) {
    return '$amount al mes';
  }

  @override
  String compareHighest(String currency) {
    return 'Mejor salario en $currency';
  }

  @override
  String get compareMixedCurrencies =>
      'Las ofertas están en monedas distintas: compáralas en la misma moneda antes de decidir.';

  @override
  String compareFit(int score) {
    return 'Compatibilidad $score';
  }

  @override
  String compareDeadline(String date) {
    return 'Responder antes del $date';
  }

  @override
  String get notSet => 'Sin indicar';

  @override
  String get negotiateTitle => 'Preparar negociación';

  @override
  String get negotiateOpen => 'Preparar negociación';

  @override
  String get negotiateIntro =>
      'La IA prepara una respuesta a la empresa con tu contraoferta y los argumentos para defenderla, usando tus logros reales. Revísala antes de enviarla.';

  @override
  String get negotiateTarget => 'Salario que quieres proponer';

  @override
  String get negotiateTargetHelper =>
      'En la misma moneda y periodo que la oferta. Déjalo vacío para pedir revisar condiciones.';

  @override
  String get negotiatePriorities => 'Qué más te importa';

  @override
  String get negotiatePrioritiesHint =>
      'Fecha de inicio, días de vacaciones, equipo, horario…';

  @override
  String get negotiateEnglish => 'Escribir la respuesta en inglés';

  @override
  String get negotiateGenerate => 'Preparar respuesta';

  @override
  String get negotiateGenerating => 'Preparando la respuesta…';

  @override
  String get negotiateEmail => 'Respuesta para la empresa';

  @override
  String get negotiatePoints => 'Argumentos para la llamada';

  @override
  String get negotiateRisks => 'Antes de aceptar, confirma';

  @override
  String get negotiateError =>
      'No se pudo preparar la respuesta. Inténtalo de nuevo.';

  @override
  String get briefTitle => 'Ficha de la empresa';

  @override
  String get briefOpen => 'Ficha de la empresa';

  @override
  String get briefIntro =>
      'Un resumen de la empresa y del puesto a partir de la oferta, con preguntas para la entrevista.';

  @override
  String get briefGenerate => 'Preparar ficha';

  @override
  String get briefRegenerate => 'Volver a preparar';

  @override
  String get briefGenerating => 'Preparando la ficha…';

  @override
  String get briefError => 'No se pudo preparar la ficha. Inténtalo de nuevo.';

  @override
  String get briefTeam => 'Equipo y tecnología';

  @override
  String get briefCulture => 'Cultura y beneficios';

  @override
  String get briefQuestions => 'Preguntas para hacerles';

  @override
  String get briefRedFlags => 'Conviene aclarar';

  @override
  String get briefGeneral => 'Información general (no viene de la oferta)';

  @override
  String briefGeneratedAt(String date) {
    return 'Preparada el $date';
  }

  @override
  String homeGreeting(String name) {
    return 'Hola, $name';
  }

  @override
  String get homeGreetingNoName => 'Hola';

  @override
  String get homeToday => 'Para hoy';

  @override
  String homeTaskCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tareas',
      one: '1 tarea',
    );
    return '$_temp0';
  }

  @override
  String get homeAllDoneTitle => 'Todo al día';

  @override
  String get homeAllDoneBody =>
      'No tienes tareas pendientes. La próxima búsqueda automática es mañana a las 7:00.';

  @override
  String homeTaskFollowUp(String company) {
    return 'Seguimiento a $company';
  }

  @override
  String get homeTaskInterview => 'Prepara tu entrevista';

  @override
  String get homeMetricActive => 'Activos';

  @override
  String get homeMetricInterviews => 'Entrevistas';

  @override
  String get homeMetricSuggested => 'Sugeridas';

  @override
  String get applicationsNeedsAction => 'Necesita acción';

  @override
  String get profileCompleteLabel => 'Perfil completo';

  @override
  String get resumeMissingContact =>
      'A tu HV le falta el correo o el teléfono. Añádelos en tus datos básicos para que la empresa pueda contactarte.';

  @override
  String filterGoodMatch(int score) {
    return 'Nota ≥ $score';
  }

  @override
  String filterRecent(int days) {
    return 'Últimos $days días';
  }

  @override
  String get filterSource => 'Portal';

  @override
  String get filterAllSources => 'Todos los portales';

  @override
  String get filterClear => 'Quitar filtros';

  @override
  String get filterNoResults => 'Ninguna oferta coincide con estos filtros.';

  @override
  String dismissedTitle(int count) {
    return 'Descartadas · $count';
  }

  @override
  String get dismissedHint => 'Las que descartaste en los últimos 30 días.';

  @override
  String get dismissedRestore => 'Recuperar';

  @override
  String get suggestionRestored =>
      'Oferta recuperada: vuelve a estar en Sugeridas.';

  @override
  String get pasteFromClipboard => 'Pegar';

  @override
  String get clipboardEmpty => 'No hay texto copiado.';

  @override
  String get reviewTitle => 'Revisión ATS';

  @override
  String get reviewCardBody =>
      'Revisa tu HV base como la leería un ATS y mira qué mejorar.';

  @override
  String get reviewScoreCaption => 'Nota de tu HV base';

  @override
  String get reviewAllGood =>
      'Tu HV cumple todas las comprobaciones. Revisa ahora las palabras clave de tus cargos.';

  @override
  String get reviewFix => 'Corregir';

  @override
  String get severityHigh => 'Importante';

  @override
  String get severityMedium => 'Recomendado';

  @override
  String get severityLow => 'Detalle';

  @override
  String get issueNoName => 'Falta tu nombre.';

  @override
  String get issueNoEmail =>
      'Falta tu correo: la empresa no podrá contactarte.';

  @override
  String get issueNoPhone => 'Falta tu teléfono.';

  @override
  String get issueNoHeadline =>
      'Falta un titular, por ejemplo «Flutter Developer»: es lo primero que lee el ATS.';

  @override
  String get issueNoSummary =>
      'Falta el perfil profesional: 3 o 4 frases sobre qué haces y qué has logrado.';

  @override
  String issueShortSummary(int count) {
    return 'Tu perfil profesional es corto ($count caracteres). Apunta a 300-600.';
  }

  @override
  String issueLongSummary(int count) {
    return 'Tu perfil profesional es largo ($count caracteres). Déjalo por debajo de 700.';
  }

  @override
  String get issueNoLink => 'Añade tu LinkedIn, GitHub o portafolio.';

  @override
  String get issueNoExperience => 'Añade tu experiencia laboral.';

  @override
  String issueNoAchievements(String role, String company) {
    return '$role en $company: no tiene logros.';
  }

  @override
  String issueFewNumbers(String role, String company, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count logros sin cifras',
      one: '1 logro sin cifras',
    );
    return '$role en $company: $_temp0. Añade porcentajes, tiempos, usuarios o volumen.';
  }

  @override
  String issueWeakStart(String role, String company, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count logros empiezan',
      one: '1 logro empieza',
    );
    return '$role en $company: $_temp0 como tarea («Responsable de…»). Empieza con un verbo de acción: «Reduje», «Lancé», «Automaticé».';
  }

  @override
  String issueLongBullets(String role, String company, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count logros son demasiado largos',
      one: '1 logro es demasiado largo',
    );
    return '$role en $company: $_temp0. Una o dos líneas por logro.';
  }

  @override
  String issueFewSkills(int count) {
    return 'Tienes $count habilidades. Añade al menos 5.';
  }

  @override
  String get issueNoEducation => 'Añade tus estudios.';

  @override
  String get keywordsTitle => 'Palabras clave de tus cargos';

  @override
  String get keywordsHint =>
      'La IA lista lo que los ATS buscan para tus cargos y Rumbo comprueba cuáles aparecen en tu HV.';

  @override
  String get keywordsLoad => 'Buscar palabras clave';

  @override
  String get keywordsReload => 'Volver a buscar';

  @override
  String keywordsMissing(int count) {
    return 'No aparecen · $count';
  }

  @override
  String get keywordsMissingHint =>
      'Si de verdad las dominas, añádelas a tus logros o habilidades. Toca una para añadirla como habilidad.';

  @override
  String get keywordsNoRoles =>
      'Escribe tus cargos en Preferencias de búsqueda para buscar sus palabras clave.';

  @override
  String get keywordsError =>
      'No se pudieron obtener las palabras clave. Inténtalo de nuevo.';

  @override
  String get remindersTitle => 'Recordatorios';

  @override
  String get remindersHint =>
      'Avisos en este teléfono, aunque Rumbo esté cerrado. No necesitan internet.';

  @override
  String get remindersProcesses => 'Seguimientos y entrevistas';

  @override
  String get remindersProcessesHint =>
      'El día del seguimiento a las 9:00, la víspera de cada entrevista a las 19:00 y una hora antes.';

  @override
  String get remindersDaily => 'Recordatorio diario';

  @override
  String get remindersDailyHint =>
      'Cada día a las 8:00, para revisar sugerencias y tareas.';

  @override
  String get remindersDenied =>
      'Las notificaciones de Rumbo están desactivadas. Actívalas en los ajustes del teléfono.';

  @override
  String remindersPlanned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count avisos programados.',
      one: '1 aviso programado.',
      zero: 'No hay avisos programados.',
    );
    return '$_temp0';
  }

  @override
  String get remindersTest => 'Enviar aviso de prueba';

  @override
  String get reminderTestTitle => 'Así se verán tus recordatorios';

  @override
  String get reminderTestBody =>
      'Rumbo te avisará de seguimientos y entrevistas.';

  @override
  String get reminderFollowUpTitle => 'Toca hacer seguimiento';

  @override
  String reminderFollowUpBody(String role, String company) {
    return '$role en $company: escribe a la empresa para saber cómo va tu proceso.';
  }

  @override
  String get reminderEveTitle => 'Mañana tienes entrevista';

  @override
  String reminderEveBody(String company, String time) {
    return '$company a las $time. Repasa la ficha de la empresa y practica unos minutos.';
  }

  @override
  String get reminderSoonTitle => 'Entrevista en una hora';

  @override
  String reminderSoonBody(String company, String time) {
    return '$company a las $time. ¡Mucha suerte!';
  }

  @override
  String get reminderDailyTitle => 'Revisa tu búsqueda';

  @override
  String get reminderDailyBody =>
      'Mira tus sugerencias nuevas y las tareas de hoy en Rumbo.';

  @override
  String get aiErrorDailyLimit =>
      'Llegaste al límite diario de uso de la IA en Rumbo. Vuelve a intentarlo mañana.';

  @override
  String get welcomeTitle => 'Antes de empezar';

  @override
  String get welcomeIntro =>
      'Rumbo te ayuda a encontrar ofertas, adaptar tu HV con IA y seguir cada proceso hasta la oferta.';

  @override
  String get welcomeDataTitle => 'Cómo se usan tus datos';

  @override
  String get welcomePrivate =>
      'Tu perfil, tus ofertas y tus procesos se guardan en una base de datos privada: solo tú puedes verlos.';

  @override
  String get welcomeAi =>
      'Para analizar ofertas y adaptar tu HV, Rumbo envía el texto necesario a Google Gemini en su nivel gratuito. Google puede usar ese contenido para mejorar sus productos, así que no incluyas datos sensibles como tu número de documento.';

  @override
  String welcomeLimit(int limit) {
    return 'Cada persona puede usar la IA hasta $limit veces al día.';
  }

  @override
  String get welcomeDelete =>
      'Puedes eliminar tu cuenta y todos tus datos cuando quieras desde Más.';

  @override
  String get welcomeAccept => 'Acepto y empiezo';

  @override
  String get welcomeLeave => 'Salir';

  @override
  String get firstStepsTitle => 'Primeros pasos';

  @override
  String get firstStepsProfile =>
      'Completa tu HV: importa tu PDF o escribe tus datos';

  @override
  String get firstStepsSearch => 'Dile a Rumbo qué cargos buscas';

  @override
  String get firstStepsGmail =>
      'Opcional: conecta Gmail para detectar respuestas';

  @override
  String updateAvailable(String version) {
    return 'Hay una versión nueva de Rumbo ($version).';
  }

  @override
  String get updateDownload => 'Descargar';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountTitle => '¿Eliminar tu cuenta?';

  @override
  String get deleteAccountBody =>
      'Se borrarán tu perfil, tus ofertas, tus procesos, tus entrevistas y todo lo demás. No se puede deshacer.';

  @override
  String get deleteAccountConfirm => 'Eliminar todo';

  @override
  String get deleteAccountError =>
      'No se pudo eliminar la cuenta. Inténtalo de nuevo.';

  @override
  String get reviewRefresh => 'Volver a revisar';

  @override
  String reviewScoreUp(int from, int to) {
    return 'Revisión actualizada: tu nota subió de $from a $to.';
  }

  @override
  String reviewScoreDown(int from, int to) {
    return 'Revisión actualizada: tu nota bajó de $from a $to.';
  }

  @override
  String reviewScoreSame(int score) {
    return 'Revisión actualizada: tu nota sigue en $score.';
  }

  @override
  String get categoryContact => 'Contacto';

  @override
  String get categoryStructure => 'Estructura';

  @override
  String get categoryAchievements => 'Logros';

  @override
  String get categoryCoherence => 'Coherencia y palabras clave';

  @override
  String get categoryFormat => 'Formato';

  @override
  String get reviewCategoriesTitle => 'Nota por partes';

  @override
  String reviewCategoryIssues(String category, int count) {
    return '$category · $count';
  }

  @override
  String reviewHistoryStart(int score) {
    return 'Empezaste en $score';
  }

  @override
  String get issueInvalidEmail =>
      'Tu correo no parece válido. Revisa que esté bien escrito.';

  @override
  String get issuePhoneNoCountryCode =>
      'Añade el indicativo a tu teléfono (+57): muchas empresas remotas son de otros países.';

  @override
  String get issueNoLocation =>
      'Añade tu ciudad y país: los ATS filtran por ubicación.';

  @override
  String issueInvalidLink(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count enlaces no son válidos',
      one: 'Un enlace no es válido',
    );
    return '$_temp0: deben empezar por https://.';
  }

  @override
  String issueEndBeforeStart(String role, String company) {
    return '$role en $company: la fecha de fin es anterior a la de inicio.';
  }

  @override
  String issueFutureDate(String role, String company) {
    return '$role en $company: tiene una fecha en el futuro.';
  }

  @override
  String issueDateGap(int count, String role, String company) {
    return 'Hay un hueco de $count meses antes de $role en $company. Si estudiaste o trabajaste por tu cuenta, añádelo.';
  }

  @override
  String issueSeveralCurrent(int count) {
    return 'Tienes $count empleos marcados como actuales. Pon fecha de fin a los que terminaron.';
  }

  @override
  String issueFirstPerson(String role, String company, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count logros están escritos',
      one: '1 logro está escrito',
    );
    return '$role en $company: $_temp0 en primera persona («yo», «mi»). Escríbelos sin sujeto: «Reduje…», «Lancé…».';
  }

  @override
  String issueDuplicates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hay $count logros repetidos',
      one: 'Hay 1 logro repetido',
    );
    return '$_temp0 entre empleos.';
  }

  @override
  String issueBuzzwords(String words) {
    return 'Evita frases vacías como «$words»: demuéstralo con un logro concreto.';
  }

  @override
  String issueTechNotInSkills(String words, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'están',
      one: 'está',
    );
    return 'Usas $words en tu experiencia pero no $_temp0 en Habilidades. Añádelas: los ATS buscan en esa sección.';
  }

  @override
  String issueHeadlineNoRole(String role) {
    return 'Tu titular no menciona el cargo que buscas («$role»). Los ATS comparan el titular con el puesto.';
  }

  @override
  String get issueSummaryNoTech =>
      'Tu perfil profesional no menciona tus tecnologías principales.';

  @override
  String get issueSummaryNoYears =>
      'Indica en tu perfil profesional cuántos años de experiencia tienes, por ejemplo «3 años con Flutter».';

  @override
  String issueSpecialCharacters(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count textos tienen',
      one: '1 texto tiene',
    );
    return '$_temp0 emojis o símbolos (★, ✔, •) que los ATS leen mal.';
  }

  @override
  String issueAllCaps(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count textos están',
      one: '1 texto está',
    );
    return '$_temp0 en MAYÚSCULAS. Escríbelos en minúsculas normales.';
  }

  @override
  String get issueMixedLanguages =>
      'Mezclas español e inglés en tu HV. Usa un solo idioma: Rumbo la traduce al adaptarla a cada oferta.';

  @override
  String issueTooLong(int count) {
    return 'Tu HV tiene $count palabras: pasa de dos páginas. Recorta logros antiguos o poco relevantes.';
  }

  @override
  String issueTooShort(int count) {
    return 'Tu HV tiene solo $count palabras. Añade logros para que el ATS tenga con qué compararte.';
  }

  @override
  String keywordsInExperience(int count) {
    return 'En tu experiencia · $count';
  }

  @override
  String keywordsOnlySkills(int count) {
    return 'Solo en Habilidades · $count';
  }

  @override
  String get keywordsOnlySkillsHint =>
      'Menciónalas en un logro: los ATS valoran más una tecnología usada en tu experiencia que en una lista.';

  @override
  String keywordsMarketHint(int count) {
    return 'El número indica en cuántas de tus $count ofertas aparece.';
  }

  @override
  String keywordsUpdated(String date) {
    return 'Actualizadas el $date.';
  }

  @override
  String get atsTest => 'Probar cómo lo lee un ATS';

  @override
  String get atsTestTitle => 'Así lee tu PDF un ATS';

  @override
  String atsTestSummary(int passed, int total) {
    return '$passed de $total comprobaciones superadas';
  }

  @override
  String get atsName => 'Nombre';

  @override
  String get atsEmail => 'Correo';

  @override
  String get atsPhone => 'Teléfono';

  @override
  String get atsLink => 'Enlace (LinkedIn o portafolio)';

  @override
  String get atsLocation => 'Ciudad y país';

  @override
  String get atsSections =>
      'Secciones: perfil, experiencia, estudios y habilidades';

  @override
  String get atsExperiences => 'Cargos y empresas';

  @override
  String get atsDates => 'Fechas de cada empleo';

  @override
  String get atsSkills => 'Habilidades';

  @override
  String get atsCharacters => 'Sin caracteres rotos';

  @override
  String atsCompleteness(String percent) {
    return 'Texto completo ($percent % leído)';
  }

  @override
  String atsPages(String pages) {
    return 'Extensión: $pages páginas (máximo 2)';
  }

  @override
  String atsMissing(String detail) {
    return 'No se encontró: $detail';
  }

  @override
  String get atsExtractedText => 'Texto que lee el ATS';

  @override
  String get atsError => 'No se pudo leer el PDF. Inténtalo de nuevo.';

  @override
  String get coverageTitle => 'Palabras clave de esta oferta';

  @override
  String coverageHint(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count palabras clave detectadas',
      one: '1 palabra clave detectada',
    );
    return '$_temp0 en la oferta.';
  }

  @override
  String get coverageBase => 'Tu HV base';

  @override
  String get coverageTailored => 'HV adaptada';

  @override
  String coverageMissing(String words) {
    return 'Siguen faltando: $words. Añádelas solo si de verdad las dominas.';
  }

  @override
  String get improveWithAi => 'Mejorar con IA';

  @override
  String get improveTitle => 'Mejorar logros';

  @override
  String get improveHint =>
      'La IA propone y tú decides. Completa los huecos [entre corchetes] con tus datos reales: nunca inventa cifras.';

  @override
  String get improveBefore => 'Antes';

  @override
  String get improveNew => 'Logro nuevo';

  @override
  String get improveUse => 'Usar';

  @override
  String get improveFill =>
      'Completa los huecos entre corchetes de los logros que vas a usar.';

  @override
  String get improveSave => 'Guardar logros';

  @override
  String get improveSaved => 'Logros actualizados.';

  @override
  String get improveEmpty =>
      'Tus logros ya están bien escritos: la IA no propone cambios.';

  @override
  String get improveLoading => 'Revisando tus logros…';

  @override
  String get emailDraftsTitle => 'Escribir a la empresa';

  @override
  String get emailDraftsHint =>
      'La IA redacta el correo y tú lo revisas y lo envías desde tu correo.';

  @override
  String get emailKindFollowUp => 'Seguimiento';

  @override
  String get emailKindThankYou => 'Agradecer la entrevista';

  @override
  String get emailKindRejection => 'Responder al rechazo';

  @override
  String get emailDraftWriting => 'Redactando el correo…';

  @override
  String get emailTo => 'Para';

  @override
  String get emailSubject => 'Asunto';

  @override
  String get emailBody => 'Mensaje';

  @override
  String get emailCopy => 'Copiar';

  @override
  String get emailCopied => 'Correo copiado. Pégalo en tu correo.';

  @override
  String get emailOpen => 'Abrir en el correo';

  @override
  String get emailOpenError =>
      'No se pudo abrir la app de correo. Usa «Copiar».';

  @override
  String get emailRegenerate => 'Otra versión';

  @override
  String get emailReviewHint =>
      'Revisa el texto antes de enviarlo: Rumbo nunca envía correos por ti.';

  @override
  String get learningTitle => 'Plan de aprendizaje';

  @override
  String get learningCardEmpty =>
      'Descubre qué aprender según lo que piden tus ofertas.';

  @override
  String learningCardSummary(int topics, int learning, int mastered) {
    String _temp0 = intl.Intl.pluralLogic(
      topics,
      locale: localeName,
      other: '$topics temas',
      one: '1 tema',
    );
    return '$_temp0 · $learning aprendiendo · $mastered dominados';
  }

  @override
  String get learningMine => 'Tu plan';

  @override
  String get learningSuggestions => 'Qué te conviene aprender';

  @override
  String get learningSuggestionsHint =>
      'Lo que piden tus ofertas y no aparece en tu HV. El número es en cuántas de tus ofertas sale.';

  @override
  String get learningNoSuggestions =>
      'Sin sugerencias por ahora. Busca las palabras clave de tus cargos en la Revisión ATS o analiza más ofertas.';

  @override
  String get learningOpenReview => 'Ir a la Revisión ATS';

  @override
  String get learningAdd => 'Añadir al plan';

  @override
  String learningAdded(String topic) {
    return '«$topic» añadido a tu plan.';
  }

  @override
  String learningDemand(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sale en $count ofertas',
      one: 'Sale en 1 oferta',
      zero: 'No sale en tus ofertas',
    );
    return '$_temp0';
  }

  @override
  String get learningStatusPending => 'Pendiente';

  @override
  String get learningStatusLearning => 'Aprendiendo';

  @override
  String get learningStatusMastered => 'Dominado';

  @override
  String get learningGenerate => 'Crear plan con IA';

  @override
  String get learningGenerating => 'Preparando tu plan…';

  @override
  String get learningRegenerate => 'Otro plan';

  @override
  String get learningWhy => 'Por qué te lo piden';

  @override
  String get learningSteps => 'Pasos';

  @override
  String get learningResources => 'Recursos gratuitos';

  @override
  String get learningNoResources =>
      'No se pudieron comprobar los enlaces. Busca la documentación oficial del tema.';

  @override
  String get learningProject => 'Mini proyecto para demostrarlo';

  @override
  String learningHours(int hours) {
    return 'Unas $hours horas';
  }

  @override
  String get learningMasteredTitle => '¡Lo dominas!';

  @override
  String get learningMasteredBody =>
      'Añádelo a tus habilidades y menciónalo en un logro de tu experiencia: así sube tu nota ATS y tu compatibilidad.';

  @override
  String get learningAddSkill => 'Añadir a habilidades';

  @override
  String get learningAlreadySkill => 'Ya está en tus habilidades.';

  @override
  String get learningDelete => 'Quitar del plan';

  @override
  String get learningPlanHint =>
      'La IA propone pasos, recursos y un proyecto. Los enlaces se comprueban antes de mostrártelos.';

  @override
  String get watchedSuggestions => 'Sugerencias con Flutter';

  @override
  String get watchedSuggestionsHint =>
      'Empresas que trabajan con Flutter y contratan en remoto desde Colombia.';

  @override
  String watchedSuggestionNote(String company) {
    String _temp0 = intl.Intl.selectLogic(company, {
      'canonical': 'Ubuntu usa Flutter · remoto mundial',
      'flutterflow': 'Constructor de apps Flutter · remoto global',
      'truelogic': 'Desarrolladores para EE. UU. · remoto LATAM y Bogotá',
      'supabase': 'SDK de Flutter · remoto global y América',
      'revenuecat': 'SDK de Flutter · remoto América',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String get gmailLinkedinTitle => 'Alertas de empleo de LinkedIn';

  @override
  String get gmailLinkedinBody =>
      'Crea alertas de empleo en LinkedIn (por ejemplo «Flutter Developer» en remoto). Cuando lleguen a tu Gmail, Rumbo convertirá cada oferta en una sugerencia de Ofertas con su compatibilidad. La nota sale del título, porque el correo no trae la descripción completa.';

  @override
  String get gmailLinkedinUpdate =>
      'Tu script es anterior a las alertas de LinkedIn. Pulsa «Generar clave nueva y copiar», pega el script otra vez en tu proyecto y ejecuta «instalar».';

  @override
  String get jobCompleteTitle => 'Completar oferta';

  @override
  String get jobCompleteHint =>
      'Pega la descripción completa de la oferta: ábrela en LinkedIn o en su portal y copia el texto. Rumbo la analizará y recalculará tu compatibilidad. Se conservan el cargo, la empresa, el enlace y su proceso.';

  @override
  String get jobCompleteLabel => 'Descripción completa';

  @override
  String get jobCompleteAction => 'Analizar y completar';

  @override
  String jobCompleted(int score) {
    return 'Oferta completada. Compatibilidad: $score.';
  }

  @override
  String jobCompleteTooShort(int count) {
    return 'Pega al menos $count caracteres de la descripción.';
  }

  @override
  String get jobNeedsDescription =>
      'Esta oferta llegó sin la descripción completa: la compatibilidad sale solo del título.';

  @override
  String get jobUpdateDescription => 'Completar o cambiar la descripción';

  @override
  String get englishLevelLabel => 'Nivel de inglés';

  @override
  String get englishLevelHelper =>
      'La IA lo usa cuando una oferta pide inglés.';

  @override
  String get englishLevelNone => 'Sin indicar';

  @override
  String get englishLevelA1 => 'Principiante (A1)';

  @override
  String get englishLevelA2 => 'Básico (A2)';

  @override
  String get englishLevelB1 => 'Intermedio (B1)';

  @override
  String get englishLevelB2 => 'Intermedio alto (B2)';

  @override
  String get englishLevelC1 => 'Avanzado (C1)';

  @override
  String get englishLevelC2 => 'Muy avanzado (C2)';

  @override
  String get englishLevelNative => 'Nativo o bilingüe';

  @override
  String get salaryTitle => 'Expectativa salarial (bruto mensual)';

  @override
  String get salaryHelper =>
      'La IA la compara con el salario de las ofertas. Puedes llenar solo una moneda.';

  @override
  String salaryMinLabel(String currency) {
    return 'Mínimo $currency';
  }

  @override
  String salaryMaxLabel(String currency) {
    return 'Máximo $currency';
  }

  @override
  String get salaryRangeInvalid =>
      'El máximo no puede ser menor que el mínimo.';

  @override
  String profileEnglish(String level) {
    return 'Inglés: $level';
  }

  @override
  String profileSalary(String range) {
    return 'Expectativa: $range al mes';
  }

  @override
  String get contactTitle => 'Contacto y postulación';

  @override
  String get contactAdd => 'Añadir contacto del reclutador';

  @override
  String get contactEmailCopied => 'Correo copiado.';

  @override
  String get contactLinkedin => 'Perfil o publicación en LinkedIn';

  @override
  String contactSubject(String subject) {
    return 'Asunto: «$subject»';
  }

  @override
  String get contactAsksSalary => 'Piden tu expectativa salarial';

  @override
  String get contactNameLabel => 'Reclutador';

  @override
  String get contactEmailLabel => 'Correo para postular';

  @override
  String get contactLinkedinLabel =>
      'LinkedIn del reclutador o de la publicación';

  @override
  String get contactLinkedinHelper => 'Enlace de linkedin.com.';

  @override
  String get contactSubjectLabel => 'Asunto que piden';

  @override
  String get contactSubjectHelper =>
      'Cópialo tal cual: algunos reclutadores filtran los correos por el asunto.';

  @override
  String get contactAsksSalaryLabel => 'Piden la expectativa salarial';

  @override
  String get applyMethodLabel => 'Cómo postular';

  @override
  String get applyMethodNone => 'Sin indicar';

  @override
  String get applyMethodEmail => 'Por correo';

  @override
  String get applyMethodDirectMessage => 'Por mensaje directo en LinkedIn';

  @override
  String get applyMethodPortal => 'En su portal o formulario';

  @override
  String get applyEmailTitle => 'Postular por correo';

  @override
  String get applyNeedsResume =>
      'Primero prepara la HV adaptada a esta oferta: es la que se adjunta al correo.';

  @override
  String get applyPrepareResume => 'Preparar HV adaptada';

  @override
  String get applyReviewHint =>
      'Revisa el correo. Al abrirlo en tu app de correo se adjunta la HV adaptada en PDF; Rumbo no envía nada.';

  @override
  String get applyPlaceholders =>
      'Completa lo que está entre corchetes antes de abrir el correo.';

  @override
  String get applyOpen => 'Abrir en el correo con la HV';

  @override
  String get applyRecipientCopied => 'Destinatario copiado: pégalo en «Para».';

  @override
  String get applyWebHint =>
      'Se descargó la HV: adjúntala en el correo que se abrió.';

  @override
  String get applySentQuestion => '¿Ya lo enviaste?';

  @override
  String get applyMarkApplied => 'Marcar como postulada';

  @override
  String get applyMarked => 'Marcada como postulada.';

  @override
  String get downloadResume => 'Descargar HV';
}
