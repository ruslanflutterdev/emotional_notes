import 'package:flutter/material.dart';

Color getColorForEmotion(String emotion) {
  switch (emotion) {
    case 'Радость':
      return Colors.yellow;
    case 'Злость':
      return Colors.red;
    case 'Грусть':
      return Colors.blue;
    case 'Страх':
      return Colors.grey;
    case 'Спокойствие':
      return Colors.green;
    case 'Удивление':
      return Colors.purple;
    default:
      return Colors.black;
  }
}
