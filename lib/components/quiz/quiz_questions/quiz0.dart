import '../../question.dart';

// TODO: Add needed survey questions

var preQuiz0 = [
  TextFieldQuestion(
    context: "Welcome to the Social Media Skills course! You'll learn the best "
        "ways to use social media and how to stay safe online. To help us tailor "
        "your experience we're going to ask you questions",
    question: "First off, what is your name?",
    photo: "no",
    answerOptions: [ "text-field" ],
    explanation: "none",
  ),
  MultipleAnswersQuestion(
    context: "no",
    question: "What goals do you have taking this course?",
    photo: "no",
    answerOptions: [
      "Connect with family and friends online",
      "Make new friends online",
      "Learn how to stay safe from scamming and phishing",
      "Improve social media habits",
      // "Build a positive online presence"
    ],
    explanation: "none",
    correctAnswers: ["none"]
  ),
  MultipleAnswersQuestion(
      context: "no",
      question: "What social media platforms do you use?",
      photo: "no",
      answerOptions: [
        "Facebook",
        "Instagram",
        "YouTube",
        "TicTok",
        "Reddit",
      ],
      explanation: "none",
      correctAnswers: ["none"]
  ),
];

var quiz0 = [
  TextFieldQuestion(
      context: "Let's sign you up so you can save your progress!",
      question: "What is your email address?",
      photo: "no",
      answerOptions: [ "text-field" ],
      explanation: "none"
  ),
  TextFieldQuestion(
      context: "no",
      question: "Now choose a password",
      photo: "no",
      answerOptions: [ "text-field" ],
      explanation: "none"
  ),
  SingleAnswerQuestion(
      context: "email & password",  // TODO: Remove this question or insert email and password for confirmation
      question: "Is that information correct?",
      photo: "no",
      answerOptions: [
        "True",
        "False"
      ],
      explanation: "no",
      correctAnswer: "Yes",
  ),
];
