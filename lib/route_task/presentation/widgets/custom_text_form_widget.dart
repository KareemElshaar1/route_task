import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_text_style.dart';

typedef Validator = String? Function(String?);

class CustomTextFormFieldWidget extends StatefulWidget {
  TextInputType keyboardType;

  TextEditingController controller;
  Validator myValidator;
  void Function(String)? onChanged;

  CustomTextFormFieldWidget({
    this.keyboardType = TextInputType.text,
    required this.controller,
    required this.myValidator,
    required this.onChanged,
  });

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryColor,
      ),
      onChanged: widget.onChanged,
      cursorColor: AppColors.blueColor,
      decoration: InputDecoration(
        // fillColor: AppColors.mobileSearchColor,
        // filled: true,
        hintText: "What do you Search for?",

        hintStyle: AppTextStyle.textStyle16.copyWith(
          color: Colors.grey.shade500,
        ),

        prefixIcon: IconButton(
          onPressed: null,
          icon: SvgPicture.asset(
            "assets/icons/icon-search.svg",
            height: 30.h,
            width: 30.w,
            fit: BoxFit.fill,
          ),
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
        enabledBorder: _outLineInputBorder(color: AppColors.primaryColor),
        focusedBorder: _outLineInputBorder(color: AppColors.primaryColor),
        errorBorder: _outLineInputBorder(color: AppColors.redColor),
      ),
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: widget.myValidator,
    );
  }

  OutlineInputBorder _outLineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.r),
      borderSide: BorderSide(
        width: 1.5.w,
        color: color,
      ),
    );
  }
}
