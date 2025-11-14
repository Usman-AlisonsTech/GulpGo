import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? weight;
  final Color? color;
  final int? lines;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextOverflow? textOverflow;
  final TextDecoration? decoration;
  final double decorationThickness;
  final TextDecorationStyle? decorationStyle; 
  final Color? decorationColor;
  final double? letterSpacing; // Added
  final double? lineSpacing;   // Added (maps to height in TextStyle)

  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 15,
    this.weight,
    this.color,
    this.lines,
    this.fontStyle,
    this.textOverflow,
    this.textAlign,
    this.decoration = TextDecoration.none,
    this.decorationThickness = 1.0,
    this.decorationStyle = TextDecorationStyle.solid, 
    this.decorationColor,
    this.letterSpacing, // default null (keeps normal spacing)
    this.lineSpacing,   // default null (keeps normal line height)
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: lines,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: weight?? FontWeight.w500,
        fontStyle: fontStyle,
        overflow: textOverflow,
        fontFamily: 'Poppins',
        decoration: decoration,
        decorationThickness: decorationThickness, 
        decorationStyle: decorationStyle ?? TextDecorationStyle.solid, 
        decorationColor: decorationColor ?? color,
        letterSpacing: letterSpacing?? 0, // applied here
        height: lineSpacing,          // applied here
      ),
    );
  }
}
