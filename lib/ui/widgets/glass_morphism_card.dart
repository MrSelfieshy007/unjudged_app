import 'dart:ui';
import 'package:flutter/material.dart';

class GlassMorphismCard extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final BorderRadius borderRadius;
  final Color color;
  final double blur;
  final double borderWidth;
  final Color borderColor;
  final EdgeInsetsGeometry? padding;

  const GlassMorphismCard({
    Key? key,
    required this.child,
    this.height,
    this.width,
    required this.borderRadius,
    this.color = Colors.transparent,
    this.blur = 15.0,
    this.borderWidth = 1.0,
    this.borderColor = Colors.white24,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          height: height,
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
            border: Border.all(
              width: borderWidth,
              color: borderColor,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
