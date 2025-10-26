import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/style.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final bool filled;
  final Color? fillColor;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final bool showClearButton;

  const MyTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.focusNode,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.contentPadding,
    this.filled = true,
    this.fillColor,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.disabledBorder,
    this.showClearButton = false,
  });

  Widget? _buildSuffixIcon(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    List<Widget> suffixWidgets = [];

    // Add clear button if enabled and text is not empty
    if (showClearButton && controller != null && enabled) {
      suffixWidgets.add(
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller!,
          builder: (context, value, child) {
            if (value.text.isEmpty) return SizedBox.shrink();
            return IconButton(
              icon: Icon(
                Icons.clear,
                size: 20,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              onPressed: () {
                controller?.clear();
                if (onChanged != null) {
                  onChanged!('');
                }
              },
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            );
          },
        ),
      );
    }

    // Add custom suffix icon if provided
    if (suffixIcon != null) {
      suffixWidgets.add(suffixIcon!);
    }

    if (suffixWidgets.isEmpty) return null;

    if (suffixWidgets.length == 1) {
      return suffixWidgets.first;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: suffixWidgets.map((widget) {
        return Padding(padding: EdgeInsets.only(left: 4), child: widget);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
      textAlign: textAlign,
      style: textTheme.bodyMedium?.copyWith(
        color: enabled
            ? (isDark ? Colors.white : greenSwatch.shade900)
            : (isDark ? Colors.grey[600] : Colors.grey[400]),
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: Icon(prefixIcon, size: 18),
        suffixIcon: _buildSuffixIcon(context),
        filled: filled,
        fillColor: fillColor ?? (isDark ? greenSwatch.shade800 : whiteColor),
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 16, vertical: 14),

        // Border configurations
        border:
            border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? greenSwatch.shade600 : Colors.grey[300]!,
                width: 1,
              ),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? greenSwatch.shade600 : Colors.grey[300]!,
                width: 1,
              ),
            ),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
        errorBorder:
            errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: dangerRed, width: 1),
            ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: dangerRed, width: 2),
        ),
        disabledBorder:
            disabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? greenSwatch.shade700 : Colors.grey[200]!,
                width: 1,
              ),
            ),

        // Label and hint styling
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: isDark ? Colors.grey[400] : Colors.grey[600],
        ),
        floatingLabelStyle: textTheme.bodyMedium?.copyWith(color: primaryColor),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: isDark ? Colors.grey[600] : Colors.grey[400],
        ),
        helperStyle: textTheme.bodySmall?.copyWith(
          color: isDark ? Colors.grey[500] : Colors.grey[600],
        ),
        errorStyle: textTheme.bodySmall?.copyWith(color: dangerRed),
      ),
    );
  }
}

// Specialized text field variants
String? defaultEmailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
}
