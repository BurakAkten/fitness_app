import 'package:fitness_app/base/constants/app_texts.dart';
import 'package:fitness_app/screens/exercises/exercise_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../base/constants/app_theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, __) => MaterialApp(
        theme: AppTheme().theme,
        title: AppTexts.appName,
        debugShowCheckedModeBanner: false,
        home: const ExercisesScreen(),
      ),
    );
  }
}
