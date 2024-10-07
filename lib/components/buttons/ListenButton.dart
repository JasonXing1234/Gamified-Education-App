import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:quiz/styles/app_colors.dart';


class ListenButton extends StatelessWidget {
  const ListenButton({
    super.key,
  });

  final AppColors appColors = const AppColors();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(
          FontAwesomeIcons.headphonesSimple,
          color: appColors.royalBlue,
        size: 30,
      ),
      onPressed: () {
        // Open Menu
        print("Listening...");
      },
    );
    //
    //
    // return FloatingActionButton(
    //   onPressed: () {
    //     // Implement your listen action here
    //
    //   },
    //   tooltip: 'Listen',
    //   child:
    // );
  }
}