import 'package:education_project_example/core/constants/cache_keys.dart';
import 'package:education_project_example/core/helper/cache_helper.dart';
import 'package:education_project_example/core/helper/observer.dart';
import 'package:education_project_example/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/manager/login/login_cubit.dart';
import 'features/auth/presentation/views/login_page.dart';
import 'features/start_page/presentation/manager/student_start/student_start_cubit.dart';
import 'features/start_page/presentation/manager/teacher_start/teacher_start_cubit.dart';
import 'features/start_page/presentation/views/student_start_page.dart';
import 'features/start_page/presentation/views/teacher_start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const EducationApp());
}

class EducationApp extends StatelessWidget {
  const EducationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: _initialPage(),
        );
      },
    );
  }

  Widget _initialPage() {
    if (FirebaseAuth.instance.currentUser == null) {
      return BlocProvider(
        create: (_) => LoginCubit(),
        child: const LoginPage(),
      );
    }
    final bool isTeacher =
        CacheHelper.getData(key: CacheKeys.userRole) == 'teacher';
    if (isTeacher) {
      return BlocProvider(
        create: (_) => TeacherStartCubit(),
        child: const TeacherStartPage(),
      );
    }
    return BlocProvider(
      create: (_) => StudentStartCubit(),
      child: const StudentStartPage(),
    );
  }
}
