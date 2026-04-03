import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../core/extensions/theme_ext.dart';
import '../../../../utils/image_utils.dart';

class ImageListPanel extends StatelessWidget {
  final List<String> imagePaths;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final ValueChanged<int> onRemove;
  final ValueChanged<List<String>> onAdd;

  const ImageListPanel({
    super.key,
    required this.imagePaths,
    required this.selectedIndex,
    required this.onSelect,
    required this.onRemove,
    required this.onAdd,
  });

  Future<void> _pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null && result.files.isNotEmpty) {
      final paths = result.files
          .where((f) => f.path != null)
          .map((f) => f.path!)
          .where((p) => ImageUtils.isValidImagePath(p))
          .toList();
      if (paths.isNotEmpty) {
        onAdd(paths);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final primary = appColors?.primary ?? Colors.blue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SCREENSHOTS',
              style: context.labelSmall(
                color: appColors?.subtext,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${imagePaths.length} images',
              style: context.labelSmall(
                color: appColors?.subtext?.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: imagePaths.isEmpty
              ? _buildEmptyState(context)
              : ListView.separated(
                  itemCount: imagePaths.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 6),
                  itemBuilder: (context, index) {
                    final path = imagePaths[index];
                    final isSelected = index == selectedIndex;

                    return GestureDetector(
                      onTap: () => onSelect(index),
                      child: Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isSelected
                              ? primary.withValues(alpha: 0.1)
                              : appColors?.cardBg ?? Colors.grey[100],
                          border: Border.all(
                            color: isSelected
                                ? primary
                                : Colors.transparent,
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.file(
                                  File(path),
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) =>
                                      const Icon(Icons.broken_image, size: 20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                ImageUtils.getFileName(path),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: appColors?.onSurface,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 16,
                                color: appColors?.subtext,
                              ),
                              onPressed: () => onRemove(index),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 28,
                                minHeight: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _pickImages,
            icon: const Icon(Icons.add_photo_alternate_outlined, size: 18),
            label: const Text('Add Images', style: TextStyle(fontSize: 13)),
            style: OutlinedButton.styleFrom(
              foregroundColor: primary,
              side: BorderSide(color: primary.withValues(alpha: 0.3)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final appColors = context.appColors;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.collections_outlined,
            size: 40,
            color: appColors?.subtext?.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 8),
          Text(
            'No screenshots added',
            style: TextStyle(
              fontSize: 12,
              color: appColors?.subtext?.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Add images to generate\nstore screenshots',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: appColors?.subtext?.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}
