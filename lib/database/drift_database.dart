import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:jw_calendar/model/category_color.dart';
import 'package:jw_calendar/model/schedule.dart';
import 'package:jw_calendar/model/schedule_with_color.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// private 값까지 불러올 수 있다.
part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Schedules,
    CategoryColors,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => schedules.id.equals(id))).go();

  // append 하거나, 업데이트하거나 static한 데이터를 불러오는 경우가 아니라면 Stream
  Stream<List<ScheduleWithColor>> watchSchedule(DateTime date) {
    final query = select(schedules).join([
      innerJoin(categoryColors, categoryColors.id.equalsExp(schedules.colorId)),
    ]);

    query.where(schedules.date.equals(date));
    query.orderBy(
      [
        OrderingTerm.asc(schedules.startTime),
        OrderingTerm.asc(schedules.endTime),
      ],
    );

    return query.watch().map(
          (rows) => rows
              .map(
                (row) => ScheduleWithColor(
                  schedule: row.readTable(schedules),
                  categoryColor: row.readTable(categoryColors),
                ),
              )
              .toList(),
        );
  }

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
