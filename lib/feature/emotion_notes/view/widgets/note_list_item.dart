import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/dependensies/note_with_emotions.dart';
import '../../viewmodel/providers/notes_list_view_model_provider.dart';
import '../screens/note_create_edit_screen.dart';

class NoteListItem extends ConsumerWidget {
  final NoteWithEmotions noteWithEmotions;

  const NoteListItem({super.key, required this.noteWithEmotions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasEmotions = noteWithEmotions.emotions.isNotEmpty;
    final emotionsText = hasEmotions
        ? noteWithEmotions.emotions
              .map((e) => '${e.emotionName} (${e.percentage}%)')
              .join(', ')
        : 'Нет эмоций';

    return ListTile(
      title: Text(noteWithEmotions.note.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emotionsText),
          if (noteWithEmotions.tag != null && noteWithEmotions.tag!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                'Тег: ${noteWithEmotions.tag}',
                style: TextStyle(fontSize: 12, color: Colors.blueGrey),
              ),
            ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NoteCreateEditScreen(note: noteWithEmotions),
          ),
        );
      },
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () async {
          try {
            await ref
                .read(notesListViewModelProvider.notifier)
                .deleteNote(noteWithEmotions.note.id);
            if (!context.mounted) return;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Заметка удалена')));
          } catch (e) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(e.toString())));
          }
        },
      ),
    );
  }
}
