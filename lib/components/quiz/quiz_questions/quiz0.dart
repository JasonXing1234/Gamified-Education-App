import '../../question.dart';

// TODO: Create explanations for correct answer

var quiz0 = [
  const SingleAnswerQuestion(
    "no",
    "Here's a sample quiz question. Choose option A for this question",
    "no",
    [
      "A",
      "B",
      "C"
    ],
    "Option A is the correct answer for this practice question",
    "A",
  ),
  MultipleAnswersQuestion(
    "no",
    "Some questions have multiple answers. Select options B and C for this question",
    "no",
    [
      "A",
      "B",
      "C",
      "D",
      "E",
    ],
    "Options B and C are correct for this practice question",
    ["B", "C"],
  ),
];
