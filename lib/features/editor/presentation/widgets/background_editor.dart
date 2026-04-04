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
                  onChanged(
                    const BackgroundConfig(
                      gradientColors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    ),
                  );
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
                  onChanged(
                    const BackgroundConfig(solidColor: Color(0xFF1a1a2e)),
                  );
                }
              },
              primaryColor: appColors?.primary,
              surfaceColor: appColors?.cardBg,
              onSurfaceColor: appColors?.onSurface,
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (isGradient)
          _buildGradientEditor(context)
        else
          _buildSolidEditor(context),
      ],
    );
  }

  Widget _buildGradientEditor(BuildContext context) {
    final colors = background.gradientColors!;
    final borderColor =
        context.appColors?.contentBorder?.withValues(alpha: 0.2) ?? Colors.grey;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _GradientStopTile(
                  label: 'Start',
                  color: colors[0],
                  borderColor: borderColor,
                  onTap: () async {
                    final color = await ColorPickerDialog.show(
                      context,
                      colors[0],
                    );
                    if (color != null) {
                      onChanged(
                        BackgroundConfig(gradientColors: [color, colors[1]]),
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                _GradientStopTile(
                  label: 'End',
                  color: colors[1],
                  borderColor: borderColor,
                  onTap: () async {
                    final color = await ColorPickerDialog.show(
                      context,
                      colors[1],
                    );
                    if (color != null) {
                      onChanged(
                        BackgroundConfig(gradientColors: [colors[0], color]),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: colors,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const SizedBox(width: 36),
          ),
        ],
      ),
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

class _GradientStopTile extends StatelessWidget {
  final String label;
  final Color color;
  final Color borderColor;
  final VoidCallback onTap;

  const _GradientStopTile({
    required this.label,
    required this.color,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final onSurface = appColors?.onSurface?.withValues(alpha: 0.75);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 80,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ],
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
            color:
                context.appColors?.contentBorder?.withValues(alpha: 0.2) ??
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
            Icon(Icons.edit, size: 14, color: context.appColors?.subtext),
          ],
        ),
      ),
    );
  }
}
