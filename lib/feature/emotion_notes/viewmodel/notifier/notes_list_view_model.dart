import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/dependensies/note_with_emotions.dart';
import '../../models/repositories/notes_repository.dart';
import '../providers/selected_tag_provider.dart';

class NotesListViewModel
    extends StateNotifier<AsyncValue<List<NoteWithEmotions>>> {
  final NotesRepository _repository;
  final Ref _ref;

  NotesListViewModel(this._repository, this._ref)
    : super(const AsyncValue.loading()) {
    _ref.listen(selectedTagProvider, (_, next) {
      _loadNotes(tag: next);
    });
    _loadNotes();
  }

  Future<void> _loadNotes({String? tag}) async {
    try {
      final notes = await _repository.getAllNotes(tag: tag);
      state = AsyncValue.data(notes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await _repository.deleteNote(id);
      _loadNotes(tag: _ref.read(selectedTagProvider));
    } catch (e) {
      throw Exception('Не удалось удалить заметку');
    }
  }

  Future<List<String>> getAllTags() async {
    return _repository.getAllTags();
  }
}
