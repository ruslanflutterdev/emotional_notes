import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/emotion_colors.dart';
import '../../viewmodel/providers/statistics_view_model_provider.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statisticsState = ref.watch(statisticsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title:  Text('Статистика эмоций'),
      ),
      body: statisticsState.when(
        data: (emotionData) {
          if (emotionData.isEmpty) {
            return  Center(child: Text('Нет данных для статистики.'));
          }

          final pieChartSections = emotionData.entries.map((entry) {
            return PieChartSectionData(
              color: getColorForEmotion(entry.key),
              value: entry.value,
              title: '${entry.value.toStringAsFixed(1)}%',
              radius: 50,
              titleStyle:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            );
          }).toList();

          return Center(
            child: SizedBox(
              height: 300,
              child: PieChart(
                PieChartData(
                  sections: pieChartSections,
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          );
        },
        loading: () =>  Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text('Ошибка: $err')),
      ),
    );
  }


}
