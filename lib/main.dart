import 'package:booking_page_1/services/list_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_file.dart';

import 'modular.dart';

void main() async {
  // await initializeDateFormatting('vi_VN', '');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ModularApp(
      module: ServiceModular(),
      child: const MaterialApp(
        initialRoute: '/',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('vi', 'VN'), // Vietnamese
        ],
        home: SafeArea(child: ListServices()),
      ).modular(),
    );
  }
}
