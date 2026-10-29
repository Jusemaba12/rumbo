/// Claves creadas antes de esto llevan un script sin las alertas de LinkedIn
/// (script v1): la app pide pegar el nuevo.
final linkedinScriptSince = DateTime.utc(2026, 10, 19, 19);

/// Script de Google Apps Script que el usuario pega en script.google.com.
///
/// Cada hora busca correos recientes que mencionen empresas de sus procesos
/// activos y las alertas de empleo de LinkedIn, y se los envía a Rumbo. Marca
/// lo enviado con la etiqueta «Rumbo» para no repetirlo. El acceso a Gmail
/// nunca sale de la cuenta de Google.
String buildGmailScript({required String functionUrl, required String key}) =>
    '''
// Rumbo (script v2): lee los correos de tus procesos de selección y tus
// alertas de empleo de LinkedIn.
// 1. Pega este código en script.google.com (Nuevo proyecto).
// 2. Elige la función «instalar» arriba y pulsa Ejecutar.
// 3. Autoriza el acceso con tu cuenta de Google.
// Para desconectarlo, borra el proyecto o desconéctalo desde Rumbo.

const RUMBO_URL = '$functionUrl';
const RUMBO_KEY = '$key';
const ETIQUETA = 'Rumbo';
const MAX_HILOS = 20;
const MAX_ALERTAS = 10;
const ALERTAS_LINKEDIN =
  'from:(jobalerts-noreply@linkedin.com OR jobs-noreply@linkedin.com)';

function instalar() {
  ScriptApp.getProjectTriggers().forEach(function (t) {
    ScriptApp.deleteTrigger(t);
  });
  ScriptApp.newTrigger('revisarCorreo').timeBased().everyHours(1).create();
  revisarCorreo();
}

function llamar(datos) {
  const respuesta = UrlFetchApp.fetch(RUMBO_URL, {
    method: 'post',
    contentType: 'application/json',
    headers: { 'x-sync-key': RUMBO_KEY },
    payload: JSON.stringify(datos),
    muteHttpExceptions: true,
  });
  const codigo = respuesta.getResponseCode();
  if (codigo !== 200) {
    throw new Error('Rumbo respondió ' + codigo + ': ' + respuesta.getContentText());
  }
  return JSON.parse(respuesta.getContentText());
}

function etiquetaRumbo() {
  return GmailApp.getUserLabelByName(ETIQUETA) || GmailApp.createLabel(ETIQUETA);
}

function revisarCorreo() {
  // Si una parte falla, la otra se intenta igual; el error se ve en el
  // historial de ejecuciones.
  const errores = [];
  [revisarProcesos, revisarAlertas].forEach(function (revisar) {
    try {
      revisar();
    } catch (e) {
      errores.push(e);
    }
  });
  if (errores.length) throw errores[0];
}

function revisarProcesos() {
  const empresas = llamar({ action: 'companies' }).companies;
  if (!empresas.length) return;
  const etiqueta = etiquetaRumbo();
  const nombres = empresas
    .map(function (e) { return '"' + e.replace(/"/g, '') + '"'; })
    .join(' OR ');
  const consulta =
    'newer_than:14d -label:' + ETIQUETA + ' -in:sent -in:chats (' + nombres + ')';
  const hilos = GmailApp.search(consulta, 0, MAX_HILOS);
  if (!hilos.length) return;
  const mensajes = hilos.map(function (hilo) {
    const m = hilo.getMessages().pop();
    return {
      id: m.getId(),
      from: m.getFrom(),
      subject: m.getSubject(),
      date: m.getDate().toISOString(),
      body: m.getPlainBody().slice(0, 4000),
    };
  });
  llamar({ action: 'messages', messages: mensajes });
  hilos.forEach(function (hilo) { hilo.addLabel(etiqueta); });
}

// Texto del correo con los enlaces a la vista. Si el texto plano no trae
// los enlaces a las ofertas, se saca del HTML.
function textoConEnlaces(m) {
  const plano = m.getPlainBody();
  if (plano.indexOf('jobs/view') !== -1) return plano;
  return m.getBody()
    .replace(/<a[^>]+href="([^"]+)"[^>]*>/gi, ' \$1 ')
    .replace(/<(br|\\/p|\\/div|\\/tr|\\/li)[^>]*>/gi, '\\n')
    .replace(/<[^>]+>/g, ' ')
    .replace(/&amp;/g, '&')
    .replace(/&nbsp;/g, ' ')
    .replace(/&#39;/g, "'")
    .replace(/&quot;/g, '"');
}

// Alertas de empleo de LinkedIn: Rumbo las convierte en sugerencias.
function revisarAlertas() {
  const consulta =
    'newer_than:3d -label:' + ETIQUETA + ' -in:sent ' + ALERTAS_LINKEDIN;
  const hilos = GmailApp.search(consulta, 0, MAX_ALERTAS);
  if (!hilos.length) return;
  const mensajes = hilos.map(function (hilo) {
    const m = hilo.getMessages().pop();
    return {
      id: m.getId(),
      from: m.getFrom(),
      subject: m.getSubject(),
      date: m.getDate().toISOString(),
      body: textoConEnlaces(m).slice(0, 20000),
    };
  });
  llamar({ action: 'linkedin_alerts', messages: mensajes });
  const etiqueta = etiquetaRumbo();
  hilos.forEach(function (hilo) { hilo.addLabel(etiqueta); });
}
''';
