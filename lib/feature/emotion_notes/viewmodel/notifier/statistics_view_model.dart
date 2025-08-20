import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/repositories/notes_repository.dart';

class StatisticsViewModel extends StateNotifier<AsyncValue<Map<String, double>>> {
  final NotesRepository _repository;

  StatisticsViewModel(this._repository) : super(const AsyncValue.loading()) {
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    try {
      final notes = await _repository.getAllNotes();
      final Map<String, int> aggregatedEmotions = {};

      for (final note in notes) {
        for (final emotion in note.emotions) {
          aggregatedEmotions.update(emotion.emotionName, (value) => value + emotion.percentage, ifAbsent: () => emotion.percentage);
        }
      }

      final totalPercentage = aggregatedEmotions.values.fold(0, (sum, percentage) => sum + percentage);
      final Map<String, double> percentageMap = {};
      aggregatedEmotions.forEach((key, value) {
        percentageMap[key] = (value / totalPercentage) * 100;
      });

      state = AsyncValue.data(percentageMap);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
