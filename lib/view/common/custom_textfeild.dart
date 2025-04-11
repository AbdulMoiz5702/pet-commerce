import 'package:flutter/material.dart';

import '../../core/constants/presentation/app_colors.dart';




class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool issuffixIcon;
  final Widget ? suffixicon;

  final FormFieldValidator validate;
  final bool isDense ;
  final int maxLine ;
  final Function(String) ? onChanged ;
  final VoidCallback ontap;
  const CustomTextField(
      {super.key, required this.controller,
      required this.hintText,
        this.issuffixIcon = false,
      this.keyboardType = TextInputType.text,
        this.suffixicon,
        this.ontap  = _emptyOnTap,
      required this.validate,
         this.obscureText = false ,
        this.isDense =false,
        this.onChanged,
        this.maxLine = 1
      });
  static void _emptyOnTap() {} // ✅ Empty function




  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      onTap: ontap,
      onChanged: onChanged,
      obscuringCharacter: '*',

      obscureText: obscureText,

      validator: validate,
      style: const TextStyle(color: AppColor.blackColor, fontWeight: FontWeight.bold,fontSize: 14),
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffix: issuffixIcon ? suffixicon : SizedBox.shrink(),

        isDense: isDense,
        hintText: hintText,
        hintStyle:  TextStyle(color: AppColor.blackColor.withOpacity(0.5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColor.blackColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColor.blackColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColor.errorColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColor.blackColor, width: 1),
        ),
      ),
    );
  }
}
