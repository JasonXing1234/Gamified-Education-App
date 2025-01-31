import 'package:flutter/material.dart';

class PictureWithPrompt extends StatefulWidget {
  const PictureWithPrompt({
    super.key,
    required this.isPicClicked,
  });
  final bool isPicClicked;
  @override
  _PictureWithPromptState createState() => _PictureWithPromptState();
}

class _PictureWithPromptState extends State<PictureWithPrompt> {
  bool isPictureClicked = false;
  bool isItemBought = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isPictureClicked = true;
            });
          },
          child: Stack(
            children: [
              Image.asset("assets/animal_images/sunglasses.png"),
              if (isItemBought)
                Container(
                  color: Colors.black.withOpacity(0.4),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white.withOpacity(0.9),
                      size: 100,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (isPictureClicked)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Do you want to buy this item?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isItemBought = true;
                            isPictureClicked = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('Yes'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isPictureClicked = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('No'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}