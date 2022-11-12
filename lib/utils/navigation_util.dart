import 'package:fitness_app/screens/exercises/exercises_screen.dart';
import 'package:flutter/material.dart';
import '../screens/exercise/exercise_screen.dart';

class NavigationUtil {
  static final navigatorKey = GlobalKey<NavigatorState>();

  //Screens
  static const String exerciseScreen = "exerciseScreen";
  static const String exercisesScreen = "exercisesScreen";

  static _navigateToPage(context, String pageName, {Object? arguments}) => Navigator.pushNamed(context, pageName, arguments: arguments);
  static navigateToBack(context, {dynamic value}) => Navigator.pop(context, value);

  //Navigate screens methods
  static navigateToExerciseScreen(context, {Object? arguments}) => _navigateToPage(context, exerciseScreen, arguments: arguments);
  static navigateToExercisesScreen(context) => _navigateToPage(context, exercisesScreen);

  static Route onGenerateRoute(settings) =>
      MaterialPageRoute(builder: (context) => _buildNavigationMap(context, settings), settings: RouteSettings(name: settings.name));

  static _buildNavigationMap(context, settings) {
    Widget page = ExercisesScreen();

    switch (settings.name) {
      case exerciseScreen:
        page = ExerciseScreen(exercise: settings.arguments);
        break;
      case exercisesScreen:
        page = ExercisesScreen();
        break;
    }
    return page;
  }
}
