import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/company/domain/entities/company_brief.dart';

void main() {
  test('convierte la ficha de la empresa', () {
    final CompanyBrief brief = CompanyBrief.fromJson(<String, dynamic>{
      'summary': 'Fintech chilena que busca escalar su app.',
      'team_and_stack': <String>['Flutter', 'Firebase'],
      'culture': <dynamic>[],
      'questions_to_ask': <String>['¿Cómo es el proceso de despliegue?'],
      'red_flags': <Object>['No indica salario', 3],
      'general_knowledge': '',
      'generated_at': '2026-10-18T15:00:00Z',
    });
    expect(brief.teamAndStack, <String>['Flutter', 'Firebase']);
    expect(brief.redFlags, <String>['No indica salario']);
    expect(brief.generalKnowledge, isEmpty);
    expect(brief.generatedAt!.toUtc(), DateTime.utc(2026, 10, 18, 15));
  });
}
