import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../styles/app_colors.dart';
import '../styles/text_styles.dart';

class QuestionAnswers extends StatelessWidget {
  QuestionAnswers(this.summary, {super.key});
  final List<Map<String, Object>> summary;

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  final double fontSize = 16;

  @override
  build(context) {
    return SizedBox(
      //height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summary.map((item) {
            bool isCorrect = item['correct_answer'] == item['user_answer'];
            return Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: isCorrect ? appColors.green : appColors.red,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          ((item['index'] as int) + 1).toString(),
                          style: textStyles.bodyTextWhite,
                        ),
                        FaIcon(isCorrect ? FontAwesomeIcons.check : FontAwesomeIcons.xmark , color: Colors.white, size: textStyles.mediumBodyText.fontSize,)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        item['question'] as String,
                        style: textStyles.mediumBodyText,
                      ),
                      Text(
                        "Your Response: ${item['user_answer'].toString()}",
                        style: textStyles.customBodyText(
                            isCorrect ? appColors.green : appColors.red,
                            fontSize
                        ),
                      ),
                      Text(
                          "Answer: ${item['correct_answer'].toString()}",
                          style: textStyles.customBodyText(
                            appColors.green,
                            fontSize
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
