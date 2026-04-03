import 'package:flutter/material.dart';
import '../../../../core/extensions/theme_ext.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: appColors?.primary?.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: appColors?.primary?.withValues(alpha: 0.3) ?? Colors.blue,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    appColors?.primary?.withValues(alpha: 0.3) ?? Colors.blue,
                blurRadius: 15,
                spreadRadius: -3,
              ),
            ],
          ),
          child: Icon(Icons.terminal, color: appColors?.primary, size: 32),
        ),
        const SizedBox(height: 16),
        Text(
          "easy_init_cli",
          style: context
              .headlineSmall(fontWeight: FontWeight.bold)
              .copyWith(letterSpacing: -0.5),
        ),
        const SizedBox(height: 4),
        Text(
          "PROJECT INITIALIZATION",
          style: context
              .labelSmall(
                color:
                    appColors?.primary?.withValues(alpha: 0.6) ?? Colors.grey,
                fontWeight: FontWeight.w500,
              )
              .copyWith(letterSpacing: 1.5),
        ),
      ],
    );
  }
}
