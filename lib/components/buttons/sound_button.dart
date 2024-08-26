import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class SoundButton extends StatefulWidget {
  const SoundButton({super.key});

  @override
  SoundButtonState createState() => SoundButtonState();
}

class SoundButtonState extends State<SoundButton> {

  final AppColors appColors = AppColors();

  bool isMuted = false;

  void toggleSound() {
    setState(() {
      isMuted = !isMuted;
    });

    // TODO: Logic to mute and un-mute sound
  }

  @override
  Widget build(BuildContext context) {

    return IconButton(
      icon: Icon(
        isMuted ? Icons.volume_mute : Icons.volume_up,
        color: appColors.royalBlue,
        size: 40,
      ),
      onPressed: () {
        toggleSound();
      },
    );
  }
}

