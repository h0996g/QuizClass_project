import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  static TextStyle get fieldLabel => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1F2937),
      );

  static TextStyle get errorText => TextStyle(
        fontSize: 13.sp,
        color: AppColors.error,
      );

  static TextStyle get linkAction => TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
      );
}
