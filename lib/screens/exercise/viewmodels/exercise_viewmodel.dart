import 'dart:async';
import 'package:flutter_project_base/flutter_project_base.dart';
import '../../../domain/exercise_model.dart';
import '../exercise_service.dart';

class ExerciseViewModel extends BaseViewModel {
  final ExerciseService service;
  final ExerciseModel? exercise;
  ExerciseViewModel({required this.service, this.exercise});

  String? errorMessage;

  @override
  FutureOr<void> init() async {}

  Future<bool> saveExercise() async {
    isLoading = true;
    var isSaved = await service.saveExercise(exercise); //todo update exercise with given
    if (!isSaved) errorMessage = "Not Saved";
    isLoading = false;
    return isSaved;
  }
}
