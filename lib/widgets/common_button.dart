import 'package:aqua_flow/utils/constants.dart';
import 'package:flutter/material.dart';
// import 'your_color_constants_file.dart';  // <-- Make sure ColorConstants is imported

class CommonButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final bool isTransparent;
  final bool isEnabled;
  final Color? bgColor;
  final Color? borderColor;
  final Color textColor;
  final Widget? icon;
  final Widget? trailingIcon;
  final double fontSize;
  final bool isLoading;
  final double horizontalPadding, verticalPadding;
  final double borderRadius;
  final FontWeight textWeight;
  final Color? buttonShade;
  final Color? shadowColor;
  final String? fontFamily;

  const CommonButton({
    super.key,
    required this.title,
    this.onPressed,
    this.isTransparent = false,
    this.bgColor,
    this.borderColor,
    this.textColor = Colors.white,
    this.icon,
    this.trailingIcon,
    this.horizontalPadding = 0,
    this.verticalPadding = 10,
    this.fontSize = 14,
    this.isEnabled = true,
    this.isLoading = false,
    this.borderRadius = 8.0,
    this.textWeight = FontWeight.w600,
    this.buttonShade,
    this.shadowColor,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {

    /// ✅ Default background & border logic
    final Color defaultButtonColor = ColorConstants.buttoncolor;
    final Color buttonBgColor = bgColor ?? defaultButtonColor;
    final Color buttonBorderColor = borderColor ?? defaultButtonColor;

    /// ✅ Shadow only applied if shadowColor is passed
    final bool applyShadow = shadowColor != null;

    return InkWell(
      onTap: isLoading || !isEnabled ? null : onPressed,
      child: Container(
        width: horizontalPadding > 0 ? null : double.infinity,
        padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
        decoration: BoxDecoration(
          color: !isEnabled
              ? Colors.grey[300]
              : isTransparent
                  ? Colors.transparent
                  : buttonBgColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: !isEnabled ? Colors.grey : buttonBorderColor,
            width: 1.5,
          ),
          boxShadow: applyShadow
              ? [
                  BoxShadow(
                    color: shadowColor!.withOpacity(0.4),
                    offset: const Offset(0, 4),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: isLoading
            ? const Center(
                child: SizedBox(
                  width: 21,
                  height: 21,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 5),
                  ],
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: isTransparent ? textColor : textColor,
                      fontWeight: textWeight,
                      fontFamily: fontFamily ?? 'Poppins',
                    ),
                  ),
                  if (trailingIcon != null) ...[
                    const SizedBox(width: 10),
                    trailingIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
