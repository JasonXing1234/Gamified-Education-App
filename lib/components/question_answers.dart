import 'package:flutter/material.dart';

class QuestionAnswers extends StatelessWidget {
  QuestionAnswers(this.summary, {super.key});
  final List<Map<String, Object>> summary;

  @override
  build(context) {
    Color correctColor = Color.fromARGB(255, 117, 216, 161);
    Color incorrectColor = Color.fromARGB(255, 228, 124, 157);

    return SizedBox(
      height: 300,
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
                      color: isCorrect ? correctColor : incorrectColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      ((item['index'] as int) + 1).toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        item['user_answer'] as String,
                        style: TextStyle(
                          fontSize: 16,
                          color: isCorrect ? correctColor : incorrectColor,
                        ),
                      ),
                      Text(
                        item['correct_answer'] as String,
                        style: TextStyle(
                          fontSize: 16,
                          color: correctColor,
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
