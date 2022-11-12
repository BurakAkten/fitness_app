import 'dart:async';
import 'package:flutter_project_base/flutter_project_base.dart';
import '../../../domain/models/exercise_model.dart';
import '../exercises_service.dart';

class ExercisesViewModel extends BaseViewModel {
  final ExercisesService service;
  ExercisesViewModel({required this.service});

  List<ExerciseModel> exercises = [];

  String? errorMessage;

  @override
  FutureOr<void> init() async {
    await setExercises();
  }

  Future<void> setExercises() async {
    errorMessage = null;
    isLoading = true;
    try {
      exercises = await service.getExercises();
      reloadState();
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
  }

  Future<bool> delete(ExerciseModel model) async {
    var result = false;
    errorMessage = null;
    isLoading = true;
    try {
      result = await service.deleteExercise(model);
      if (result) exercises.removeWhere((element) => element.id == model.id);
      reloadState();
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    return result;
  }
}
