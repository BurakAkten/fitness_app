import 'package:fitness_app/domain/models/exercise_model.dart';
import 'package:fitness_app/screens/exercises/exercises_service.dart';
import 'package:fitness_app/screens/exercises/viewmodels/exercises_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockService extends Mock implements ExercisesService {}

void main() {
  late MockService mockService;
  late ExercisesViewModel viewModel;

  setUp(() {
    mockService = MockService();
    viewModel = ExercisesViewModel(service: mockService);
  });

  group('getExercises', () {
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

    test(
      "setExercises using the ExercisesService",
      () async {
        arrangeExercisesFromService();
        verify(() => mockService.getExercises()).called(1);
      },
    );

    test(
      "say loading before getting exercise then say not loading, then control item fields",
      () async {
        arrangeExercisesFromService();
        final result = viewModel.setExercises();
        expect(viewModel.isLoading, true);
        await result;
        expect(viewModel.exercises, exercisesFromService);
        expect(viewModel.isLoading, false);

        expect(viewModel.exercises.first.id != null, true);
        expect(viewModel.exercises.first.name, "BarBell Row");
      },
    );

    test(
      "say loading before getting exercise then say not loading, then control item fields",
      () async {
        arrangeExercisesFromService();
        await viewModel.setExercises();
        expect(viewModel.exercises, exercisesFromService);

        var result = await viewModel.delete(viewModel.exercises.first);
        if (result) {
          await viewModel.setExercises();
          expect(viewModel.exercises.first.name, "Squat");
        }
      },
    );
  });
}
