import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Procesos de postulación y su historial de estados (lo escribe un trigger
/// de Postgres; el repositorio en memoria lo imita).
abstract interface class ApplicationsRepository {
  Future<Result<List<ApplicationWithJob>>> list();

  /// Crea el proceso si su id está vacío; si no, lo actualiza.
  Future<Result<Application>> save(Application application);

  Future<Result<void>> delete(String id);

  /// Historial de estados, del más antiguo al más reciente.
  Future<Result<List<ApplicationEvent>>> events(String applicationId);

  /// Historial de todos los procesos, agrupado por proceso.
  Future<Result<Map<String, List<ApplicationEvent>>>> allEvents();
}
