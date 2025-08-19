import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../../feature/emotion_notes/model/database/emotion_table.dart';
import '../../feature/emotion_notes/model/database/notes_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Notes, Emotions])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'emotion_notes',
      native: DriftNativeOptions(
        databaseDirectory: () => getApplicationSupportDirectory(),
      ),
    );
  }
}
