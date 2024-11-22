import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';

enum ButtonType {
  next,
  back,
  check,
  submit,
  finish,
}


class MultiPurposeButton extends StatelessWidget {

  MultiPurposeButton({
    super.key,
    required this.disabled,
    required this.onTap,
    // this.buttonName = "NEXT",
    this.buttonType = ButtonType.next,
  });

  final bool disabled;
  final void Function() onTap;

  // String buttonName;
  ButtonType buttonType;

  // Style Variables
  final double borderRadius = 15;

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  @override
  Widget build(context) {

    // Get the right color
    Color color;
    if (disabled) {
      color = appColors.grey;
    }
    else {
      color = appColors.royalBlue;
    }


    Widget button;
    if (buttonType == ButtonType.next || buttonType == ButtonType.back) {
      button = IconButton(
        icon: Icon(
          buttonType == ButtonType.back ? Icons.chevron_left : Icons.chevron_right,
          color: color,
          size: 40,
        ),
        onPressed: disabled ? null : onTap,
      );
    }
    else {

      // Get the right name
      String buttonText;
      if (buttonType == ButtonType.check) {
        buttonText = "CHECK";
      }
      else if (buttonType == ButtonType.submit) {
        buttonText = "SUBMIT";
      }
      else if (buttonType == ButtonType.finish) {
        buttonText = "FINISH";
      }
      else {
        buttonText = "BUTTON";
      }

      button = TextButton(
        onPressed: disabled ? null : onTap,
        // style: ElevatedButton.styleFrom(
        //   //padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Padding for text and border
        //   fixedSize: const Size(150, 50),
        //   backgroundColor: color,
        //   foregroundColor: Colors.white,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(borderRadius),
        //   ),
        // ),
        child: Text(
          buttonText,
          style: textStyles.customBodyText(disabled ? appColors.grey : appColors.royalBlue, 20,),
          textAlign: TextAlign.center,
        ),
      );
    }

    return button;
  }
}