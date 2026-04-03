import 'package:flutter/material.dart';
import '../../core/extensions/theme_ext.dart';

class GenericButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double width;
  final double height;
  final double borderRadius;
  final bool isLoading;
  final IconData? icon;

  const GenericButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.width = double.infinity,
    this.height = 56,
    this.borderRadius = 16,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final primary = backgroundColor ?? colors?.primary ?? Colors.green;
    final onPrimary = foregroundColor ?? Colors.white;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style:
            ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: onPrimary,
              elevation: 0,
              shadowColor: primary.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ).copyWith(
              shadowColor: WidgetStateProperty.all(
                primary.withValues(alpha: 0.3),
              ),
              elevation: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.hovered) && !isLoading) {
                  return 8;
                }
                return 0;
              }),
            ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(onPrimary),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: context
                        .labelLarge(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: onPrimary,
                        )
                        .copyWith(letterSpacing: 0.5),
                  ),
                  if (icon != null) ...[
                    const SizedBox(width: 8),
                    Icon(icon, color: onPrimary, size: 20),
                  ],
                ],
              ),
      ),
    );
  }
}
