import 'package:emotional_notes/feature/emotion_notes/viewmodel/providers/notes_list_view_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/dependensies/note_with_emotions.dart';
import '../../viewmodel/providers/note_create_edit_view_model_provider.dart';

class NoteCreateEditScreen extends ConsumerStatefulWidget {
  final NoteWithEmotions? note;

  const NoteCreateEditScreen({super.key, this.note});

  @override
  ConsumerState<NoteCreateEditScreen> createState() =>
      _NoteCreateEditScreenState();
}

class _NoteCreateEditScreenState extends ConsumerState<NoteCreateEditScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  final _emotionControllers = <String, TextEditingController>{};

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.note?.note.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.note?.note.description ?? '',
    );

    for (var emotionName in emotions) {
      int percentage = 0;

      if (widget.note != null) {
        final match = widget.note!.emotions.where(
          (e) => e.emotionName == emotionName,
        );
        if (match.isNotEmpty) {
          percentage = match.first.percentage;
        }
      }

      _emotionControllers[emotionName] = TextEditingController(
        text: percentage > 0 ? percentage.toString() : '',
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _emotionControllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen здесь, чтобы он был привязан к жизненному циклу виджета
    ref.listen<AsyncValue<void>>(noteCreateEditViewModelProvider(widget.note), (
      previous,
      next,
    ) {
      next.when(
        data: (_) {
          if (previous!.isLoading) {
            ref.invalidate(notesListViewModelProvider);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Заметка успешно сохранена!')),
            );
          }
        },
        error: (e, st) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
        },
        loading: () {},
      );
    });

    final state = ref.watch(noteCreateEditViewModelProvider(widget.note));
    final isLoading = state.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.note == null ? 'Новая заметка' : 'Редактировать заметку',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Заголовок'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Описание'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              const Text(
                'Распределение эмоций (в %):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ...emotions.map((emotion) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(child: Text(emotion)),
                      SizedBox(
                        width: 80,
                        child: TextField(
                          controller: _emotionControllers[emotion],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 24),
              if (isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          final emotionsMap = <String, int>{};
                          _emotionControllers.forEach((key, controller) {
                            final value = int.tryParse(controller.text) ?? 0;
                            if (value > 0) {
                              emotionsMap[key] = value;
                            }
                          });
                          ref
                              .read(
                                noteCreateEditViewModelProvider(
                                  widget.note,
                                ).notifier,
                              )
                              .saveNote(
                                title: _titleController.text,
                                description: _descriptionController.text,
                                emotions: emotionsMap,
                              );
                        },
                  child: Text(widget.note == null ? 'Сохранить' : 'Обновить'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
