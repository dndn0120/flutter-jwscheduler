import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jw_calendar/database/drift_database.dart';
import 'package:jw_calendar/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

const DEFAULT_COLORS = [
  'F44336',
  'FF9800',
  'FFEB3B',
  'FCAF50',
  '2196F3',
  '3F51B5',
  '9C27B0',
];

void main() async {
  // 플러터 앱이 준비가 될떄까지 기다린다.
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final database = LocalDatabase();

  GetIt.I.registerSingleton<LocalDatabase>(database);

  final colors = await database.getCategoryColors();

  if (colors.isEmpty == true) {
    for (String hexCode in DEFAULT_COLORS) {
      await database.createCategoryColor(
        CategoryColorsCompanion(
          hexCode: Value(hexCode),
        ),
      );
    }
  }

  print('---------GET COLORS======');
  print(await database.getCategoryColors());

  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'NotoSans',
    ),
    home: HomeScreen(),
  ));
}
