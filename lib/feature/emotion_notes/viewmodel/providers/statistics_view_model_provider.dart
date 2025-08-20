import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifier/statistics_view_model.dart';
import 'notes_repository_provider.dart';

final statisticsViewModelProvider = StateNotifierProvider<StatisticsViewModel, AsyncValue<Map<String, double>>>((ref) {
  final repository = ref.watch(notesRepositoryProvider);
  return StatisticsViewModel(repository);
});
