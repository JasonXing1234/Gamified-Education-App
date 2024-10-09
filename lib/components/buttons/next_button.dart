import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';

class NextButton extends StatelessWidget {

  NextButton({
    super.key,
    required this.disabled,
    required this.onTap,
    this.buttonName = "NEXT",
  });

  final bool disabled;
  final void Function() onTap;

  String buttonName;


  // Style Variables
  final double borderRadius = 15;

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  @override
  Widget build(context) {
    Color color;

    if (disabled) {
      color = appColors.grey;
    }
    else {
      color = appColors.royalBlue;
    }

    return IconButton(
      icon: Icon(
        buttonName == "BACK" ? Icons.chevron_left : Icons.chevron_right,
        color: color,
        size: 40,
      ),
      onPressed: disabled ? null : onTap,
    );

    // return ElevatedButton(
    //   onPressed: disabled ? null : onTap,
    //   style: ElevatedButton.styleFrom(
    //     //padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Padding for text and border
    //     fixedSize: const Size(150, 50),
    //     backgroundColor: color,
    //     foregroundColor: Colors.white,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(borderRadius),
    //     ),
    //   ),
    //   child: Text(
    //     buttonText,
    //     style: textStyles.mediumBodyTextWhite,
    //     textAlign: TextAlign.center,
    //   ),
    // );
  }
}
