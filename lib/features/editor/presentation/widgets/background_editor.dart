import 'package:flutter/material.dart';

import '../../../../core/extensions/theme_ext.dart';
import '../../../../models/background_config.dart';
import 'color_picker_dialog.dart';

class BackgroundEditor extends StatelessWidget {
  final BackgroundConfig background;
  final ValueChanged<BackgroundConfig> onChanged;

  const BackgroundEditor({
    super.key,
    required this.background,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final isGradient = background.isGradient;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BACKGROUND',
          style: context.labelSmall(
            color: appColors?.subtext,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _ModeChip(
              label: 'Gradient',
              isSelected: isGradient,
              onTap: () {
                if (!isGradient) {
                  onChanged(const BackgroundConfig(
                    gradientColors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                  ));
                }
              },
              primaryColor: appColors?.primary,
              surfaceColor: appColors?.cardBg,
              onSurfaceColor: appColors?.onSurface,
            ),
            const SizedBox(width: 8),
            _ModeChip(
              label: 'Solid',
              isSelected: !isGradient,
              onTap: () {
                if (isGradient) {
                  onChanged(const BackgroundConfig(
                    solidColor: Color(0xFF1a1a2e),
                  ));
                }
              },
              primaryColor: appColors?.primary,
              surfaceColor: appColors?.cardBg,
              onSurfaceColor: appColors?.onSurface,
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (isGradient) _buildGradientEditor(context) else _buildSolidEditor(context),
      ],
    );
  }

  Widget _buildGradientEditor(BuildContext context) {
    final colors = background.gradientColors!;
    return Row(
      children: [
        Expanded(
          child: _ColorButton(
            label: 'Start',
            color: colors[0],
            onTap: () async {
              final color = await ColorPickerDialog.show(context, colors[0]);
              if (color != null) {
                onChanged(BackgroundConfig(
                  gradientColors: [color, colors[1]],
                ));
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(colors: colors),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ColorButton(
            label: 'End',
            color: colors[1],
            onTap: () async {
              final color = await ColorPickerDialog.show(context, colors[1]);
              if (color != null) {
                onChanged(BackgroundConfig(
                  gradientColors: [colors[0], color],
                ));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSolidEditor(BuildContext context) {
    final color = background.solidColor ?? const Color(0xFF1a1a2e);
    return _ColorButton(
      label: 'Color',
      color: color,
      onTap: () async {
        final picked = await ColorPickerDialog.show(context, color);
        if (picked != null) {
          onChanged(BackgroundConfig(solidColor: picked));
        }
      },
    );
  }
}

class _ModeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? primaryColor;
  final Color? surfaceColor;
  final Color? onSurfaceColor;

  const _ModeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.primaryColor,
    this.surfaceColor,
    this.onSurfaceColor,
  });

  @override
  Widget build(BuildContext context) {
    final primary = primaryColor ?? Colors.blue;
    return Material(
      color: isSelected
          ? primary.withValues(alpha: 0.15)
          : surfaceColor ?? Colors.grey[200],
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? primary : Colors.transparent,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected
                  ? primary
                  : onSurfaceColor?.withValues(alpha: 0.7),
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ColorButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.appColors?.contentBorder?.withValues(alpha: 0.2) ??
                Colors.grey,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.white24),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: context.appColors?.onSurface?.withValues(alpha: 0.7),
                ),
              ),
            ),
            Icon(
              Icons.edit,
              size: 14,
              color: context.appColors?.subtext,
            ),
          ],
        ),
      ),
    );
  }
}
