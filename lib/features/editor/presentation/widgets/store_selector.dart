import 'package:flutter/material.dart';

import '../../../../core/extensions/theme_ext.dart';
import '../../../../models/export_config.dart';

class StoreSelector extends StatelessWidget {
  final StoreType selected;
  final ValueChanged<StoreType> onChanged;

  const StoreSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STORE',
          style: context.labelSmall(
            color: appColors?.subtext,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: StoreType.values.map((store) {
            final isSelected = store == selected;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: store == StoreType.appStore ? 4 : 0,
                  left: store == StoreType.playStore ? 4 : 0,
                ),
                child: _StoreChip(
                  label: store.displayName,
                  icon: store == StoreType.appStore
                      ? Icons.apple
                      : Icons.android,
                  isSelected: isSelected,
                  onTap: () => onChanged(store),
                  primaryColor: appColors?.primary,
                  surfaceColor: appColors?.cardBg,
                  onSurfaceColor: appColors?.onSurface,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _StoreChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? primaryColor;
  final Color? surfaceColor;
  final Color? onSurfaceColor;

  const _StoreChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.primaryColor,
    this.surfaceColor,
    this.onSurfaceColor,
  });

  @override
  Widget build(BuildContext context) {
    final primary = primaryColor ?? Colors.blue;
    return Material(
      color: isSelected
          ? primary.withValues(alpha: 0.15)
          : surfaceColor ?? Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? primary : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? primary : onSurfaceColor?.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? primary : onSurfaceColor?.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
