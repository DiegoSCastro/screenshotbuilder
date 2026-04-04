import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../../core/extensions/theme_ext.dart';

class ColorPickerDialog extends StatefulWidget {
  final Color initialColor;

  const ColorPickerDialog({super.key, required this.initialColor});

  static Future<Color?> show(BuildContext context, Color initialColor) {
    return showDialog<Color>(
      context: context,
      builder: (_) => ColorPickerDialog(initialColor: initialColor),
    );
  }

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final primary = appColors?.primary ?? Colors.blue;

    return AlertDialog(
      backgroundColor: appColors?.surfaceColor ?? Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'Select Color',
        style: context.titleMedium(fontWeight: FontWeight.w600),
      ),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: _selectedColor,
          onColorChanged: (color) => setState(() => _selectedColor = color),
          enableAlpha: false,
          displayThumbColor: true,
          hexInputBar: true,
          labelTypes: const [],
          pickerAreaBorderRadius: BorderRadius.circular(12),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel', style: TextStyle(color: appColors?.subtext)),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_selectedColor),
          child: Text('Select', style: TextStyle(color: primary)),
        ),
      ],
    );
  }
}
