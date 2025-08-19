import '../database/database.dart';

class NoteWithEmotions {
  final Note note;
  final List<Emotion> emotions;

  NoteWithEmotions({required this.note, required this.emotions});
}
