import 'package:flutter/material.dart';
import 'package:worklog/core/app_colors.dart';

class AppText {
  static const TextStyle bodyText = TextStyle(
    fontSize: 36,
    color: AppColor.primary,
    fontWeight: FontWeight.bold,
    letterSpacing: 24,
  );

  static const TextStyle taskTitleText = TextStyle(
      fontSize: 14, color: AppColor.title, fontWeight: FontWeight.bold);
  static const TextStyle taskDescpText =
      TextStyle(fontSize: 12, color: AppColor.descp);
}
