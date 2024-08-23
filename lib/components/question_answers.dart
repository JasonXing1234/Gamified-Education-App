import 'package:flutter/material.dart';

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
                  margin: EdgeInsets.only(right: 20),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: isCorrect ? appColors.green : appColors.red,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      ((item['index'] as int) + 1).toString(),
                      style: textStyles.bodyTextWhite,
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
                        item['user_answer'] as String,
                        style: textStyles.bodyTextCustom(
                            isCorrect ? appColors.green : appColors.red,
                            fontSize
                        ),
                      ),
                      Text(
                        item['correct_answer'] as String,
                        style: textStyles.bodyTextCustom(
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
