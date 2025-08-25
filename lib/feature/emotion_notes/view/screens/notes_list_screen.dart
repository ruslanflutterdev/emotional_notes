import 'package:emotional_notes/feature/emotion_notes/view/screens/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodel/providers/notes_list_view_model_provider.dart';
import '../../viewmodel/providers/selected_tag_provider.dart';
import '../widgets/note_list_item.dart';
import 'note_create_edit_screen.dart';

class NotesListScreen extends ConsumerWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesState = ref.watch(notesListViewModelProvider);
    final selectedTag = ref.watch(selectedTagProvider);
    final notesListViewModel = ref.read(notesListViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Мои заметки'),
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => StatisticsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder<List<String>>(
            future: notesListViewModel.getAllTags(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox.shrink();
              }
              final tags = ['Все', ...snapshot.data!];
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  children: tags.map((tag) {
                    final isSelected =
                        selectedTag == tag ||
                        (selectedTag == null && tag == 'Все');
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: ActionChip(
                        label: Text(tag),
                        backgroundColor: isSelected
                            ? Colors.deepPurple.shade200
                            : null,
                        onPressed: () {
                          ref.read(selectedTagProvider.notifier).state =
                              tag == 'Все' ? null : tag;
                        },
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          Expanded(
            child: notesState.when(
              data: (notes) {
                if (notes.isEmpty) {
                  return Center(
                    child: Text('Пока нет заметок. Создайте первую!'),
                  );
                }
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final noteWithEmotions = notes[index];
                    return NoteListItem(noteWithEmotions: noteWithEmotions);
                  },
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, st) => Center(child: Text('Ошибка: $err')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => NoteCreateEditScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
