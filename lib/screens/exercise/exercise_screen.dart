import 'package:fitness_app/base/constants/app_constats.dart';
import 'package:fitness_app/screens/exercise/exercise_service.dart';
import 'package:fitness_app/screens/exercise/viewmodels/exercise_viewmodel.dart';
import 'package:fitness_app/screens/exercise/views/form_view.dart';
import 'package:fitness_app/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_base/flutter_project_base.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../base/constants/app_texts.dart';
import '../../core_widgets/button_widget.dart';
import '../../domain/models/exercise_model.dart';

class ExerciseScreen extends StatelessWidget {
  final ExerciseModel? exercise;
  const ExerciseScreen({Key? key, this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.exercise)),
      body: BaseView<ExerciseViewModel>(
        vmBuilder: (context) => ExerciseViewModel(service: ExerciseService(), exercise: exercise),
        builder: _buildContent,
      ),
    );
  }

  Widget _buildContent(context, ExerciseViewModel vm) => SingleChildScrollView(
        child: IgnorePointer(
          ignoring: vm.isLoading,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.spacingMedium.h, horizontal: AppSpacing.spacingMedium.w),
            child: Column(
              children: [
                FormView(),
                ButtonWidget(
                  isEnabled: vm.isButtonEnabled,
                  text: AppTexts.save,
                  onPressed: () async {
                    var result = await vm.saveExercise();
                    NavigationUtil.navigateToBack(context, value: result);
                  },
                )
              ],
            ),
          ),
        ),
      );
}
