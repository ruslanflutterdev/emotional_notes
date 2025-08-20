import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/dependensies/note_with_emotions.dart';
import '../../models/repositories/notes_repository.dart';

class NotesListViewModel extends StateNotifier<AsyncValue<List<NoteWithEmotions>>> {
  final NotesRepository _repository;

  NotesListViewModel(this._repository) : super(const AsyncValue.loading()) {
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    try {
      final notes = await _repository.getAllNotes();
      state = AsyncValue.data(notes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await _repository.deleteNote(id);
      _loadNotes();
    } catch (e) {
      throw Exception('Не удалось удалить заметку');
    }
  }
}
