import 'package:flutter/material.dart';
import 'package:quiz/styles/app_colors.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.pageIndex,
    required this.pageList,
  });

  final int pageIndex;
  final List<dynamic> pageList; // ReadingPage or Question

  final AppColors appColors = const AppColors();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0), // Set the radius for rounded corners
      child: LinearProgressIndicator(
        // If on last page index (length - 1) set the progress to 1.0 otherwise get fraction
        value: pageIndex == pageList.length - 1 ? 1.0 : pageIndex / pageList.length,
        minHeight: 15, // Increase height to better visualize the rounded corners
        backgroundColor: appColors.grey,
        color: appColors.royalBlue,
      ),
    );
  }
}