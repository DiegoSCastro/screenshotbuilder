# Styling Guide for AI Coding Assistants

This guide outlines the styling conventions and color management practices for this project.

## Color Management
**DO NOT** hardcode colors in widgets. All colors should be defined in `AppColors` and accessed via the `context`.

### Using Colors
To access colors in a widget:
1.  Use the `AppColors` extension on `BuildContext`.
2.  For repeated usage, define a local variable:
    ```dart
    final appColors = context.appColors;
    ```
3.  Access specific colors:
    ```dart
    Container(
      color: appColors?.primary,
      // ...
    )
    ```

### Adding New Colors
If a required color is missing from `AppColors`:
1.  **Modify `lib/core/theme/app_colors.dart`**:
    - Add a `final Color? newColorName;` field.
    - Update the constructor to require this new field.
    - Update `copyWith` and `lerp` methods to handle the new field.

2.  **Modify `lib/core/theme/app_theme.dart`**:
    - Update `lightThemeColors()` to provide the light mode value for the new color.
    - Update `darkThemeColors()` to provide the dark mode value for the new color.

## Text Styling
- Use the extensions provided in `lib/core/extensions/theme_ext.dart` to access text styles (e.g., `context.labelLarge`, `context.bodyMedium`).
- **Example**:
    ```dart
    Text(
      "Get Trivia", // Button text
      style: context.labelLarge(
        color: appColors?.surfaceColor,
      ),
    ),
    ```
- **Modifying Styles**: Use `copyWith` if additional changes are needed.
    ```dart
    Text(
      "Get Trivia",
      style: context.labelLarge(
        color: appColors?.surfaceColor,
      ).copyWith(letterSpacing: 4), // Use copyWith for extra changes
    ),
    ```
- **Opacity**: If you need to adjust opacity, use `.withValues` instead of `.withOpacity`, as `.withOpacity` is deprecated.
    ```dart
    color: appColors?.primary?.withValues(alpha: 0.5), // Correct
    // color: appColors?.primary?.withOpacity(0.5), // Deprecated - DO NOT USE
    ```
## General Styling
- Prefer using `context.setThemeBasedColor` (if available in extensions) for simple light/dark mode switches inline, but for shared definition, prefer `AppColors`.

