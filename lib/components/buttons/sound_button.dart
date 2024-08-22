import 'package:flutter/material.dart';


// How does this work?
class SoundButtonListener extends ChangeNotifier {
  var muted = false;

  void toggleSound() {
    muted = !muted;
    notifyListeners();
  }
}

class SoundButton extends StatelessWidget {
  const SoundButton({
    super.key,
  });

  final Color royalBlue = const Color(0xff2E83E8);
  final Color grey = const Color(0xff939393);

  @override
  Widget build(BuildContext context) {
    // var soundState = context.watch<SoundButtonListener>();

    IconData soundIcon = Icons.volume_up;
    // if (soundState.muted) {
    //   soundIcon = Icons.volume_mute;
    // }
    // else {
    //   soundIcon = Icons.volume_up;
    // }

    return IconButton(
      icon: Icon(
        soundIcon,
        color: royalBlue,
        size: 40,
      ),
      onPressed: () {
        // soundState.toggleSound();
      },
    );
  }
}

