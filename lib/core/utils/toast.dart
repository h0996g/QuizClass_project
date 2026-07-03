import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../theme/app_colors.dart';

enum AppToastType { success, error, warning }

class AppToast {
  const AppToast._();

  static Future<void> show(String message, AppToastType type) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: _colorFor(type),
      textColor: Colors.white,
      fontSize: 14,
    );
  }

  static Color _colorFor(AppToastType type) {
    return switch (type) {
      AppToastType.success => AppColors.success,
      AppToastType.error => AppColors.error,
      AppToastType.warning => AppColors.warning,
    };
  }
}
