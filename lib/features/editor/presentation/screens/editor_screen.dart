import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/ui_utils/snack_bar.dart';
import '../../../../core/extensions/theme_ext.dart';
import '../../../../core/theme/theme_service.dart';
import '../../../../models/export_config.dart';
import '../../../../templates/template_registry.dart';
import '../blocs/editor_bloc/editor_bloc.dart';
import '../widgets/appearance_controls.dart';
import '../widgets/background_editor.dart';
import '../widgets/export_dialog.dart';
import '../widgets/image_list_panel.dart';
import '../widgets/preview_panel.dart';
import '../widgets/store_selector.dart';
import '../widgets/template_selector.dart';
import '../widgets/text_editor_panel.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Scaffold(
      backgroundColor: appColors?.surfaceColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: BlocBuilder<EditorBloc, EditorState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      _buildLeftPanel(context, state),
                      _buildCenterPanel(context, state),
                      _buildRightPanel(context, state),
                    ],
                  );
                },
              ),
            ),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final appColors = context.appColors;

    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: appColors?.appBarColor,
        border: Border(
          bottom: BorderSide(
            color: appColors?.contentBorder?.withValues(alpha: 0.1) ??
                Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.screenshot_monitor,
            color: appColors?.primary,
            size: 22,
          ),
          const SizedBox(width: 8),
          Text(
            'Screenshot Builder',
            style: context.titleMedium(
              fontWeight: FontWeight.w600,
              color: appColors?.onSurface,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              context.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
              size: 20,
            ),
            onPressed: ThemeService.toggleTheme,
            tooltip: 'Toggle theme',
          ),
        ],
      ),
    );
  }

  Widget _buildLeftPanel(BuildContext context, EditorState state) {
    final appColors = context.appColors;
    final bloc = context.read<EditorBloc>();
    final template = TemplateRegistry.getByIndex(state.selectedTemplateIndex);
    final maxTexts = template.model.maxTexts;
    final currentTexts = state.currentTexts(maxTexts);

    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: appColors?.appBarColor,
        border: Border(
          right: BorderSide(
            color: appColors?.contentBorder?.withValues(alpha: 0.1) ??
                Colors.grey.shade200,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StoreSelector(
                selected: state.storeType,
                onChanged: (store) =>
                    bloc.add(EditorEvent.selectStore(store)),
              ),
              const SizedBox(height: 20),
              TemplateSelector(
                selectedIndex: state.selectedTemplateIndex,
                onChanged: (index) =>
                    bloc.add(EditorEvent.selectTemplate(index)),
              ),
              const SizedBox(height: 20),
              TextEditorPanel(
                texts: currentTexts,
                maxTexts: maxTexts,
                selectedImagePath: state.selectedImagePath,
                onTextChanged: (index, text) =>
                    bloc.add(EditorEvent.updateText(
                  index: index,
                  text: text,
                )),
              ),
              const SizedBox(height: 20),
              BackgroundEditor(
                background: state.background,
                onChanged: (bg) =>
                    bloc.add(EditorEvent.updateBackground(bg)),
              ),
              const SizedBox(height: 20),
              AppearanceControls(
                textScale: state.textScale,
                showDeviceFrame: state.showDeviceFrame,
                deviceFrameStyle: state.deviceFrameStyle,
                imageSizeRatio: state.imageSizeRatio,
                textColor: state.textColor,
                onTextScaleChanged: (scale) =>
                    bloc.add(EditorEvent.updateTextScale(scale)),
                onDeviceFrameToggled: (show) =>
                    bloc.add(EditorEvent.toggleDeviceFrame(show)),
                onImageSizeRatioChanged: (ratio) =>
                    bloc.add(EditorEvent.updateImageSizeRatio(ratio)),
                onTextColorChanged: (color) =>
                    bloc.add(EditorEvent.updateTextColor(color)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenterPanel(BuildContext context, EditorState state) {
    final bloc = context.read<EditorBloc>();
    final template = TemplateRegistry.getByIndex(state.selectedTemplateIndex);
    final maxTexts = template.model.maxTexts;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: PreviewPanel(
          template: template,
          imagePaths: state.imagePaths,
          textsPerImage: state.textsPerImage,
          maxTexts: maxTexts,
          selectedIndex: state.selectedImageIndex,
          background: state.background,
          storeType: state.storeType,
          textScale: state.textScale,
          deviceFrame: state.deviceFrameStyle,
          imageSizeRatio: state.imageSizeRatio,
          textColor: state.textColor,
          previewTablet: state.previewTablet,
          onSelect: (index) => bloc.add(EditorEvent.selectImage(index)),
          onPreviewTabletChanged: (value) =>
              bloc.add(EditorEvent.togglePreviewTablet(value)),
        ),
      ),
    );
  }

  Widget _buildRightPanel(BuildContext context, EditorState state) {
    final appColors = context.appColors;
    final bloc = context.read<EditorBloc>();

    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: appColors?.appBarColor,
        border: Border(
          left: BorderSide(
            color: appColors?.contentBorder?.withValues(alpha: 0.1) ??
                Colors.grey.shade200,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ImageListPanel(
          imagePaths: state.imagePaths,
          selectedIndex: state.selectedImageIndex,
          onSelect: (index) =>
              bloc.add(EditorEvent.selectImage(index)),
          onRemove: (index) =>
              bloc.add(EditorEvent.removeImage(index)),
          onAdd: (paths) => bloc.add(EditorEvent.addImages(paths)),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final appColors = context.appColors;

    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) {
        final sizes = ExportConfig.sizesForStore(state.storeType);
        final totalScreenshots = sizes.length * state.imagePaths.length;
        final canExport = state.imagePaths.isNotEmpty;

        return Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: appColors?.appBarColor,
            border: Border(
              top: BorderSide(
                color: appColors?.contentBorder?.withValues(alpha: 0.1) ??
                    Colors.grey.shade200,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: appColors?.subtext?.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 6),
              Text(
                canExport
                    ? '$totalScreenshots screenshots will be generated (${sizes.length} sizes × ${state.imagePaths.length} images)'
                    : 'Add images to start generating screenshots',
                style: context.labelSmall(
                  color: appColors?.subtext?.withValues(alpha: 0.6),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: canExport
                      ? () => _handleExport(context, state)
                      : null,
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text(
                    'Generate Screenshots',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appColors?.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        appColors?.primary?.withValues(alpha: 0.3),
                    disabledForegroundColor: Colors.white54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleExport(BuildContext context, EditorState state) {
    if (state.imagePaths.isEmpty) {
      AppSnackBar.showSnackBar(
        context,
        message: 'Add at least one image first.',
        isError: true,
      );
      return;
    }

    final template =
        TemplateRegistry.getByIndex(state.selectedTemplateIndex);

    ExportDialog.show(
      context,
      template: template,
      imagePaths: state.imagePaths,
      textsPerImage: state.textsPerImage,
      maxTexts: template.model.maxTexts,
      background: state.background,
      storeType: state.storeType,
      textScale: state.textScale,
      showDeviceFrame: state.showDeviceFrame,
      imageSizeRatio: state.imageSizeRatio,
      textColor: state.textColor,
    );
  }
}
