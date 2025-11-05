import 'package:flutter/material.dart';
import 'package:shurjopay2/theme/app_theme.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;

  const CustomText({
    super.key,
    required this.text,
    required this.textAlign,
    required this.fontSize,
    required this.fontWeight,
    required this.letterSpacing,
    });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
            shaderCallback:
                (Rect bounds) => AppTheme.primaryGradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
            blendMode: BlendMode.srcIn,
            child:Text(
              text,
              textAlign: textAlign,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: Colors.white,
                letterSpacing: letterSpacing
              ),
            ),
        );
  }
}