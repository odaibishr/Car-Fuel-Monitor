import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/theme/color_styles.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.index,
    required this.title,
    required this.time,
  });

  final String title, time;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: ColorStyles.primaryColor,
          width: 1,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0 / 2,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      subtitle: Text(time,
          style: TextStyle(
            color:
                Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.64),
          )),
      trailing: IconButton(
          onPressed: () {},
          icon: Icon(CupertinoIcons.delete, color: Colors.red.shade400)),
    );
  }
}
