import 'package:fitness_app/base/constants/app_constats.dart';
import 'package:fitness_app/base/constants/app_texts.dart';
import 'package:fitness_app/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownWidget<T> extends StatelessWidget {
  final List<T?> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final Function(T)? textBuilder;
  final String? labelText;

  DropdownWidget({
    Key? key,
    required this.items,
    required this.onChanged,
    this.textBuilder,
    this.value,
    required this.labelText,
  })  : assert(items.isEmpty || value == null || items.where((T? item) => item == value).length == 1),
        super(key: key);

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText!, style: context.textTheme.headline1),
        SizedBox(height: AppSpacing.spacingSmall.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.spacingXSmall.h, horizontal: AppSpacing.spacingMedium.w),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), border: Border.all(color: AppColors.primary)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isExpanded: true,
              items: items
                  .map(
                    (item) => DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        item == null ? AppTexts.choose : textBuilder!(item),
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.button,
                      ),
                    ),
                  )
                  .toList(),
              value: value,
              onChanged: onChanged,
              hint: Text(AppTexts.choose, style: context.textTheme.caption),
            ),
          ),
        )
      ],
    );
  }
}
