import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/dependensies/note_with_emotions.dart';
import '../notifier/notes_list_view_model.dart';
import 'notes_repository_provider.dart';

final notesListViewModelProvider =
    StateNotifierProvider<
      NotesListViewModel,
      AsyncValue<List<NoteWithEmotions>>
    >((ref) {
      final repository = ref.watch(notesRepositoryProvider);
      return NotesListViewModel(repository, ref);
    });
