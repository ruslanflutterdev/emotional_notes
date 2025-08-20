import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/dependensies/note_with_emotions.dart';
import '../notifier/note_create_edit_view_model.dart';
import 'notes_repository_provider.dart';

final noteCreateEditViewModelProvider = StateNotifierProvider.family<NoteCreateEditViewModel, AsyncValue<void>, NoteWithEmotions?>((ref, note) {
  final repository = ref.watch(notesRepositoryProvider);
  return NoteCreateEditViewModel(repository, note);
});
