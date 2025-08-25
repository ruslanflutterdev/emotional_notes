import 'package:drift/drift.dart';
import '../../../../core/database/database.dart';
import '../../../../core/dependensies/note_with_emotions.dart';

class NotesRepository {
  final AppDatabase _database;

  NotesRepository(this._database);

  Future<List<NoteWithEmotions>> getAllNotes({String? tag}) async {
    final query = _database.select(_database.notes);
    if (tag != null) {
      query.where((t) => t.tag.equals(tag));
    }

    final notes = await query.get();
    final noteWithEmotionsList = await Future.wait(
      notes.map((note) async {
        final emotions = await (_database.select(
          _database.emotions,
        )..where((t) => t.noteId.equals(note.id))).get();
        return NoteWithEmotions(note: note, emotions: emotions, tag: note.tag);
      }),
    );

    return noteWithEmotionsList;
  }

  Future<List<String>> getAllTags() async {
    final tags = await _database.select(_database.notes).get();
    final uniqueTags = tags
        .map((note) => note.tag)
        .where((tag) => tag != null)
        .cast<String>()
        .toSet()
        .toList();
    return uniqueTags;
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
