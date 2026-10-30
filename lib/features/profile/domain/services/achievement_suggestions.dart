/// Huecos entre corchetes que la persona debe completar («[X %]»).
final RegExp placeholderPattern = RegExp(r'\[[^\]]+\]');

/// Aplica a [achievements] los textos elegidos: sustituye por índice y añade
/// los nuevos al final.
List<String> applySuggestions({
  required List<String> achievements,
  required List<({int? index, String text})> chosen,
}) {
  final List<String> result = <String>[...achievements];
  for (final ({int? index, String text}) item in chosen) {
    final String text = item.text.trim();
    if (text.isEmpty) continue;
    final int? index = item.index;
    if (index != null && index >= 0 && index < result.length) {
      result[index] = text;
    } else {
      result.add(text);
    }
  }
  return result;
}
