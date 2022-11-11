import 'dart:async';
import 'package:flutter_project_base/flutter_project_base.dart';
import '../exercise_service.dart';

class ExercisesViewModel extends BaseViewModel {
  final ExercisesService service;
  ExercisesViewModel({required this.service});

  @override
  FutureOr<void> init() async {}
}
