import 'package:fitness_app/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../base/constants/app_constats.dart';

class TextFieldWidget extends StatefulWidget {
  final String? titleText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final Function? onChanged;

  const TextFieldWidget({
    Key? key,
    this.titleText,
    this.initialValue,
    this.keyboardType,
    this.onChanged,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    textEditingController.text = widget.initialValue ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppSpacing.spacingMedium.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.titleText != null) ...{
            Text(widget.titleText!, style: context.textTheme.headline1),
            SizedBox(height: AppSpacing.spacingSmall.h),
          },
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), border: Border.all(color: AppColors.primary)),
            child: TextField(
              controller: textEditingController,
              keyboardType: widget.keyboardType,
              onChanged: (text) {
                if (widget.onChanged != null) widget.onChanged!(text);
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: widget.titleText ?? "",
                hintStyle: context.textTheme.caption,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.r)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
