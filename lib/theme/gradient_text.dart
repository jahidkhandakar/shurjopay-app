import 'package:flutter/material.dart';
import 'app_theme.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final TextAlign? textAlign;

  const GradientText(
    this.text, {
    this.style,
    this.gradient = AppTheme.primaryGradient,
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: (style ?? const TextStyle()).copyWith(
        foreground: Paint()
          ..shader = gradient.createShader(
            const Rect.fromLTWH(0, 0, 200, 70), // adjust size as needed
          ),
      ),
    );
  }
}
