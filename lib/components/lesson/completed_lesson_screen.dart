
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../buttons/custom_icon_button.dart';
import '../rewards/character.dart';
import 'lesson.dart';


class CompletedLessonScreen extends StatefulWidget {
  const CompletedLessonScreen({
    super.key,
    required this.lesson,
  });


  final Lesson lesson;

  // Unlocked features
  @override
  State<CompletedLessonScreen> createState() { return _CompletedLessonScreenState(); }
}

class _CompletedLessonScreenState extends State<CompletedLessonScreen> {

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  void openEditNameDialog() {


    final TextEditingController _controller = TextEditingController(text: widget.lesson.characterName);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Name"),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: "Name",
              hintText: "Enter your name",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.lesson.characterName = _controller.text; // Save the updated name
                });
                Navigator.of(context).pop(); // Close dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appColors.royalBlue, // Background color
                foregroundColor: Colors.white, // Text color
                elevation: 3, // Optional: button shadow
              ),
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Function to show the dialog
  void _showOptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select a Phase'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  widget.lesson.character.currentPhase = Phase.baby;
                });
              },
              child: const Text("Baby"),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  widget.lesson.character.currentPhase = Phase.teen;
                });
              },
              child: const Text("Teen"),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  widget.lesson.character.currentPhase = Phase.adult;
                });
              },
              child: const Text("Adult"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0), // Adjust the top padding of title
          child: Text(
            widget.lesson.title,
            style: textStyles.heading1,
          ),
        ),

        // Return Home Button
        leadingWidth: 60, // Gives space for the back button
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.center, // Aligns with the title vertically
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: appColors.royalBlue,
                  size: textStyles.heading1.fontSize,
                ),
              ],
            ),
          ),

        ),
      ),

      //Bottom Options
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        child: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomIconButton(icon: FontAwesomeIcons.dragon, label: "Phase", onPressed: _showOptionDialog,),
              CustomIconButton(icon: FontAwesomeIcons.paintRoller, label: "Decorate", onPressed: (context) {  },),
              CustomIconButton(icon: FontAwesomeIcons.share, label: "Share", onPressed: (context) {  },),
            ],
          ),
        )
      ),

      body: Center(
        child:
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25,),

                    // Dragon Type
                    Row (
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(widget.lesson.character.name, style: textStyles.bodyText,),

                        GestureDetector(
                          onTap: openEditNameDialog, // Opens the popup
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.lesson.characterName,
                                style: textStyles.bodyText,
                              ),
                              const SizedBox(width: 15),

                              FaIcon(FontAwesomeIcons.pen, color: appColors.grey, size: textStyles.smallBodyText.fontSize,),
                            ],
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 25,),
                  ],
                ),

                //Dragon Image
                Center(
                  child: widget.lesson.getCurrentPhoto() == "no" ? const SizedBox.shrink() : Image.asset(widget.lesson.getCurrentPhoto()),
                )
              ],
            ),

      )
    );
  }

}


