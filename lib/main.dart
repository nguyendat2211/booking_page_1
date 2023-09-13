
import 'package:booking_page_1/services/list_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modular.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ModularApp(
      module: ServiceModular(),
      child: const MaterialApp(
        home: ListServices(),
      ),
    );
  }
}
