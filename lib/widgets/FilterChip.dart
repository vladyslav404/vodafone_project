import 'package:flutter/material.dart';

filterChip(
  bool selected, {
  String label,
  Function func,
}) {
  return FilterChip(
    backgroundColor: Color(0xFFC2D8DA),
    selectedColor: Color(0xFFA0BCC0),
    label: Text(label),
    selected: selected,
    onSelected: func,
  );
}
