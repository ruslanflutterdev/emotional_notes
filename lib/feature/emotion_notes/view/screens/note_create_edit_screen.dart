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
  String? _selectedTag;
  final _tagController = TextEditingController();
  List<String> _availableTags = [];
  bool _isLoadingTags = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.note?.note.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.note?.note.description ?? '',
    );
    _selectedTag = widget.note?.note.tag;
    _loadTags();

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

  Future<void> _loadTags() async {
    final tags = await ref
        .read(noteCreateEditViewModelProvider(widget.note).notifier)
        .getAvailableTags();
    if (mounted) {
      setState(() {
        _availableTags = tags;
        if (_selectedTag != null && !_availableTags.contains(_selectedTag)) {
          // Если текущего тега нет в списке, добавляем его, чтобы не было ошибки
          _availableTags.add(_selectedTag!);
        }
        _isLoadingTags = false;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _emotionControllers.forEach((key, controller) => controller.dispose());
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              SnackBar(content: Text('Заметка успешно сохранена!')),
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
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Заголовок'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Описание'),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              if (_isLoadingTags)
                CircularProgressIndicator()
              else
                DropdownButtonFormField<String>(
                  value: _selectedTag,
                  decoration: InputDecoration(
                    labelText: 'Выберите или введите тег',
                  ),
                  items: [
                    DropdownMenuItem<String>(
                      value: null,
                      child: Text('Нет тега'),
                    ),
                    ..._availableTags.map((tag) {
                      return DropdownMenuItem<String>(
                        value: tag,
                        child: Text(tag),
                      );
                    }),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTag = newValue;
                      _tagController.text = newValue ?? '';
                    });
                  },
                ),
              SizedBox(height: 16),
              TextField(
                controller: _tagController,
                decoration: InputDecoration(labelText: 'Или введите новый тег'),
                onChanged: (value) {
                  setState(() {
                    _selectedTag = null;
                  });
                },
              ),
              SizedBox(height: 24),
              Text(
                'Распределение эмоций (в %):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ...emotions.map((emotion) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(child: Text(emotion)),
                      SizedBox(
                        width: 80,
                        child: TextField(
                          controller: _emotionControllers[emotion],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
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
              SizedBox(height: 24),
              if (isLoading)
                CircularProgressIndicator()
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
                          String? finalTag = _selectedTag;
                          if (finalTag == null || finalTag.isEmpty) {
                            final newTagText = _tagController.text.trim();
                            if (newTagText.isNotEmpty) {
                              finalTag = newTagText;
                            }
                          }
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
                                tag: finalTag,
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
