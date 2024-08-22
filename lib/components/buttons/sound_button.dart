import 'package:flutter/material.dart';


// How does this work?
// class SoundButtonListener extends ChangeNotifier {
//   var muted = false;
//
//   void toggleSound() {
//     muted = !muted;
//     notifyListeners();
//   }
// }

class SoundButton extends StatefulWidget {
  const SoundButton({super.key});

  @override
  SoundButtonState createState() => SoundButtonState();
}

class SoundButtonState extends State<SoundButton> {

  final Color royalBlue = const Color(0xff2E83E8);
  final Color grey = const Color(0xff939393);

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
        color: royalBlue,
        size: 40,
      ),
      onPressed: () {
        toggleSound();
      },
    );
  }
}

