import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:education_project_example/core/theme/app_colors.dart';
import 'package:education_project_example/core/widgets/submit_button.dart';

class ProfileErrorWidget extends StatelessWidget {
  const ProfileErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  final String? errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: AppColors.error),
            SizedBox(height: 16.h),
            Text(
              errorMessage ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 24.h),
            SubmitButton(label: 'Retry', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
