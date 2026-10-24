import 'package:flutter/material.dart';
import 'package:taskati2/core/services/local/hive_provider.dart';

extension ThemeThemeExtension on BuildContext {
  ThemeData get theme=>Theme.of(this);
ColorScheme get colorScheme => theme.colorScheme;
bool get isDark =>HiveProvider.getData(HiveProvider.KIsdark)??false;
}