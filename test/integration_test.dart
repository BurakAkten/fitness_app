import 'package:fitness_app/base/constants/app_texts.dart';
import 'package:fitness_app/base/constants/app_theme.dart';
import 'package:fitness_app/domain/models/exercise_model.dart';
import 'package:fitness_app/screens/exercise/exercise_screen.dart';
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

  testWidgets("tab add button", (WidgetTester tester) async {
    arrangeExercisesFromService();
    await tester.pumpWidget(_createTestWidget());
    await tester.tap(find.byKey(Key('AddButton')));

    await tester.pumpAndSettle();

    expect(find.byType(ExerciseScreen), findsOneWidget);
    expect(find.byType(ExercisesScreen), findsNothing);

    expect(find.text('Save'), findsOneWidget);
    expect(find.textContaining('Select Exercise'), findsOneWidget);
  });

  testWidgets("tab exercise item, open exercise edit screen", (WidgetTester tester) async {
    arrangeExercisesFromService();
    await tester.pumpWidget(_createTestWidget());
    await tester.tap(find.byType(InkWell));

    await tester.pumpAndSettle();

    expect(find.byType(ExerciseScreen), findsOneWidget);
    expect(find.byType(ExercisesScreen), findsNothing);

    expect(find.text('Save'), findsOneWidget);
    expect(find.textContaining(exercisesFromService.first.setRepeat!.toString(), findRichText: true), findsOneWidget);
  });

  testWidgets("tab exercise delete", (WidgetTester tester) async {
    arrangeExercisesFromService();
    await tester.pumpWidget(_createTestWidget());

    await tester.pumpAndSettle();

    expect(find.textContaining(exercisesFromService.first.name!.toString(), findRichText: true), findsOneWidget);

    await tester.tap(find.textContaining("Delete"));

    await tester.pumpAndSettle();

    expect(find.textContaining(exercisesFromService.first.name!.toString(), findRichText: true), findsNothing);
  });
}
