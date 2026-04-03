import 'package:flutter/material.dart';
import '../../core/extensions/theme_ext.dart';

class CustomTextField extends FormField<String> {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final Widget? suffixIcon;
  final String? label;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onVisibilityToggle;
  final Color? primaryColor;
  final Color? surfaceColor;
  final Color? onSurfaceColor;
  final TextInputType? keyboardType;
  final int? maxLines;

  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.suffixIcon,
    this.label,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onVisibilityToggle,
    this.primaryColor,
    this.surfaceColor,
    this.onSurfaceColor,
    this.keyboardType,
    super.validator,
    this.maxLines,
  }) : super(
         initialValue: controller.text,
         autovalidateMode: AutovalidateMode.onUserInteraction,
         builder: (FormFieldState<String> state) {
           return Builder(
             builder: (context) {
               final colors = context.appColors;
               final primary = primaryColor ?? colors?.primary ?? Colors.green;
               final onSurface =
                   onSurfaceColor ??
                   colors?.onSurface ??
                   Theme.of(context).colorScheme.onSurface;
               final errorColor =
                   colors?.errorRed ?? Theme.of(context).colorScheme.error;

               return Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   if (label != null) ...[
                     Align(
                       alignment: Alignment.centerLeft,
                       child: Padding(
                         padding: const EdgeInsets.only(left: 4),
                         child: Text(
                           label.toUpperCase(),
                           style: context.labelMedium(
                             color: onSurface.withValues(alpha: 0.8),
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                       ),
                     ),
                     const SizedBox(height: 8),
                   ],
                   Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(16),
                       border: Border.all(
                         color: onSurface.withValues(alpha: 0.5),
                       ),
                     ),
                     child: TextField(
                       maxLines: isPassword ? 1 : maxLines,
                       controller: controller,
                       keyboardType: keyboardType,
                       obscureText: isPassword && !isPasswordVisible,
                       style: context.bodyMedium(color: onSurface),
                       cursorColor: primary,
                       onChanged: (text) {
                         state.didChange(text);
                       },
                       decoration: InputDecoration(
                         hintText: hintText,
                         hintStyle: context.bodyMedium(
                           color: onSurface.withValues(alpha: 0.5),
                         ),
                         prefixIcon: icon != null
                             ? Icon(
                                 icon,
                                 color: onSurface.withValues(alpha: 0.4),
                               )
                             : null,
                         suffixIcon:
                             suffixIcon ??
                             (isPassword
                                 ? IconButton(
                                     icon: Icon(
                                       isPasswordVisible
                                           ? Icons.visibility
                                           : Icons.visibility_off,
                                       color: onSurface.withValues(alpha: 0.4),
                                     ),
                                     onPressed: onVisibilityToggle,
                                   )
                                 : null),
                         border: InputBorder.none,
                         contentPadding: const EdgeInsets.symmetric(
                           horizontal: 16,
                           vertical: 16,
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(16),
                           borderSide: const BorderSide(
                             color: Colors.transparent,
                           ),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(16),
                           borderSide: BorderSide(color: primary, width: 1.0),
                         ),
                       ),
                     ),
                   ),
                   if (state.hasError)
                     Padding(
                       padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                       child: Text(
                         state.errorText!,
                         style: context.labelSmall(color: errorColor),
                       ),
                     ),
                 ],
               );
             },
           );
         },
       );
}
