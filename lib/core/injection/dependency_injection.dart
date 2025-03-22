import 'package:able_app/features/maps/data/repositories/route_repository_impl.dart';
import 'package:able_app/features/maps/domain/repositories/route_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

class DependencyInjection {
  const DependencyInjection._();

  void injectDependencies() {
    GetIt.instance.registerSingleton<Client>(Client());
  }

  void _registerServices() {}

  void _registerRepositories() {
    GetIt.I.registerSingleton<RouteRepository>(
      RouteRepositoryImpl(client: GetIt.I<Client>()),
    );
  }
}
