import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:rumbo/features/jobs/domain/entities/job.dart';

part 'search_preferences.freezed.dart';

/// Portales disponibles para la búsqueda automática (ids del servidor).
const List<String> searchSources = <String>[
  'getonboard',
  'remotive',
  'himalayas',
  'remoteok',
  'weworkremotely',
];

/// Portales de empleo de empresas que se pueden vigilar.
enum BoardProvider {
  greenhouse,
  lever,
  ashby,
  workable,
  smartrecruiters,
  recruitee,
  teamtailor,
}

/// Subdominios que son del propio servicio, no de una empresa.
const Set<String> _reservedSubdomains = <String>{
  'www',
  'app',
  'api',
  'apply',
  'jobs',
  'careers',
};

/// Máximo de empresas vigiladas (igual que MAX_BOARDS en el servidor).
const int maxWatchedBoards = 20;

/// Página de empleo de una empresa: proveedor + identificador en su URL.
@freezed
abstract class WatchedBoard with _$WatchedBoard {
  const factory WatchedBoard({
    required BoardProvider provider,
    required String token,
  }) = _WatchedBoard;
}

/// Reconoce la página de empleo de una empresa a partir de su enlace:
/// boards.greenhouse.io/acme, job-boards.greenhouse.io/acme,
/// jobs.lever.co/acme, jobs.ashbyhq.com/acme, apply.workable.com/acme
/// (o acme.workable.com), jobs.smartrecruiters.com/Acme, acme.recruitee.com o
/// acme.teamtailor.com. Nulo si no es ninguna.
WatchedBoard? parseBoardUrl(String input) {
  String text = input.trim();
  if (text.isEmpty) return null;
  if (!text.contains('://')) text = 'https://$text';
  final Uri? uri = Uri.tryParse(text);
  if (uri == null) return null;
  final String host = uri.host.toLowerCase();
  final List<String> segments = uri.pathSegments
      .where((String s) => s.isNotEmpty)
      .toList();
  final String? token;
  final BoardProvider provider;
  if (host.endsWith('greenhouse.io')) {
    provider = BoardProvider.greenhouse;
    // Formato incrustado: boards.greenhouse.io/embed/job_board?for=acme
    token = segments.firstOrNull == 'embed'
        ? uri.queryParameters['for']
        : segments.firstOrNull;
  } else if (host == 'jobs.lever.co' || host == 'jobs.eu.lever.co') {
    provider = BoardProvider.lever;
    token = segments.firstOrNull;
  } else if (host == 'jobs.ashbyhq.com') {
    provider = BoardProvider.ashby;
    token = segments.firstOrNull;
  } else if (host == 'apply.workable.com') {
    provider = BoardProvider.workable;
    // apply.workable.com/j/CODIGO es una oferta suelta, sin la empresa.
    token = segments.firstOrNull == 'j' ? null : segments.firstOrNull;
  } else if (host.endsWith('.workable.com')) {
    provider = BoardProvider.workable;
    token = _subdomain(host: host, domain: 'workable.com');
  } else if (host == 'jobs.smartrecruiters.com' ||
      host == 'careers.smartrecruiters.com') {
    provider = BoardProvider.smartrecruiters;
    token = segments.firstOrNull;
  } else if (host.endsWith('.recruitee.com')) {
    provider = BoardProvider.recruitee;
    token = _subdomain(host: host, domain: 'recruitee.com');
  } else if (host.endsWith('.teamtailor.com')) {
    provider = BoardProvider.teamtailor;
    token = _subdomain(host: host, domain: 'teamtailor.com');
  } else {
    return null;
  }
  if (token == null ||
      !RegExp(r'^[a-z0-9._-]+$', caseSensitive: false).hasMatch(token)) {
    return null;
  }
  return WatchedBoard(provider: provider, token: token.toLowerCase());
}

/// Empresas que trabajan con Flutter y contratan en remoto desde Colombia
/// (comprobadas el 19 oct 2026). Se proponen en «Empresas que vigilas».
const List<({WatchedBoard board, String name})>
flutterBoardSuggestions = <({WatchedBoard board, String name})>[
  // Ubuntu usa Flutter en el escritorio; casi todo remoto mundial.
  (
    board: WatchedBoard(provider: BoardProvider.greenhouse, token: 'canonical'),
    name: 'Canonical',
  ),
  // Constructor visual de apps Flutter.
  (
    board: WatchedBoard(provider: BoardProvider.ashby, token: 'flutterflow'),
    name: 'FlutterFlow',
  ),
  // Contrata desarrolladores para clientes de EE. UU., remoto desde LATAM.
  (
    board: WatchedBoard(provider: BoardProvider.ashby, token: 'truelogic'),
    name: 'Truelogic',
  ),
  // Mantienen SDK de Flutter (supabase_flutter, purchases_flutter).
  (
    board: WatchedBoard(provider: BoardProvider.ashby, token: 'supabase'),
    name: 'Supabase',
  ),
  (
    board: WatchedBoard(provider: BoardProvider.ashby, token: 'revenuecat'),
    name: 'RevenueCat',
  ),
];

/// Nombre para mostrar: el de las sugerencias si es una de ellas.
String boardDisplayName(WatchedBoard board) =>
    flutterBoardSuggestions
        .where((({WatchedBoard board, String name}) s) => s.board == board)
        .map((({WatchedBoard board, String name}) s) => s.name)
        .firstOrNull ??
    boardCompanyName(board.token);

/// «acme» en acme.recruitee.com; nulo si es del propio servicio o tiene más
/// niveles (www.acme.recruitee.com).
String? _subdomain({required String host, required String domain}) {
  final String name = host.substring(0, host.length - domain.length - 1);
  if (name.contains('.') || _reservedSubdomains.contains(name)) return null;
  return name;
}

/// «acme-labs» → «Acme Labs».
String boardCompanyName(String token) => token
    .split(RegExp(r'[-_.]+'))
    .where((String word) => word.isNotEmpty)
    .map((String word) => word[0].toUpperCase() + word.substring(1))
    .join(' ');

@freezed
abstract class SearchPreferences with _$SearchPreferences {
  const SearchPreferences._();

  const factory SearchPreferences({
    @Default(<String>[]) List<String> roles,
    @Default(<String>[]) List<String> technologies,
    @Default(<WorkMode>[WorkMode.remote]) List<WorkMode> workModes,
    @Default(<String>[]) List<String> countries,
    @Default(searchSources) List<String> sources,
    @Default(60) int minScore,
    @Default(<WatchedBoard>[]) List<WatchedBoard> watchedBoards,
    DateTime? lastRunAt,
  }) = _SearchPreferences;

  /// La búsqueda necesita al menos un cargo o una tecnología.
  bool get isConfigured => roles.isNotEmpty || technologies.isNotEmpty;

  /// Se busca sola si la última búsqueda tiene más de [maxAge].
  bool isStale(DateTime now, {Duration maxAge = const Duration(hours: 6)}) {
    final DateTime? last = lastRunAt;
    return last == null || now.difference(last) >= maxAge;
  }
}
