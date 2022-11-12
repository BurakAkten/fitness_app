import 'package:fitness_app/domain/enums/exercise_type.dart';
import 'package:fitness_app/screens/exercise/viewmodels/exercise_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../base/constants/app_texts.dart';
import '../../../core_widgets/dropdown_widget.dart';
import '../../../core_widgets/text_field_widget.dart';

class FormView extends StatelessWidget {
  const FormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<ExerciseViewModel>(context);
    return Column(
      children: [
        DropdownWidget<ExerciseType>(
          items: ExerciseType.values,
          value: vm.selectedExerciseType,
          labelText: "${AppTexts.selectExercise}*",
          textBuilder: (e) => "${e.value}",
          onChanged: (value) {
            vm.selectedExerciseType = value;
          },
        ),
        TextFieldWidget(
          titleText: "${AppTexts.setsCount}*",
          keyboardType: TextInputType.number,
          initialValue: vm.setsCount != null ? "${vm.setsCount}" : null,
          onChanged: (value) {
            vm.setsCount = int.tryParse(value);
          },
        ),
        TextFieldWidget(
          titleText: "${AppTexts.setsRepetition}*",
          keyboardType: TextInputType.number,
          initialValue: vm.setsRepetition != null ? "${vm.setsRepetition}" : null,
          onChanged: (value) {
            vm.setsRepetition = int.tryParse(value);
          },
        ),
        DropdownWidget<double>(
          items: vm.weights,
          value: vm.weight,
          labelText: AppTexts.selectWeight,
          textBuilder: (w) => "$w Kg",
          onChanged: (value) {
            vm.weight = value;
          },
        ),
        if (vm.weight != null && vm.weight! > 0.0)
          TextFieldWidget(
            titleText: "${AppTexts.weightCount}*",
            keyboardType: TextInputType.number,
            initialValue: vm.weightCount != null ? "${vm.weightCount}" : null,
            onChanged: (value) {
              vm.weightCount = int.tryParse(value);
            },
          ),
      ],
    );
  }
}
