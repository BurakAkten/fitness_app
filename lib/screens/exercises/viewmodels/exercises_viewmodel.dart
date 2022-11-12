import 'dart:async';
import 'package:flutter_project_base/flutter_project_base.dart';
import '../../../domain/exercise_model.dart';
import '../exercises_service.dart';

class ExercisesViewModel extends BaseViewModel {
  final ExercisesService service;
  ExercisesViewModel({required this.service});

  List<ExerciseModel> exercises = [];

  @override
  FutureOr<void> init() async {
    await _setExercises();
  }

  Future<void> _setExercises() async {
    isLoading = true;
    exercises = await service.getExercises();
    isLoading = false;
  }
}
