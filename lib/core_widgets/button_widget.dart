import 'package:fitness_app/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../base/constants/app_constats.dart';

class ButtonWidget extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? textSize;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final bool isEnabled;
  final VoidCallback? onPressed;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.isEnabled = true,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bgColor = !isEnabled ? AppColors.grey : backgroundColor ?? AppColors.primary;
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppSpacing.spacingMedium.h),
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(4.r),
        child: InkWell(
          onTap: isEnabled ? onPressed : () {},
          borderRadius: BorderRadius.circular(4.r),
          child: Container(
            decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(4.r)),
            height: height ?? AppSizes.buttonDefaultHeight,
            width: width,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacingMedium.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text!, style: textStyle ?? context.textTheme.button?.copyWith(color: textColor ?? AppColors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
