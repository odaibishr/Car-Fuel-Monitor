// In custom_text_feild.dart
import 'package:car_monitor/core/theme/color_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final IconData? icon;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.obscureText = false,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      obscureText: obscureText,
      cursorColor: ColorStyles.primaryColor,
      style: theme.textTheme.bodyLarge
          ?.copyWith(color: theme.colorScheme.onSurface),
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        hintText: hintText,
        hintStyle: theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor),
        prefixIcon:
            icon != null ? Icon(icon, color: ColorStyles.primaryColor) : null,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        filled: true,
        fillColor: Colors.grey[200],

      ),
    );
  }
}
