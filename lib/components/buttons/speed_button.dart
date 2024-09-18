import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class SpeedButton extends StatefulWidget {
  const SpeedButton({super.key});

  @override
  SpeedButtonState createState() => SpeedButtonState();
}

class SpeedButtonState extends State<SpeedButton> {

  final AppColors appColors = AppColors();

  // bool isMuted = false;

  // void toggleSound() {
  //   setState(() {
  //     isMuted = !isMuted;
  //   });
  // }

  // TODO: Logic to show pop-up for adjusting reading speed

  @override
  Widget build(BuildContext context) {

    return IconButton(
      icon: Icon(
        //isMuted ? Icons.volume_mute : Icons.volume_up,
        Icons.speed,
        color: appColors.royalBlue,
        size: 40,
      ),
      onPressed: () {
        //toggleSound();
      },
    );
  }
}