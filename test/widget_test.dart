// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fitness_app/base/constants/app_texts.dart';
import 'package:fitness_app/base/constants/app_theme.dart';
import 'package:fitness_app/domain/models/exercise_model.dart';
import 'package:fitness_app/screens/exercises/exercises_screen.dart';
import 'package:fitness_app/screens/exercises/exercises_service.dart';
import 'package:fitness_app/screens/exercises/viewmodels/exercises_viewmodel.dart';
import 'package:fitness_app/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockService extends Mock implements ExercisesService {}

void main() {
  late MockService mockService;

  setUp(() {
    mockService = MockService();
  });

  final exercisesFromService = [
    ExerciseModel(id: 1, name: "BarBell Row", setRepeat: 3, setCount: 3, weight: 3, weightCount: 3),
    ExerciseModel(id: 2, name: "Squat", setRepeat: 3, setCount: 6),
    ExerciseModel(id: 3, name: "Shoulder Press", setRepeat: 4, setCount: 4, weight: 20, weightCount: 2),
  ];

  void arrangeExercisesFromService() {
    when(() => mockService.getExercises()).thenAnswer(
      (_) async => exercisesFromService,
    );
  }

  Widget _createTestWidget() {
    return ScreenUtilInit(
      builder: (_, __) => MaterialApp(
        theme: AppTheme().theme,
        title: AppTexts.appName,
        navigatorKey: NavigationUtil.navigatorKey,
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProvider<ExercisesViewModel>.value(
          value: ExercisesViewModel(service: mockService),
          child: Consumer<ExercisesViewModel>(
            builder: (context, vm, child) => ExercisesScreen().buildContent(context, vm),
          ),
        ),
        onGenerateRoute: NavigationUtil.onGenerateRoute,
      ),
    );
  }

  testWidgets("AddButton", (WidgetTester tester) async {
    arrangeExercisesFromService();
    await tester.pumpWidget(_createTestWidget());
    expect(find.byKey(Key('AddButton')), findsOneWidget);
  });

  testWidgets("exercise are displayed", (WidgetTester tester) async {
    arrangeExercisesFromService();

    await tester.pumpWidget(_createTestWidget());

    await tester.pump();

    for (final e in exercisesFromService) {
      expect(find.textContaining("${e.name}"), findsOneWidget);
      if (e.weight != null) expect(find.textContaining("${e.weight} * ${e.weightCount}"), findsOneWidget);
    }

    await tester.pumpAndSettle();
  });
}
