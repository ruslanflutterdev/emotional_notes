import '../database/database.dart';

class NoteWithEmotions {
  final Note note;
  final List<Emotion> emotions;
  final String? tag;

  NoteWithEmotions({required this.note, required this.emotions, this.tag});

  factory NoteWithEmotions.fromNote(Note note) {
    return NoteWithEmotions(note: note, emotions: [], tag: note.tag);
  }
}
