
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/AppColor.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final int? maxLine;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool showBorder;
  final double borderRadius;
  final Color? fillColor;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.maxLine = 1,
    this.showBorder = true,
    this.borderRadius = 16,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: Colors.grey.shade300,
        width: 1,
      ),
    );

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: '*',
      maxLines: obscureText ? 1 : maxLine,
      validator: validator,
      style: GoogleFonts.inter(
        fontSize: 14,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          fontSize: 13,
          color: Colors.grey.shade500,
          fontWeight: FontWeight.w400,
        ),

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        filled: true,
        fillColor: fillColor ?? AppColors.background,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),

        border: border,
        enabledBorder: showBorder
            ? border
            : border.copyWith(
          borderSide: BorderSide.none,
        ),
        focusedBorder: border.copyWith(
          borderSide: BorderSide(
            color: Colors.brown.shade400,
            width: 1.3,
          ),
        ),
        errorBorder: border.copyWith(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
        ),
      ),
    );
  }
}
