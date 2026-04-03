import 'package:flutter/material.dart';

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
  late TextEditingController _hexController;

  static const _presetColors = [
    Color(0xFF667EEA),
    Color(0xFF764BA2),
    Color(0xFFf093fb),
    Color(0xFFf5576c),
    Color(0xFFfda085),
    Color(0xFFfccb90),
    Color(0xFF4facfe),
    Color(0xFF00f2fe),
    Color(0xFF43e97b),
    Color(0xFF38f9d7),
    Color(0xFFfa709a),
    Color(0xFFfee140),
    Color(0xFFa18cd1),
    Color(0xFFfbc2eb),
    Color(0xFF30cfd0),
    Color(0xFF330867),
    Color(0xFF0F2027),
    Color(0xFF2C5364),
    Color(0xFF000000),
    Color(0xFFFFFFFF),
    Color(0xFF1a1a2e),
    Color(0xFF16213e),
    Color(0xFF0f3460),
    Color(0xFFe94560),
  ];

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
    _hexController = TextEditingController(
      text: _colorToHex(_selectedColor),
    );
  }

  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  String _colorToHex(Color color) {
    return color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase();
  }

  Color? _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      final value = int.tryParse('FF$hex', radix: 16);
      if (value != null) return Color(value);
    }
    if (hex.length == 8) {
      final value = int.tryParse(hex, radix: 16);
      if (value != null) return Color(value);
    }
    return null;
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
      content: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                color: _selectedColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: appColors?.contentBorder?.withValues(alpha: 0.2) ??
                      Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _presetColors.map((color) {
                final isSelected = color.toARGB32() == _selectedColor.toARGB32();
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                      _hexController.text = _colorToHex(color);
                    });
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? primary : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: primary.withValues(alpha: 0.3),
                                blurRadius: 6,
                              ),
                            ]
                          : null,
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            size: 16,
                            color: color.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  '#',
                  style: context.bodyLarge(fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: TextField(
                    controller: _hexController,
                    maxLength: 6,
                    style: context.bodyMedium(),
                    decoration: InputDecoration(
                      counterText: '',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                    onChanged: (value) {
                      final color = _hexToColor(value);
                      if (color != null) {
                        setState(() => _selectedColor = color);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
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
