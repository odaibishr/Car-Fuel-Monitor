import 'package:flutter/material.dart';

import 'package:car_monitor/core/theme/color_styles.dart';

class PasswordTextField extends StatefulWidget {
  PasswordTextField({
    super.key,
    required this.controller,
    required this.onSubmit,
    required this.submitForm,
    required this.obscureText,
  });

  final TextEditingController controller;
  bool obscureText;
  final Function onSubmit;
  final Function submitForm;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => widget.onSubmit(),
      decoration: InputDecoration(
        hintText: 'أدخل كلمة المرور',
        prefixIcon:
            const Icon(Icons.lock_outline, color: ColorStyles.primaryColor),
        suffixIcon: IconButton(
          icon: Icon(
            widget.obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              widget.obscureText = !widget.obscureText;
            });
          },
        ),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'يرجى إدخال كلمة المرور';
        } else if (value.length < 6) {
          return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
        }
        return null;
      },
    );
  }
}
