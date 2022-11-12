import 'package:fitness_app/base/constants/app_constats.dart';
import 'package:fitness_app/screens/exercises/viewmodels/exercises_viewmodel.dart';
import 'package:fitness_app/screens/exercises/widgets/exercise_widget.dart';
import 'package:fitness_app/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_base/flutter_project_base.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../base/constants/app_texts.dart';
import '../../core_widgets/button_widget.dart';
import 'exercises_service.dart';
import 'package:fitness_app/utils/extensions/context_extension.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ExercisesViewModel>(
      vmBuilder: (context) => ExercisesViewModel(service: ExercisesService()),
      builder: _buildContent,
    );
  }

  Widget _buildContent(BuildContext context, ExercisesViewModel vm) => Scaffold(
        appBar: AppBar(title: const Text(AppTexts.exercises)),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.spacingSmall.h, horizontal: AppSpacing.spacingMedium.w),
          child: vm.errorMessage != null
              ? Center(child: Text(vm.errorMessage!, style: context.textTheme.bodyText1))
              : Column(
                  children: [
                    ButtonWidget(
                      text: AppTexts.addExercise,
                      onPressed: () async {
                        var result = await NavigationUtil.navigateToExerciseScreen(context);
                        Fluttertoast.showToast(
                          msg: result ? AppTexts.exerciseSaved : AppTexts.sthWentWrong,
                          backgroundColor: result ? AppColors.primary : Colors.red,
                          textColor: AppColors.white,
                          timeInSecForIosWeb: 3,
                        );
                        if (result) vm.setExercises();
                      },
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: vm.exercises.map((e) => ExerciseWidget(exercise: e)).toList(),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      );
}
