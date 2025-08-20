import 'package:emotional_notes/core/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
