import 'package:flutter/material.dart';

import '../../../../core/extensions/theme_ext.dart';
import '../../../../models/screenshot_font_family.dart';
import '../../../../models/text_vertical_placement.dart';

class TextEditorPanel extends StatefulWidget {
  final String title;
  final String? selectedImagePath;
  final ScreenshotFontFamily screenshotFont;
  /// Same as the template’s title weight in the exported image.
  final FontWeight titleFontWeight;
  final double textScale;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<ScreenshotFontFamily> onScreenshotFontChanged;
  final ValueChanged<double> onTextScaleChanged;
  final TextVerticalPlacement textVerticalPlacement;
  final ValueChanged<TextVerticalPlacement> onTextVerticalPlacementChanged;

  const TextEditorPanel({
    super.key,
    required this.title,
    required this.selectedImagePath,
    required this.screenshotFont,
    required this.titleFontWeight,
    required this.textScale,
    required this.onTitleChanged,
    required this.onScreenshotFontChanged,
    required this.onTextScaleChanged,
    required this.textVerticalPlacement,
    required this.onTextVerticalPlacementChanged,
  });

  @override
  State<TextEditorPanel> createState() => _TextEditorPanelState();
}

class _TextEditorPanelState extends State<TextEditorPanel> {
  late final TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
  }

  @override
  void didUpdateWidget(TextEditorPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedImagePath != widget.selectedImagePath ||
        oldWidget.title != widget.title) {
      if (widget.title != _titleController.text) {
        _titleController.text = widget.title;
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final primary = appColors?.primary ?? Colors.blue;
    final hasImage = widget.selectedImagePath != null;
    final onSurface = appColors?.onSurface ?? Colors.black87;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TEXT',
          style: context.labelSmall(
            color: appColors?.subtext,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (!hasImage) ...[
          const SizedBox(height: 8),
          Text(
            'Select a screenshot to edit its texts',
            style: TextStyle(
              fontSize: 11,
              color: appColors?.subtext?.withValues(alpha: 0.5),
            ),
          ),
        ],
        const SizedBox(height: 8),
        TextField(
          controller: _titleController,
          enabled: hasImage,
          style: context.bodySmall(color: appColors?.onSurface),
          decoration: InputDecoration(
            labelText: 'Title',
            labelStyle: TextStyle(
              fontSize: 12,
              color: appColors?.subtext,
            ),
            hintText: 'Main headline',
            hintStyle: TextStyle(
              fontSize: 12,
              color: appColors?.subtext?.withValues(alpha: 0.5),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: appColors?.contentBorder?.withValues(alpha: 0.2) ??
                    Colors.grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: appColors?.contentBorder?.withValues(alpha: 0.2) ??
                    Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primary),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: appColors?.contentBorder?.withValues(alpha: 0.1) ??
                    Colors.grey.shade300,
              ),
            ),
          ),
          onChanged: widget.onTitleChanged,
        ),
        const SizedBox(height: 12),
        Text(
          'Text position',
          style: TextStyle(
            fontSize: 12,
            color: appColors?.onSurface?.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 6),
        Tooltip(
          message:
              'Vertical templates: text above or below the image. Side template: text before or after the image in the row.',
          child: Opacity(
            opacity: hasImage ? 1 : 0.45,
            child: AbsorbPointer(
              absorbing: !hasImage,
              child: SizedBox(
                width: double.infinity,
                child: SegmentedButton<TextVerticalPlacement>(
                  showSelectedIcon: false,
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  segments: [
                    ButtonSegment<TextVerticalPlacement>(
                      value: TextVerticalPlacement.aboveImage,
                      label: Text(
                        TextVerticalPlacement.aboveImage.labelEn,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    ButtonSegment<TextVerticalPlacement>(
                      value: TextVerticalPlacement.belowImage,
                      label: Text(
                        TextVerticalPlacement.belowImage.labelEn,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                  selected: {widget.textVerticalPlacement},
                  onSelectionChanged: (next) {
                    if (next.isEmpty) return;
                    widget.onTextVerticalPlacementChanged(next.first);
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Font',
          style: TextStyle(
            fontSize: 12,
            color: appColors?.onSurface?.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: appColors?.contentBorder?.withValues(alpha: 0.2) ??
                  Colors.grey,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ScreenshotFontFamily>(
              value: widget.screenshotFont,
              isExpanded: true,
              borderRadius: BorderRadius.circular(10),
              selectedItemBuilder: (context) => ScreenshotFontFamily.values
                  .map(
                    (f) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        f.displayName,
                        overflow: TextOverflow.ellipsis,
                        style: f.textStyle(
                          fontSize: 14,
                          fontWeight: widget.titleFontWeight,
                          color: onSurface,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              items: ScreenshotFontFamily.values
                  .map(
                    (f) => DropdownMenuItem(
                      value: f,
                      child: Text(
                        f.displayName,
                        overflow: TextOverflow.ellipsis,
                        style: f.textStyle(
                          fontSize: 14,
                          fontWeight: widget.titleFontWeight,
                          color: onSurface,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: hasImage
                  ? (v) {
                      if (v != null) widget.onScreenshotFontChanged(v);
                    }
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _fontSizeSlider(context, appColors, primary),
      ],
    );
  }

  Widget _fontSizeSlider(
    BuildContext context,
    dynamic appColors,
    Color primary,
  ) {
    final scale = widget.textScale;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Font size',
              style: TextStyle(
                fontSize: 12,
                color: appColors?.onSurface?.withValues(alpha: 0.7),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${(scale * 100).round()}%',
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
            Icon(Icons.text_decrease, size: 14, color: appColors?.subtext),
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
                  value: scale.clamp(0.5, 2.0),
                  min: 0.5,
                  max: 2.0,
                  divisions: 15,
                  onChanged: widget.selectedImagePath != null
                      ? widget.onTextScaleChanged
                      : null,
                ),
              ),
            ),
            Icon(Icons.text_increase, size: 14, color: appColors?.subtext),
          ],
        ),
      ],
    );
  }
}
