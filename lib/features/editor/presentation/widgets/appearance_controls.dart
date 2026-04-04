import 'package:flutter/material.dart';

import '../../../../common/widgets/device_frame.dart';
import '../../../../core/extensions/theme_ext.dart';
import 'color_picker_dialog.dart';

class AppearanceControls extends StatelessWidget {
  final double textScale;
  final bool showDeviceFrame;
  final DeviceFrameStyle deviceFrameStyle;
  final double imageSizeRatio;
  final Color textColor;
  final ValueChanged<double> onTextScaleChanged;
  final ValueChanged<bool> onDeviceFrameToggled;
  final ValueChanged<double> onImageSizeRatioChanged;
  final ValueChanged<Color> onTextColorChanged;

  const AppearanceControls({
    super.key,
    required this.textScale,
    required this.showDeviceFrame,
    required this.deviceFrameStyle,
    required this.imageSizeRatio,
    required this.textColor,
    required this.onTextScaleChanged,
    required this.onDeviceFrameToggled,
    required this.onImageSizeRatioChanged,
    required this.onTextColorChanged,
  });

  static const _textPresetColors = [
    Colors.white,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final primary = appColors?.primary ?? Colors.blue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'APPEARANCE',
          style: context.labelSmall(
            color: appColors?.subtext,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),

        _buildTextColorSection(context, appColors, primary),
        const SizedBox(height: 12),

        _buildSliderRow(
          context: context,
          label: 'Text Size',
          value: textScale,
          valueLabel: '${(textScale * 100).round()}%',
          min: 0.5,
          max: 2.0,
          divisions: 15,
          iconStart: Icons.text_decrease,
          iconEnd: Icons.text_increase,
          primary: primary,
          appColors: appColors,
          onChanged: onTextScaleChanged,
        ),
        const SizedBox(height: 12),

        _buildSliderRow(
          context: context,
          label: 'Image Size',
          value: imageSizeRatio,
          valueLabel: '${(imageSizeRatio * 100).round()}%',
          min: 0.4,
          max: 0.95,
          divisions: 11,
          iconStart: Icons.photo_size_select_small,
          iconEnd: Icons.photo_size_select_large,
          primary: primary,
          appColors: appColors,
          onChanged: onImageSizeRatioChanged,
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: Text(
                'Device Frame',
                style: TextStyle(
                  fontSize: 12,
                  color: appColors?.onSurface?.withValues(alpha: 0.7),
                ),
              ),
            ),
            if (showDeviceFrame)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  deviceFrameStyle.displayName,
                  style: TextStyle(
                    fontSize: 10,
                    color: primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            SizedBox(
              height: 24,
              child: Switch.adaptive(
                value: showDeviceFrame,
                onChanged: onDeviceFrameToggled,
                activeTrackColor: primary,
                activeThumbColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextColorSection(
    BuildContext context,
    dynamic appColors,
    Color primary,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Text Color',
              style: TextStyle(
                fontSize: 12,
                color: appColors?.onSurface?.withValues(alpha: 0.7),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                final color =
                    await ColorPickerDialog.show(context, textColor);
                if (color != null) onTextColorChanged(color);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.palette, size: 12, color: primary),
                    const SizedBox(width: 4),
                    Text(
                      'Custom',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: _textPresetColors.map((color) {
            final isSelected =
                color.toARGB32() == textColor.toARGB32();
            return _ColorCircle(
              color: color,
              isSelected: isSelected,
              primary: primary,
              borderColor:
                  appColors?.contentBorder?.withValues(alpha: 0.3) ??
                      Colors.grey,
              onTap: () => onTextColorChanged(color),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSliderRow({
    required BuildContext context,
    required String label,
    required double value,
    required String valueLabel,
    required double min,
    required double max,
    required int divisions,
    required IconData iconStart,
    required IconData iconEnd,
    required Color primary,
    required dynamic appColors,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: appColors?.onSurface?.withValues(alpha: 0.7),
              ),
            ),
            const Spacer(),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                valueLabel,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(iconStart, size: 14, color: appColors?.subtext),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: 3,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 7),
                  activeTrackColor: primary,
                  inactiveTrackColor: primary.withValues(alpha: 0.15),
                  thumbColor: primary,
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 14),
                ),
                child: Slider(
                  value: value,
                  min: min,
                  max: max,
                  divisions: divisions,
                  onChanged: onChanged,
                ),
              ),
            ),
            Icon(iconEnd, size: 14, color: appColors?.subtext),
          ],
        ),
      ],
    );
  }
}

class _ColorCircle extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final Color primary;
  final Color borderColor;
  final VoidCallback onTap;

  const _ColorCircle({
    required this.color,
    required this.isSelected,
    required this.primary,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? primary : borderColor,
            width: isSelected ? 2.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.4),
                    blurRadius: 6,
                  ),
                ]
              : null,
        ),
        child: isSelected
            ? Icon(
                Icons.check,
                size: 13,
                color: color.computeLuminance() > 0.5
                    ? Colors.black87
                    : Colors.white,
              )
            : null,
      ),
    );
  }
}
