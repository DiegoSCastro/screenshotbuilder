import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../common/widgets/device_frame.dart';
import '../../../../core/extensions/theme_ext.dart';
import '../../../../models/background_config.dart';
import '../../../../models/export_config.dart';
import '../../../../templates/base_template.dart';
import '../../../../utils/image_utils.dart';

class PreviewPanel extends StatelessWidget {
  final BaseTemplate template;
  final List<String> imagePaths;
  final Map<String, Uint8List> webImageBytes;
  final Map<String, String> webImageDisplayNames;
  final Map<String, List<String>> textsPerImage;
  final int maxTexts;
  final int selectedIndex;
  final BackgroundConfig background;
  final StoreType storeType;
  final double textScale;
  final DeviceFrameStyle deviceFrame;
  final double imageSizeRatio;
  final Color textColor;
  final bool previewTablet;
  final ValueChanged<int> onSelect;
  final ValueChanged<bool> onPreviewTabletChanged;

  const PreviewPanel({
    super.key,
    required this.template,
    required this.imagePaths,
    this.webImageBytes = const {},
    this.webImageDisplayNames = const {},
    required this.textsPerImage,
    required this.maxTexts,
    required this.selectedIndex,
    required this.background,
    required this.storeType,
    this.textScale = 1.0,
    this.deviceFrame = DeviceFrameStyle.none,
    this.imageSizeRatio = 0.8,
    this.textColor = Colors.white,
    this.previewTablet = false,
    required this.onSelect,
    required this.onPreviewTabletChanged,
  });

  List<String> _textsFor(String path) {
    final texts = textsPerImage[path];
    if (texts == null) return List.filled(maxTexts, '');
    if (texts.length < maxTexts) {
      return [...texts, ...List.filled(maxTexts - texts.length, '')];
    }
    return texts;
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final sizes = ExportConfig.sizesForStore(storeType);
    final activeSize = previewTablet
        ? sizes.firstWhere((s) => s.isTablet, orElse: () => sizes.first)
        : sizes.firstWhere((s) => !s.isTablet, orElse: () => sizes.first);
    final aspectRatio = activeSize.width / activeSize.height;
    final hasTabletSize = sizes.any((s) => s.isTablet);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PREVIEW',
              style: context.labelSmall(
                color: appColors?.subtext,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (imagePaths.isNotEmpty) ...[
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: appColors?.primary?.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${selectedIndex + 1}/${imagePaths.length}',
                  style: context.labelSmall(
                    color: appColors?.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            if (hasTabletSize) ...[
              const SizedBox(width: 12),
              _buildPreviewModeToggle(context),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: imagePaths.isEmpty
              ? _buildEmptyPreview(context, aspectRatio)
              : _buildPreviewGrid(context, aspectRatio),
        ),
        const SizedBox(height: 6),
        Text(
          '${activeSize.width.toInt()} x ${activeSize.height.toInt()} — ${storeType.displayName}${previewTablet ? ' (Tablet)' : ''}',
          style: context.labelSmall(
            color: appColors?.subtext?.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewModeToggle(BuildContext context) {
    final appColors = context.appColors;
    final primary = appColors?.primary ?? Colors.blue;

    return Container(
      decoration: BoxDecoration(
        color: appColors?.surfaceColor?.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: appColors?.contentBorder?.withValues(alpha: 0.15) ??
              Colors.grey.shade300,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton(
            context,
            icon: Icons.phone_iphone,
            label: 'Phone',
            isActive: !previewTablet,
            primary: primary,
            onTap: () => onPreviewTabletChanged(false),
          ),
          _buildToggleButton(
            context,
            icon: Icons.tablet_mac,
            label: 'Tablet',
            isActive: previewTablet,
            primary: primary,
            onTap: () => onPreviewTabletChanged(true),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isActive,
    required Color primary,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: isActive ? primary.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 12,
              color: isActive ? primary : Colors.grey,
            ),
            const SizedBox(width: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? primary : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyPreview(BuildContext context, double aspectRatio) {
    return Center(
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size =
                Size(constraints.maxWidth, constraints.maxHeight);
            return _buildScreenshotCard(
              context: context,
              size: size,
              imagePath: null,
              imageBytes: null,
              texts: List.filled(maxTexts, ''),
              isSelected: false,
              index: -1,
            );
          },
        ),
      ),
    );
  }

  Widget _buildPreviewGrid(BuildContext context, double aspectRatio) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = _columnsFor(imagePaths.length, constraints.maxWidth);
        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: aspectRatio,
          ),
          itemCount: imagePaths.length,
          itemBuilder: (context, index) {
            final path = imagePaths[index];
            final texts = _textsFor(path);
            return GestureDetector(
              onTap: () => onSelect(index),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final size = Size(
                    constraints.maxWidth,
                    constraints.maxHeight,
                  );
                  return _buildScreenshotCard(
                    context: context,
                    size: size,
                    imagePath: path,
                    imageBytes: webImageBytes[path],
                    texts: texts,
                    isSelected: index == selectedIndex,
                    index: index,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildScreenshotCard({
    required BuildContext context,
    required Size size,
    required String? imagePath,
    Uint8List? imageBytes,
    required List<String> texts,
    required bool isSelected,
    required int index,
  }) {
    final appColors = context.appColors;
    final primary = appColors?.primary ?? Colors.blue;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? primary : Colors.transparent,
          width: 2.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? primary.withValues(alpha: 0.25)
                : Colors.black.withValues(alpha: 0.12),
            blurRadius: isSelected ? 16 : 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: template.build(
              size: size,
              texts: texts,
              imagePath: imagePath,
              imageBytes: imageBytes,
              background: background,
              textScale: textScale,
              deviceFrame: deviceFrame,
              imageSizeRatio: imageSizeRatio,
              textColor: textColor,
              isTablet: previewTablet,
            ),
          ),
          if (index >= 0)
            Positioned(
              left: 6,
              bottom: 6,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  imagePath != null
                      ? ImageUtils.displayNameFor(
                          imagePath,
                          webImageDisplayNames,
                        )
                      : '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          if (isSelected)
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  int _columnsFor(int count, double availableWidth) {
    if (count <= 1) return 1;
    if (count <= 2) return 2;
    if (availableWidth > 800) return 3;
    return 2;
  }
}
