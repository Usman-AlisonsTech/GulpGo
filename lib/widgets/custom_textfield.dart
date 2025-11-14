import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final double? padding;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? lines;
  final bool forceBorder;
  final double? borderRadius;
  final bool obscureText;
  final bool readOnly;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Color? borderColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final double? hintTextPadding;
  final double? leftPadding;
  final double? borderWidth;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.initialValue,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.padding,
    this.keyboardType,
    this.inputFormatters, 
    this.lines = 1,
    this.obscureText = false,
    this.forceBorder = false,
    this.readOnly = false,
    this.validator,
    this.onChanged,
    this.borderRadius,
    this.borderColor,
    this.contentPadding,
    this.hintStyle,
    this.hintTextPadding,
    this.leftPadding,
    this.borderWidth,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: lines,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      readOnly: readOnly,
      initialValue: initialValue,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: const TextStyle(
          color: Color(0xff72777A),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        filled: fillColor != null,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding ??
            EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: leftPadding ?? 25,
              right: 20,
            ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 24,
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 24,
        ),
        hintStyle: hintStyle ?? const TextStyle(color: Color(0xff9DA3AE), fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
        enabledBorder: border(),
        focusedBorder: border(),
        errorBorder: errorBorder(),
        focusedErrorBorder: errorBorder(),
      ),
    );
  }

  OutlineInputBorder border() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius ?? 5),
    borderSide: BorderSide(
      color: borderColor ?? Colors.black,
      width: borderWidth ??1.2 ,
    ),
  );
}

OutlineInputBorder errorBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: Colors.red[900]!,
      width: borderWidth ?? 0,
    ),
  );
}
}
