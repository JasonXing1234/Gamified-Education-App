import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:quiz/styles/app_colors.dart';
import 'package:quiz/styles/text_styles.dart';

import '../buttons/listen_button.dart';
import '../buttons/next_button.dart';
import '../lesson/lesson.dart';
import 'animal.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({
    super.key,
    required this.lesson,
    required this.activityName,
  });

  final Lesson lesson;
  final String activityName;

  // Unlocked features
  @override
  State<RewardScreen> createState() { return _RewardScreenState(); }
}

class _RewardScreenState extends State<RewardScreen> {

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  @override
  Widget build(BuildContext context) {

    String? rewardImage;
    if (widget.activityName == "practice") {
      rewardImage = "assets/images/question_mark.png";
    }
    else if (widget.activityName == "quiz" && widget.lesson.animal.photos[Phase.adult] != null) {
      rewardImage = widget.lesson.animal.photos[Phase.adult];
    }
    else {
      rewardImage = "assets/images/lock.png";
    }


    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70, // Increases the height of the AppBar
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0), // Adjust the top padding of title
            child: Text(
              "REWARD",
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              const Expanded(
                  child: ListenButton(),
              ),
              Expanded(
                child: MultiPurposeButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  disabled: false,
                  buttonType: ButtonType.finish,
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
                "Well done, you completed the ${capitalizeString(widget.lesson.title)} ${capitalizeString(widget.activityName)}!",
                style: textStyles.bodyText,
                textAlign: TextAlign.center,),

              const SizedBox(height: 40,),

              Text(
                widget.activityName == "practice" ? "Here's your new item!" : widget.activityName == "quiz" ? "${capitalizeString(widget.lesson.animalName)} is now an adult!" : "${capitalizeString(widget.lesson.animalName)} grew!",
                style: textStyles.heading1,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20,),

              // Practices will now earn random accessories Edit later

              widget.activityName == "practice" ? FaIcon(FontAwesomeIcons.ticket, color: appColors.yellow, size: 100,) : Image.asset(rewardImage!),
              
              // TODO: Set up correct item reward: this just shows the current animal name and image
              //widget.activityName == "practice" ?
                //Text("1 Ticket", style: textStyles.heading1, textAlign: TextAlign.center,) :
                // Text("${capitalizeString(widget.lesson.animal.currentPhase.name)} ${widget.lesson.animal.name}", style: textStyles.bodyText, textAlign: TextAlign.center,),
            ],
          ),
        ),
    );
  }

}