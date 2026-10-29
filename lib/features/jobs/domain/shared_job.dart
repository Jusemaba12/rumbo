/// Enlace y texto de una oferta que llega compartida o copiada.
///
/// Las apps suelen compartir «Título de la oferta https://…»: el enlace va al
/// campo de enlace y el texto se descarta (es solo el título). Una
/// descripción pegada (texto largo) se conserva entera, con sus enlaces: ahí
/// suelen estar el correo y el LinkedIn del reclutador, que la IA extrae.
({String? url, String? text}) splitSharedJob(String shared) {
  final trimmed = shared.trim();
  if (trimmed.isEmpty) return (url: null, text: null);
  final urls = _urlPattern.allMatches(trimmed).map((m) => m.group(0)!).toList();
  // Un perfil de LinkedIn es del reclutador, no de la oferta.
  final url = urls.where((u) => !_profilePattern.hasMatch(u)).firstOrNull;
  var rest = trimmed;
  for (final link in urls) {
    rest = rest.replaceFirst(link, '');
  }
  rest = rest.trim();
  final isDescription = rest.length >= minSharedDescription;
  return (
    url: url,
    text: isDescription
        ? trimmed
        : url == null
        ? trimmed
        : null,
  );
}

/// Texto mínimo para tratarlo como descripción y no como título.
const minSharedDescription = 200;

final _urlPattern = RegExp(r'https?://[^\s<>"]+');
final _profilePattern = RegExp(r'linkedin\.com/in/', caseSensitive: false);
