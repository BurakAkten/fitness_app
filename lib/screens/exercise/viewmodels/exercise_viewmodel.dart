import 'dart:async';
import 'package:fitness_app/domain/enums/exercise_type.dart';
import 'package:flutter_project_base/flutter_project_base.dart';
import '../../../domain/models/exercise_model.dart';
import '../exercise_service.dart';

class ExerciseViewModel extends BaseViewModel {
  final List<double> weights = [3, 5, 10, 12.5, 15, 15.5, 20];
  final ExerciseService service;
  final ExerciseModel? exercise;
  ExerciseViewModel({required this.service, this.exercise});

  String? errorMessage;

  ExerciseType? _selectedExerciseType;
  int? _setsCount;
  int? _setsRepetition;
  double? _weight;
  int? _weightCount;

  @override
  FutureOr<void> init() async {
    if (exercise != null) {
      selectedExerciseType = ExerciseType.values.firstWhere((e) => e.value == exercise!.name);
      setsCount = exercise!.setCount;
      setsRepetition = exercise!.setRepeat;
      weight = exercise!.weight;
      weightCount = exercise!.weightCount;
    }
  }

  Future<bool> saveExercise() async {
    isLoading = true;
    var isSaved = await service.saveExercise(exerciseModel..id = exercise?.id);
    if (!isSaved) errorMessage = "Not Saved";
    isLoading = false;
    return isSaved;
  }

  //Getters
  ExerciseType? get selectedExerciseType => _selectedExerciseType;
  int? get setsCount => _setsCount;
  int? get setsRepetition => _setsRepetition;
  double? get weight => _weight;
  int? get weightCount => _weightCount;
  bool get isButtonEnabled =>
      setsCount != null &&
      setsRepetition != null &&
      selectedExerciseType != null &&
      (weight != null || (weight != null && weight! > 0.0) ? (weightCount != null && weightCount! > 0) : true) &&
      !(exercise == exerciseModel);
  ExerciseModel get exerciseModel => ExerciseModel(
        weight: weight,
        weightCount: weightCount,
        name: selectedExerciseType?.value,
        setCount: setsCount,
        setRepeat: setsRepetition,
      );

  //Setters
  set selectedExerciseType(ExerciseType? value) {
    _selectedExerciseType = value;
    reloadState();
  }

  set setsCount(int? value) {
    _setsCount = value;
    reloadState();
  }

  set setsRepetition(int? value) {
    _setsRepetition = value;
    reloadState();
  }

  set weight(double? value) {
    _weight = value;
    reloadState();
  }

  set weightCount(int? value) {
    _weightCount = value;
    reloadState();
  }
}
