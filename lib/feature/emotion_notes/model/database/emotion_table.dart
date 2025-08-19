import 'package:drift/drift.dart';
import 'notes_table.dart';

class Emotions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get noteId => integer().references(Notes, #id)();
  TextColumn get emotionName => text()();
  IntColumn get percentage => integer()();
}
