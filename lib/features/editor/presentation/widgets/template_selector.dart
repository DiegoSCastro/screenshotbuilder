import 'package:flutter/material.dart';

import '../../../../core/extensions/theme_ext.dart';
import '../../../../models/background_config.dart';
import '../../../../models/screenshot_font_family.dart';
import '../../../../models/text_vertical_placement.dart';
import '../../../../templates/template_registry.dart';

class TemplateSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const TemplateSelector({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final templates = TemplateRegistry.templates;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TEMPLATE',
          style: context.labelSmall(
            color: appColors?.subtext,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: templates.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final template = templates[index];
              final isSelected = index == selectedIndex;
              final primary = appColors?.primary ?? Colors.blue;

              return GestureDetector(
                onTap: () => onChanged(index),
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? primary : Colors.transparent,
                      width: 2,
                    ),
                    color: isSelected
                        ? primary.withValues(alpha: 0.1)
                        : appColors?.cardBg ?? Colors.grey[200],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 60,
                        child: _TemplateThumbnail(index: index),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        template.model.name,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isSelected
                              ? primary
                              : appColors?.onSurface
                                  ?.withValues(alpha: 0.7),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TemplateThumbnail extends StatelessWidget {
  final int index;

  const _TemplateThumbnail({required this.index});

  @override
  Widget build(BuildContext context) {
    const bg = BackgroundConfig(
      gradientColors: [Color(0xFF667EEA), Color(0xFF764BA2)],
    );
    final template = TemplateRegistry.getByIndex(index);

    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: template.build(
        size: const Size(50, 60),
        texts: ['Title', 'Subtitle'],
        imagePath: null,
        background: bg,
        screenshotFont: ScreenshotFontFamily.nunito,
        textVerticalPlacement: TextVerticalPlacement.aboveImage,
      ),
    );
  }
}
