import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      cursorColor: theme.colorScheme.onSurface,
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
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.primary),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: theme.colorScheme.onSurface.withOpacity(.8)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.error),
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: theme.colorScheme.surface.withOpacity(0.8),
      ),
    );
  }
}
