import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/theme_ext.dart';

class TextEditorPanel extends StatefulWidget {
  final List<String> texts;
  final int maxTexts;
  final String? selectedImagePath;
  final void Function(int index, String text) onTextChanged;

  const TextEditorPanel({
    super.key,
    required this.texts,
    required this.maxTexts,
    required this.selectedImagePath,
    required this.onTextChanged,
  });

  @override
  State<TextEditorPanel> createState() => _TextEditorPanelState();
}

class _TextEditorPanelState extends State<TextEditorPanel> {
  late List<TextEditingController> _controllers;

  static const _labels = ['Title', 'Subtitle', 'Footer'];
  static const _hints = [
    'Main headline text',
    'Supporting description',
    'Additional info or CTA',
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.maxTexts,
      (i) => TextEditingController(
        text: i < widget.texts.length ? widget.texts[i] : '',
      ),
    );
  }

  @override
  void didUpdateWidget(TextEditorPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    final textsChanged = !listEquals(oldWidget.texts, widget.texts);
    final maxChanged = oldWidget.maxTexts != widget.maxTexts;
    final imageChanged = oldWidget.selectedImagePath != widget.selectedImagePath;

    if (maxChanged || textsChanged || imageChanged) {
      _syncControllers();
    }
  }

  void _syncControllers() {
    while (_controllers.length < widget.maxTexts) {
      _controllers.add(TextEditingController());
    }
    while (_controllers.length > widget.maxTexts) {
      _controllers.removeLast().dispose();
    }
    for (int i = 0; i < widget.maxTexts; i++) {
      final newText = i < widget.texts.length ? widget.texts[i] : '';
      if (_controllers[i].text != newText) {
        _controllers[i].text = newText;
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final hasImage = widget.selectedImagePath != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TEXTS',
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
        ...List.generate(widget.maxTexts, (i) {
          final label = i < _labels.length ? _labels[i] : 'Text ${i + 1}';
          final hint = i < _hints.length ? _hints[i] : 'Enter text';

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TextField(
              controller: _controllers[i],
              enabled: hasImage,
              style: context.bodySmall(color: appColors?.onSurface),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                  fontSize: 12,
                  color: appColors?.subtext,
                ),
                hintText: hint,
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
                    color:
                        appColors?.contentBorder?.withValues(alpha: 0.2) ??
                            Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color:
                        appColors?.contentBorder?.withValues(alpha: 0.2) ??
                            Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: appColors?.primary ?? Colors.blue,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color:
                        appColors?.contentBorder?.withValues(alpha: 0.1) ??
                            Colors.grey.shade300,
                  ),
                ),
              ),
              onChanged: (value) => widget.onTextChanged(i, value),
            ),
          );
        }),
      ],
    );
  }
}
