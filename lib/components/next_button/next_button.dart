import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {

  const NextButton({
    super.key,
    required this.disabled,
    required this.onTap,
  });

  final bool disabled;
  final String buttonText = "NEXT";
  final void Function() onTap;

  // Style Variables
  final double borderRadius = 10;
  final Color royalBlue = const Color(0xff2E83E8);
  final Color grey = const Color(0xff939393);

  @override
  build(context) {
    Color color;

    if (disabled) {
      color = grey;
    }
    else {
      color = royalBlue;
    }

    // Font and Color
    final theme = Theme.of(context);
    final fontStyle = theme.textTheme.bodyLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        //padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Padding for text and border
        fixedSize: const Size(150, 50),
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        buttonText,
        style: fontStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
