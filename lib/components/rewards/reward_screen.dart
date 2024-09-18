import 'package:flutter/material.dart';

import 'package:quiz/styles/app_colors.dart';
import 'package:quiz/styles/text_styles.dart';

import '../buttons/menu_button.dart';
import '../buttons/next_button.dart';
import '../buttons/speed_button.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({
    super.key,
    // required this.lessonNumber,
  });

  // final int lessonNumber;

  // Unlocked features
  @override
  State<RewardScreen> createState() { return _RewardScreenState(); }
}

class _RewardScreenState extends State<RewardScreen> {

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70, // Increases the height of the AppBar
          title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              "Reward",
              style: textStyles.heading1,
            ),
          ),
          leadingWidth: 100, // Gives space for the back button
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: appColors.royalBlue,
                      size: textStyles.heading1.fontSize,
                    ),
                    Text(
                      "Exit",
                      style: textStyles.customText(appColors.royalBlue, 20, FontWeight.normal),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              const Expanded(
                child: MenuButton(),
              ),
              const Expanded(
                child: SpeedButton(),
              ),
              Expanded(
                child: NextButton(
                  buttonText: "FINISH",
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  disabled: false,
                ),
              ),
            ],
          ),
        ),
      ),

        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(40),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Well done!",
                style: textStyles.bodyText,
                textAlign: TextAlign.center,)
            ],
          ),
        ),
    );
  }

}