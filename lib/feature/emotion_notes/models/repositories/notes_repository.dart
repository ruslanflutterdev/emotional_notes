import 'package:drift/drift.dart';
import '../../../../core/database/database.dart';
import '../../../../core/dependensies/note_with_emotions.dart';

class NotesRepository {
  final AppDatabase _database;

  NotesRepository(this._database);

  Future<List<NoteWithEmotions>> getAllNotes() async {
    final notes = await _database.select(_database.notes).join([
      innerJoin(
        _database.emotions,
        _database.emotions.noteId.equalsExp(_database.notes.id),
      ),
    ]).get();

    final Map<int, NoteWithEmotions> noteMap = {};

    for (final row in notes) {
      final note = row.readTable(_database.notes);
      final emotion = row.readTable(_database.emotions);

      if (!noteMap.containsKey(note.id)) {
        noteMap[note.id] = NoteWithEmotions(note: note, emotions: []);
      }
      noteMap[note.id]!.emotions.add(emotion);
    }

    return noteMap.values.toList();
  }

  Future<void> createNote(
    NotesCompanion note,
    List<EmotionsCompanion> emotions,
  ) async {
    final newNoteId = await _database.into(_database.notes).insert(note);
    for (final emotion in emotions) {
      await _database
          .into(_database.emotions)
          .insert(emotion.copyWith(noteId: Value(newNoteId)));
    }
  }

  Future<void> updateNote(
    NotesCompanion note,
    List<EmotionsCompanion> emotions,
  ) async {
    await _database.update(_database.notes).replace(note);
    await (_database.delete(
      _database.emotions,
    )..where((t) => t.noteId.equals(note.id.value))).go();
    for (final emotion in emotions) {
      await _database
          .into(_database.emotions)
          .insert(emotion.copyWith(noteId: note.id));
    }
  }

  Future<void> deleteNote(int id) async {
    await (_database.delete(
      _database.notes,
    )..where((t) => t.id.equals(id))).go();
  }
}
