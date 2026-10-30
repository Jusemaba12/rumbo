import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';

void main() {
  group('ApplicationStatus', () {
    test('sigue el camino normal hasta la oferta aceptada', () {
      const List<ApplicationStatus> path = <ApplicationStatus>[
        ApplicationStatus.saved,
        ApplicationStatus.preparing,
        ApplicationStatus.applied,
        ApplicationStatus.inReview,
        ApplicationStatus.technicalTest,
        ApplicationStatus.interview,
        ApplicationStatus.offer,
        ApplicationStatus.accepted,
      ];
      for (int i = 0; i < path.length - 1; i++) {
        expect(path[i].canMoveTo(path[i + 1]), isTrue, reason: '${path[i]}');
      }
    });

    test('no permite postular sin preparar ni saltar a oferta', () {
      expect(
        ApplicationStatus.saved.canMoveTo(ApplicationStatus.applied),
        isFalse,
      );
      expect(
        ApplicationStatus.applied.canMoveTo(ApplicationStatus.offer),
        isFalse,
      );
    });

    test('los estados finales no admiten cambios', () {
      for (final ApplicationStatus status in <ApplicationStatus>[
        ApplicationStatus.accepted,
        ApplicationStatus.declined,
        ApplicationStatus.rejected,
      ]) {
        expect(status.isClosed, isTrue);
        expect(status.nextStatuses, isEmpty);
      }
    });

    test('sin respuesta puede reactivarse', () {
      expect(ApplicationStatus.noResponse.isClosed, isFalse);
      expect(
        ApplicationStatus.noResponse.canMoveTo(ApplicationStatus.interview),
        isTrue,
      );
    });

    test('el valor de base de datos es reversible', () {
      for (final ApplicationStatus status in ApplicationStatus.values) {
        expect(ApplicationStatus.fromDb(status.dbValue), status);
      }
      expect(ApplicationStatus.technicalTest.dbValue, 'technical_test');
    });
  });
}
