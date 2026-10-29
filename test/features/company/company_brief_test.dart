import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/company/domain/company_brief.dart';

void main() {
  test('convierte la ficha de la empresa', () {
    final brief = CompanyBrief.fromJson({
      'summary': 'Fintech chilena que busca escalar su app.',
      'team_and_stack': ['Flutter', 'Firebase'],
      'culture': [],
      'questions_to_ask': ['¿Cómo es el proceso de despliegue?'],
      'red_flags': ['No indica salario', 3],
      'general_knowledge': '',
      'generated_at': '2026-10-18T15:00:00Z',
    });
    expect(brief.teamAndStack, ['Flutter', 'Firebase']);
    expect(brief.redFlags, ['No indica salario']);
    expect(brief.generalKnowledge, isEmpty);
    expect(brief.generatedAt!.toUtc(), DateTime.utc(2026, 10, 18, 15));
  });
}
