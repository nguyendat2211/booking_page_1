import 'package:booking_page_1/services_mobx/service_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ServiceModular extends Module {
  @override
  final List<Bind> binds = [Bind.singleton((i) => ServiceStore())];

  @override
  List<ModularRoute> routes = [];
}
