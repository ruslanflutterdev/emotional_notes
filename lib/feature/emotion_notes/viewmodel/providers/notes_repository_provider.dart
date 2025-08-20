import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/repositories/notes_repository.dart';
import 'app_database_provider.dart';

final notesRepositoryProvider = Provider<NotesRepository>((ref) {
  final database = ref.read(appDatabaseProvider);
  return NotesRepository(database);
});
