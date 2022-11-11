import 'package:fitness_app/base/constants/app_constats.dart';
import 'package:fitness_app/screens/exercises/viewmodels/exercise_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_base/flutter_project_base.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../base/constants/app_texts.dart';
import 'exercise_service.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.exercise),
      ),
      body: BaseView<ExercisesViewModel>(
        vmBuilder: (context) => ExercisesViewModel(service: ExercisesService()),
        builder: _buildContent,
      ),
    );
  }

  Widget _buildContent(context, vm) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.spacingMedium.h, horizontal: AppSpacing.spacingMedium.w),
          child: Column(
            children: const [],
          ),
        ),
      );
}
