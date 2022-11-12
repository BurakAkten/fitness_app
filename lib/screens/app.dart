import 'package:fitness_app/base/constants/app_texts.dart';
import 'package:fitness_app/utils/db_util.dart';
import 'package:fitness_app/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../base/constants/app_theme.dart';
import 'exercises/exercises_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void dispose() {
    DBUtil.db.closeDatabase();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, __) => MaterialApp(
        theme: AppTheme().theme,
        title: AppTexts.appName,
        navigatorKey: NavigationUtil.navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const ExercisesScreen(),
        onGenerateRoute: NavigationUtil.onGenerateRoute,
      ),
    );
  }
}
