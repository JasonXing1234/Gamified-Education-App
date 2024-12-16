import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;

  final void Function(BuildContext) onPressed;

  final AppColors appColors = const AppColors();
  final AppTextStyles textStyles = AppTextStyles();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          IconButton(
            icon: FaIcon(icon, color: appColors.royalBlue, size: 25,),
            onPressed: () {
              // Action to perform when the button is pressed
              onPressed(context);
            },
          ),
          Text(label, style: textStyles.customBodyText(appColors.royalBlue, 20),)
        ],
      ),
    );
  }
}