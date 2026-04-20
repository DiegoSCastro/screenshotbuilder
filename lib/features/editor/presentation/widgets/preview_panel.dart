import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../common/widgets/device_frame.dart';
import '../../../../core/extensions/theme_ext.dart';
import '../../../../models/background_config.dart';
import '../../../../models/export_config.dart';
import '../../../../models/screenshot_font_family.dart';
import '../../../../models/text_vertical_placement.dart';
import '../../../../templates/base_template.dart';
import '../../../../utils/image_utils.dart';

class PreviewPanel extends StatefulWidget {
  final BaseTemplate template;
  final List<String> imagePaths;
  final Map<String, Uint8List> webImageBytes;
  final Map<String, String> webImageDisplayNames;
  final Map<String, List<String>> textsPerImage;
  final Map<String, TextVerticalPlacement> textPlacementPerImage;
  final int maxTexts;
  final int selectedIndex;
  final BackgroundConfig background;
  final StoreType storeType;
  final double textScale;
  final DeviceFrameStyle deviceFrame;
  final double imageSizeRatio;
  final Color textColor;
  final ScreenshotFontFamily screenshotFont;
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
    this.textPlacementPerImage = const {},
    required this.maxTexts,
    required this.selectedIndex,
    required this.background,
    required this.storeType,
    this.textScale = 1.0,
    this.deviceFrame = DeviceFrameStyle.none,
    this.imageSizeRatio = 0.8,
    this.textColor = Colors.white,
    this.screenshotFont = ScreenshotFontFamily.nunito,
    this.previewTablet = false,
    required this.onSelect,
    required this.onPreviewTabletChanged,
  });

  @override
  State<PreviewPanel> createState() => _PreviewPanelState();
}

class _PreviewPanelState extends State<PreviewPanel> {
  final TransformationController _transformController = TransformationController();

  static const double _minScale = 0.05;
  static const double _maxScale = 4.0;

  /// Last [InteractiveViewer] viewport size (updated in [LayoutBuilder]).
  Size _viewportSize = Size.zero;

  @override
  void dispose() {
    _transformController.dispose();
    super.dispose();
  }

  double get _aspectRatio {
    final sizes = ExportConfig.sizesForStore(widget.storeType);
    final activeSize = widget.previewTablet
        ? sizes.firstWhere((s) => s.isTablet, orElse: () => sizes.first)
        : sizes.firstWhere((s) => !s.isTablet, orElse: () => sizes.first);
    return activeSize.width / activeSize.height;
  }

  List<String> _textsFor(String path) {
    final texts = widget.textsPerImage[path];
    if (texts == null) return List.filled(widget.maxTexts, '');
    if (texts.length < widget.maxTexts) {
      return [...texts, ...List.filled(widget.maxTexts - texts.length, '')];
    }
    return texts;
  }

  /// Same geometry as [_buildPreviewContent] (logical width × height of the grid).
  Size _contentLogicalSize(double viewportWidth) {
    const spacing = 12.0;
    const paddingH = 4.0;
    final paths = widget.imagePaths;
    final count = paths.isEmpty ? 1 : paths.length;
    final cols =
        paths.isEmpty ? 1 : _columnsFor(paths.length, viewportWidth);
    final rows = (count + cols - 1) ~/ cols;
    final innerW = viewportWidth - paddingH * 2;
    final cellW = cols > 0 ? (innerW - spacing * (cols - 1)) / cols : innerW;
    final cellH = cellW / _aspectRatio;
    final contentHeight =
        rows * cellH + (rows > 1 ? (rows - 1) * spacing : 0);
    return Size(viewportWidth, contentHeight);
  }

  void _fitToView() {
    final vw = _viewportSize.width;
    final vh = _viewportSize.height;
    if (vw <= 0 || vh <= 0) return;

    final content = _contentLogicalSize(vw);
    final cw = content.width;
    final ch = content.height;
    if (cw <= 0 || ch <= 0) return;

    var scale = math.min(vw / cw, vh / ch);
    scale = scale.clamp(_minScale, _maxScale);

    final tx = (vw - cw * scale) / 2;
    final ty = (vh - ch * scale) / 2;

    _transformController.value = Matrix4(
      scale, 0, 0, 0,
      0, scale, 0, 0,
      0, 0, 1, 0,
      tx, ty, 0, 1,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final sizes = ExportConfig.sizesForStore(widget.storeType);
    final activeSize = widget.previewTablet
        ? sizes.firstWhere((s) => s.isTablet, orElse: () => sizes.first)
        : sizes.firstWhere((s) => !s.isTablet, orElse: () => sizes.first);
    final aspectRatio = activeSize.width / activeSize.height;
    final hasTabletSize = sizes.any((s) => s.isTablet);
    final primary = appColors?.primary ?? Colors.blue;

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
            if (widget.imagePaths.isNotEmpty) ...[
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: appColors?.primary?.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${widget.selectedIndex + 1}/${widget.imagePaths.length}',
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
            const SizedBox(width: 8),
            Tooltip(
              message: 'Fit entire preview in the viewport',
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _fitToView,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      Icons.fit_screen,
                      size: 20,
                      color: primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              _viewportSize = Size(constraints.maxWidth, constraints.maxHeight);
              final contentWidth = constraints.maxWidth;
              return ClipRect(
                child: InteractiveViewer(
                  transformationController: _transformController,
                  minScale: _minScale,
                  maxScale: _maxScale,
                  boundaryMargin: const EdgeInsets.all(double.infinity),
                  constrained: false,
                  clipBehavior: Clip.hardEdge,
                  trackpadScrollCausesScale: true,
                  child: _buildPreviewContent(
                    context,
                    aspectRatio,
                    contentWidth,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${activeSize.width.toInt()} x ${activeSize.height.toInt()} — ${widget.storeType.displayName}${widget.previewTablet ? ' (Tablet)' : ''}',
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
            isActive: !widget.previewTablet,
            primary: primary,
            onTap: () => widget.onPreviewTabletChanged(false),
          ),
          _buildToggleButton(
            context,
            icon: Icons.tablet_mac,
            label: 'Tablet',
            isActive: widget.previewTablet,
            primary: primary,
            onTap: () => widget.onPreviewTabletChanged(true),
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

  Widget _buildPreviewContent(
    BuildContext context,
    double aspectRatio,
    double viewportWidth,
  ) {
    const spacing = 12.0;
    const paddingH = 4.0;

    final paths = widget.imagePaths;
    final count = paths.isEmpty ? 1 : paths.length;
    final cols = paths.isEmpty
        ? 1
        : _columnsFor(paths.length, viewportWidth);
    final rows = (count + cols - 1) ~/ cols;

    final innerW = viewportWidth - paddingH * 2;
    final cellW = cols > 0 ? (innerW - spacing * (cols - 1)) / cols : innerW;
    final cellH = cellW / aspectRatio;
    final contentHeight =
        rows * cellH + (rows > 1 ? (rows - 1) * spacing : 0);

    return SizedBox(
      width: viewportWidth,
      height: contentHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingH),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: aspectRatio,
          ),
          itemCount: count,
          itemBuilder: (context, index) {
            if (paths.isEmpty) {
              return _buildScreenshotCard(
                context: context,
                size: Size(cellW, cellH),
                imagePath: null,
                imageBytes: null,
                texts: List.filled(widget.maxTexts, ''),
                isSelected: false,
                index: -1,
              );
            }
            final path = paths[index];
            return GestureDetector(
              onTap: () => widget.onSelect(index),
              child: _buildScreenshotCard(
                context: context,
                size: Size(cellW, cellH),
                imagePath: path,
                imageBytes: widget.webImageBytes[path],
                texts: _textsFor(path),
                isSelected: index == widget.selectedIndex,
                index: index,
              ),
            );
          },
        ),
      ),
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
            child: widget.template.build(
              size: size,
              texts: texts,
              imagePath: imagePath,
              imageBytes: imageBytes,
              background: widget.background,
              textScale: widget.textScale,
              deviceFrame: widget.deviceFrame,
              imageSizeRatio: widget.imageSizeRatio,
              textColor: widget.textColor,
              screenshotFont: widget.screenshotFont,
              isTablet: widget.previewTablet,
              textVerticalPlacement: imagePath == null
                  ? TextVerticalPlacement.aboveImage
                  : (widget.textPlacementPerImage[imagePath] ??
                      TextVerticalPlacement.aboveImage),
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
                          widget.webImageDisplayNames,
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
