import 'package:flutter/material.dart';

import '../styles/color_styles.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.text,
    required this.icon,
    required this.press,
  });

  final String text;
  final IconData icon;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: press,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F9),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(icon, color: ColorStyles.primaryColor),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: ColorStyles.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
