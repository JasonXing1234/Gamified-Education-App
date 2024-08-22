import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
  });

  final IconData menuIcon = Icons.menu;

  final AppColors appColors = const AppColors();

  @override
  Widget build(BuildContext context) {

    return IconButton(
      icon: Icon(
        menuIcon,
        color: appColors.royalBlue,
        size: 40,
      ),
      onPressed: () {
        // Open Menu
      },
    );

  }
}