import 'package:flutter/material.dart';
import 'package:quiz/components/lesson/world.dart';

import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';

class DecorateScreen extends StatefulWidget {

  DecorateScreen({super.key, required this.world, required this.animalPath});

  //final String backdrop;
  World world;
  final String animalPath;

  @override
  DecorateScreenState createState() => DecorateScreenState();
}

class DecorateScreenState extends State<DecorateScreen> {

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  List<Map<String, dynamic>> stickerData = []; // Stores sticker path, position, and id
  final double imageSize = 100;

  // The stickers available for dragging
  List<String> availableStickers = ["assets/items/icecream.png", "assets/items/bandana.png", "assets/items/balloon.png", "assets/items/headphones.png",];

  // Global key to capture the widget
  final GlobalKey _captureKey = GlobalKey();

  // A Map to track which sticker is being dragged
  Map<int, Map<String, dynamic>> draggedStickers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 90,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0), // Adjust the top padding of title
          child: Text(
            "DECORATE PAGE",
            style: textStyles.heading1,
          ),
        ),

        // Back Button
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


      body: Stack(
        key: _captureKey, // Key to capture the widget
        children: [
          // Backdrop
          Positioned.fill(
            child: Image.asset(widget.world.background, fit: BoxFit.cover),
          ),

          // Dragon animal
          Center(
            child: Image.asset(widget.animalPath),
          ),

          // DragTarget to capture stickers dropped onto the canvas
          Positioned.fill(
            child: DragTarget<Map<String, dynamic>>(
              onAcceptWithDetails: (details) {
                if (details.data['source'] == 'library') {
                  // Convert the drop position to the local position
                  RenderBox renderBox = _captureKey.currentContext!.findRenderObject() as RenderBox;
                  Offset localPosition = renderBox.globalToLocal(details.offset);

                  setState(() {
                    // Add the dropped sticker's data with a unique ID
                    stickerData.add({
                      'id': DateTime.now().millisecondsSinceEpoch, // Unique ID for each sticker
                      'path': details.data['path'], // Sticker path
                      'offset': localPosition, // Position where it was dropped
                    });

                    // Remove the sticker from the library
                    availableStickers.remove(details.data['path']);
                  });
                }
              },
              builder: (context, candidateData, rejectedData) {
                return Stack(
                  children: [
                    ...stickerData.map((sticker) {
                      return Positioned(
                        left: sticker['offset'].dx,
                        top: sticker['offset'].dy,
                        child: Draggable<Map<String, dynamic>>(
                          data: {
                            'path': sticker['path'],
                            'source': 'canvas', // Indicates it's being moved from the canvas
                            'id': sticker['id'], // Unique ID to track this sticker
                          },
                          feedback: Image.asset(
                            sticker['path'],
                            width: imageSize,
                            height: imageSize,
                          ),
                          childWhenDragging: Container(),
                          onDragStarted: () {
                            // Track the dragged sticker ID
                            draggedStickers[sticker['id']] = sticker;
                          },
                          onDragEnd: (details) {
                            // When the drag ends, update the position based on the dragged sticker's ID
                            if (draggedStickers.containsKey(sticker['id'])) {
                              RenderBox renderBox = _captureKey.currentContext!.findRenderObject() as RenderBox;
                              Offset newOffset = renderBox.globalToLocal(details.offset);

                              setState(() {
                                // Update only the dragged sticker's offset using the stored `id`
                                int index = stickerData.indexWhere((sticker) => sticker['id'] == draggedStickers[sticker['id']]?['id']);
                                if (index != -1) {
                                  stickerData[index]['offset'] = newOffset;
                                }
                                // Remove the sticker from the map after the drag is done
                                draggedStickers.remove(sticker['id']);
                              });
                            }
                          },
                          child: Image.asset(
                            sticker['path'],
                            width: imageSize,
                            height: imageSize,
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              },
            ),
          ),

          // Sticker library with a DragTarget to accept returning stickers
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DragTarget<Map<String, dynamic>>(
              onAcceptWithDetails: (details) {
                if (details.data['source'] == 'canvas') {
                  setState(() {
                    // Safely remove the sticker from the canvas using the ID from details.data
                    stickerData.removeWhere((sticker) => sticker['id'] == details.data['id']);

                    // Add it back to the library if it's not already there
                    if (!availableStickers.contains(details.data['path'])) {
                      availableStickers.add(details.data['path']);
                    }
                  });
                }
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  height: imageSize * 1.75, // Adjust to fit the sticker's size and padding
                  color: Colors.white,
                  child: Scrollbar(
                    // You can control how the scrollbar is shown with the thickness, radius, etc.
                    thickness: 10,
                    radius: Radius.circular(10),
                    thumbVisibility: true,  // Makes the scrollbar always visible
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // Make it scroll horizontally
                      child: Row(
                        children: availableStickers.map((stickerPath) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add horizontal padding between images
                            child: Draggable<Map<String, dynamic>>(
                              data: {
                                'path': stickerPath,
                                'source': 'library', // Indicates it's coming from the library
                              },
                              feedback: Image.asset(
                                stickerPath,
                                width: imageSize,
                                height: imageSize,
                              ),
                              childWhenDragging: Container(),
                              child: Image.asset(
                                stickerPath,
                                width: imageSize,
                                height: imageSize,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
