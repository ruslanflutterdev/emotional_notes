import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/dependensies/note_with_emotions.dart';
import '../../models/repositories/notes_repository.dart';

class NoteCreateEditViewModel extends StateNotifier<AsyncValue<void>> {
  final NotesRepository _repository;
  final NoteWithEmotions? _initialNote;

  NoteCreateEditViewModel(this._repository, this._initialNote)
    : super(const AsyncValue.data(null));

  Future<List<String>> getAvailableTags() async {
    return _repository.getAllTags();
  }

  Future<void> saveNote({
    required String title,
    required String description,
    required Map<String, int> emotions,
    required String? tag,
  }) async {
    final totalPercentage = emotions.values.fold(
      0,
      (sum, percentage) => sum + percentage,
    );
    if (totalPercentage != 100) {
      throw Exception('Сумма процентов должна быть равна 100');
    }

    state = AsyncValue.loading();
    try {
      final emotionsCompanion = emotions.entries
          .map(
            (e) => EmotionsCompanion(
              emotionName: Value(e.key),
              percentage: Value(e.value),
            ),
          )
          .toList();

      if (_initialNote != null) {
        final noteCompanion = NotesCompanion(
          id: Value(_initialNote.note.id),
          title: Value(title),
          description: Value(description),
          tag: Value(tag),
        );
        await _repository.updateNote(noteCompanion, emotionsCompanion);
      } else {
        final noteCompanion = NotesCompanion(
          title: Value(title),
          description: Value(description),
          tag: Value(tag),
        );
        await _repository.createNote(noteCompanion, emotionsCompanion);
      }
      state = AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
