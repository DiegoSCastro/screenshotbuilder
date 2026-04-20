import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../../../common/widgets/device_frame.dart';
import '../../../../core/extensions/theme_ext.dart';
import '../../../../core/renderer/screenshot_renderer.dart';
import '../../../../models/background_config.dart';
import '../../../../models/export_config.dart';
import '../../../../models/screenshot_font_family.dart';
import '../../../../models/text_vertical_placement.dart';
import '../../../../templates/base_template.dart';
import '../../../../utils/image_utils.dart';
import 'export_dialog_paths_stub.dart'
    if (dart.library.io) 'export_dialog_paths_io.dart' as export_paths;

class ExportDialog extends StatefulWidget {
  final BaseTemplate template;
  final List<String> imagePaths;
  final Map<String, Uint8List> webImageBytes;
  final Map<String, List<String>> textsPerImage;
  final int maxTexts;
  final BackgroundConfig background;
  final StoreType storeType;
  final double textScale;
  final bool showDeviceFrame;
  final double imageSizeRatio;
  final Color textColor;
  final ScreenshotFontFamily screenshotFont;
  final Map<String, TextVerticalPlacement> textPlacementPerImage;

  const ExportDialog({
    super.key,
    required this.template,
    required this.imagePaths,
    this.webImageBytes = const {},
    required this.textsPerImage,
    required this.maxTexts,
    required this.background,
    required this.storeType,
    this.textScale = 1.0,
    this.showDeviceFrame = false,
    this.imageSizeRatio = 0.8,
    this.textColor = Colors.white,
    this.screenshotFont = ScreenshotFontFamily.nunito,
    this.textPlacementPerImage = const {},
  });

  static Future<void> show(
    BuildContext context, {
    required BaseTemplate template,
    required List<String> imagePaths,
    Map<String, Uint8List> webImageBytes = const {},
    required Map<String, List<String>> textsPerImage,
    required int maxTexts,
    required BackgroundConfig background,
    required StoreType storeType,
    double textScale = 1.0,
    bool showDeviceFrame = false,
    double imageSizeRatio = 0.8,
    Color textColor = Colors.white,
    ScreenshotFontFamily screenshotFont = ScreenshotFontFamily.nunito,
    Map<String, TextVerticalPlacement> textPlacementPerImage = const {},
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ExportDialog(
        template: template,
        imagePaths: imagePaths,
        webImageBytes: webImageBytes,
        textsPerImage: textsPerImage,
        maxTexts: maxTexts,
        background: background,
        storeType: storeType,
        textScale: textScale,
        showDeviceFrame: showDeviceFrame,
        imageSizeRatio: imageSizeRatio,
        textColor: textColor,
        screenshotFont: screenshotFont,
        textPlacementPerImage: textPlacementPerImage,
      ),
    );
  }

  @override
  State<ExportDialog> createState() => _ExportDialogState();
}

class _ExportDialogState extends State<ExportDialog> {
  double _progress = 0;
  String _status = 'Preparing...';
  bool _isComplete = false;
  bool _hasError = false;
  String _errorMessage = '';
  List<String> _exportedPaths = [];
  String _outputDir = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startExport());
  }

  Future<void> _startExport() async {
    try {
      final dir = await _getOutputDirectory();
      if (dir == null) {
        if (mounted) Navigator.of(context).pop();
        return;
      }
      _outputDir = dir;

      if (!mounted) return;

      setState(() => _status = 'Pre-caching images...');
      await ImageUtils.precacheImages(
        context,
        widget.imagePaths,
        webImageBytes: widget.webImageBytes,
      );

      if (!mounted) return;

      final sizes = ExportConfig.sizesForStore(widget.storeType);
      final renderer = ScreenshotRenderer();

      setState(() => _status = 'Generating screenshots...');

      final deviceFrame = widget.showDeviceFrame
          ? (widget.storeType == StoreType.appStore
              ? DeviceFrameStyle.iPhone
              : DeviceFrameStyle.android)
          : DeviceFrameStyle.none;

      final paths = await renderer.renderAll(
        context: context,
        template: widget.template,
        images: widget.imagePaths,
        textsPerImage: widget.textsPerImage,
        maxTexts: widget.maxTexts,
        background: widget.background,
        sizes: sizes,
        outputDir: dir,
        textScale: widget.textScale,
        deviceFrame: deviceFrame,
        imageSizeRatio: widget.imageSizeRatio,
        textColor: widget.textColor,
        screenshotFont: widget.screenshotFont,
        webImageBytes: widget.webImageBytes,
        textPlacementPerImage: widget.textPlacementPerImage,
        onProgress: (current, total) {
          if (mounted) {
            setState(() {
              _progress = current / total;
              _status = 'Rendering $current of $total...';
            });
          }
        },
      );

      if (mounted) {
        setState(() {
          _isComplete = true;
          _exportedPaths = paths;
          _status = kIsWeb
              ? 'Done! ${paths.length} files — check your downloads.'
              : 'Done! ${paths.length} screenshots generated.';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = e.toString();
          _status = 'Export failed';
        });
      }
    }
  }

  Future<String?> _getOutputDirectory() async {
    if (kIsWeb) return '';
    final chosen = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Choose export folder',
    );
    if (chosen != null) return chosen;

    return export_paths.defaultExportDirectory();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final primary = appColors?.primary ?? Colors.blue;

    return AlertDialog(
      backgroundColor: appColors?.surfaceColor ?? Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          if (_isComplete)
            Icon(Icons.check_circle, color: Colors.green, size: 24)
          else if (_hasError)
            Icon(Icons.error,
                color: appColors?.errorRed ?? Colors.red, size: 24)
          else
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(primary),
              ),
            ),
          const SizedBox(width: 12),
          Text(
            _isComplete
                ? 'Export Complete'
                : _hasError
                    ? 'Export Failed'
                    : 'Exporting...',
            style: context.titleMedium(fontWeight: FontWeight.w600),
          ),
        ],
      ),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_hasError) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: _isComplete ? 1.0 : _progress,
                  minHeight: 6,
                  backgroundColor: primary.withValues(alpha: 0.1),
                  valueColor: AlwaysStoppedAnimation(
                    _isComplete ? Colors.green : primary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
            Text(
              _status,
              style: context.bodySmall(color: appColors?.subtext),
            ),
            if (_hasError) ...[
              const SizedBox(height: 8),
              Text(
                _errorMessage,
                style: context.bodySmall(
                  color: appColors?.errorRed ?? Colors.red,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (_isComplete && !kIsWeb && _outputDir.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Saved to: $_outputDir',
                style: context.labelSmall(
                  color: appColors?.subtext?.withValues(alpha: 0.6),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '${_exportedPaths.length} files generated',
                style: context.labelSmall(
                  color: appColors?.subtext?.withValues(alpha: 0.5),
                ),
              ),
            ],
            if (_isComplete && kIsWeb) ...[
              const SizedBox(height: 8),
              Text(
                '${_exportedPaths.length} PNG files (browser download)',
                style: context.labelSmall(
                  color: appColors?.subtext?.withValues(alpha: 0.5),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        if (_isComplete || _hasError)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: TextStyle(color: primary),
            ),
          ),
      ],
    );
  }
}
