import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
  });

  final IconData menuIcon = Icons.menu;

  final Color royalBlue = const Color(0xff2E83E8);
  final Color grey = const Color(0xff939393);

  @override
  Widget build(BuildContext context) {

    return IconButton(
      icon: Icon(
        menuIcon,
        color: royalBlue,
        size: 40,
      ),
      onPressed: () {
        // Open Menu
      },
    );

  }
}