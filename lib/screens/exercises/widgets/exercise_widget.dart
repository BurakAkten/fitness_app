import 'package:fitness_app/base/constants/app_texts.dart';
import 'package:fitness_app/screens/exercises/viewmodels/exercises_viewmodel.dart';
import 'package:fitness_app/utils/extensions/context_extension.dart';
import 'package:fitness_app/utils/navigation_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../base/constants/app_constats.dart';
import '../../../core_widgets/button_widget.dart';
import '../../../domain/models/exercise_model.dart';

class ExerciseWidget extends StatelessWidget {
  final ExerciseModel exercise;
  const ExerciseWidget({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<ExercisesViewModel>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
        side: BorderSide(color: AppColors.grey),
      ),
      margin: EdgeInsets.only(bottom: AppSpacing.spacingMedium.h),
      color: AppColors.white,
      elevation: 4,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: AppSpacing.spacingMedium.h, horizontal: AppSpacing.spacingMedium.w),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                var result = await NavigationUtil.navigateToExerciseScreen(context, arguments: exercise);
                Fluttertoast.showToast(
                  msg: result ? AppTexts.exerciseSaved : AppTexts.sthWentWrong,
                  backgroundColor: result ? AppColors.primary : Colors.red,
                  textColor: AppColors.white,
                  timeInSecForIosWeb: 3,
                );
                if (result) vm.setExercises();
              },
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRow(context, AppTexts.exerciseName, exercise.name ?? "-"),
                        _buildRow(context, AppTexts.setsCount, "${exercise.setCount ?? "-"}"),
                        _buildRow(context, AppTexts.setsRepetition, "${exercise.setRepeat ?? "-"}"),
                        _buildRow(context, AppTexts.weight, "${exercise.weight ?? "-"} * ${exercise.weightCount ?? "-"}"),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_right,
                    size: AppSizes.rightIconSize,
                    color: AppColors.primary.withOpacity(0.8),
                  )
                ],
              ),
            ),
            ButtonWidget(
              backgroundColor: Colors.red.withOpacity(0.7),
              height: 30.h,
              text: AppTexts.delete,
              onPressed: () async {
                await vm.delete(exercise);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String title, String value) => Container(
        margin: EdgeInsets.symmetric(vertical: AppSpacing.spacingXSmall.h),
        child: Text.rich(
          TextSpan(
            text: "$title: ",
            style: context.textTheme.bodyText1,
            children: [
              TextSpan(
                text: value,
                style: context.textTheme.bodyText1?.copyWith(fontWeight: AppFontUtils.bold, fontSize: AppFontUtils.button),
              )
            ],
          ),
        ),
      );
}
