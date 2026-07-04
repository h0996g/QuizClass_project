import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:education_project_example/core/theme/app_colors.dart';
import 'package:education_project_example/features/start_page/presentation/manager/student_start/student_start_cubit.dart';
import 'package:education_project_example/features/start_page/presentation/manager/student_start/student_start_state.dart';
import 'widgets/profile_error_widget.dart';
import 'widgets/profile_loading_widget.dart';

class ProfileStudentPage extends StatelessWidget {
  const ProfileStudentPage({super.key, required this.state});

  final StudentStartState state;

  @override
  Widget build(BuildContext context) {
    if (state.profileStatus == ProfileFetchStatus.initial ||
        state.profileStatus == ProfileFetchStatus.loading) {
      return const ProfileLoadingWidget();
    } else if (state.profileStatus == ProfileFetchStatus.error) {
      return ProfileErrorWidget(
        errorMessage: state.profileErrorMessage,
        onRetry: () => context.read<StudentStartCubit>().fetchProfile(),
      );
    } else {
      final user = state.user!;
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundColor: AppColors.primary,
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                user.name,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.email_outlined, size: 16.sp, color: Colors.grey),
                  SizedBox(width: 6.w),
                  Text(
                    user.email,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Text(
                  (user.role?.name ?? '').isEmpty
                      ? ''
                      : user.role!.name[0].toUpperCase() +
                            user.role!.name.substring(1),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
