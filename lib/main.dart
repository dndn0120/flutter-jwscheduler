import 'package:flutter/material.dart';
import 'package:jw_calendar/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // 플러터 앱이 준비가 될떄까지 기다린다.
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'NotoSans',
    ),
    home: HomeScreen(),
  ));
}
