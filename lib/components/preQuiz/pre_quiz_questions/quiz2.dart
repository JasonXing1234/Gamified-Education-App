import 'package:quiz/components/question.dart';

// TODO: Put in correct answers
// TODO: Not sure how to do the text field questions
// TODO: Put in explanations for answers

var quiz2 = [
  SingleAnswerQuestion(
    context: "What does this setting do? Choose from these options:",
    question: "What does this setting do?",
    photo: "assets/images/blocking.png",
    answerOptions: [
      "Updates who can tag you in their posts",
      "Updates who can see your posts",
      "Updates whether your account is private or public",
      "Allows you to block other users",
      "Updates where your message go"
    ],
    explanation: "This setting allows you to block other users, preventing them from interacting with you.",
    correctAnswer: "Allows you to block other users",
  ),
  SingleAnswerQuestion(
    context: "What does this setting do? Choose from these options:",
    question: "What does this setting do?",
    photo: "assets/images/posts.png",
    answerOptions: [
      "Updates who can tag you in their posts",
      "Updates who can see your posts",
      "Updates whether your account is private or public",
      "Allows you to block other users",
      "Updates where your message go"
    ],
    explanation: "This setting updates who can see your posts, allowing you to control your audience.",
    correctAnswer: "Updates who can see your posts",
  ),
  MultipleAnswersQuestion(
    context: "Why would you want to limit who can tag you in posts, stories, and comments?",
    question: "Why would you want to limit who can tag you in posts, stories, and comments?",
    photo: "no",
    answerOptions: [
      "textField"
    ],
    explanation: "Limiting who can tag you helps protect your privacy and control the visibility of posts involving you.",
    correctAnswers: [],
  ),
  MultipleAnswersQuestion(
    context: "Why would you want to block another user?",
    question: "Why would you want to block another user?",
    photo: "no",
    answerOptions: [
      "textField"
    ],
    explanation: "Blocking another user may be necessary if they are harassing you or violating your privacy.",
    correctAnswers: [],
  ),
  SingleAnswerQuestion(
    context: "What does this setting do? Choose from these options:",
    question: "What does this setting do?",
    photo: "assets/images/privacy.png",
    answerOptions: [
      "Updates who can tag you in their posts",
      "Updates who can see your posts",
      "Updates whether your account is private or public",
      "Allows you to block other users",
      "Updates where your message go"
    ],
    explanation: "This setting updates whether your account is private or public, allowing you to control who can find and follow you.",
    correctAnswer: "Updates whether your account is private or public",
  ),
  SingleAnswerQuestion(
    context: "What does this setting do? Choose from these options:",
    question: "What does this setting do?",
    photo: "assets/images/messageControls.png",
    answerOptions: [
      "Updates who can tag you in their posts",
      "Updates who can see your posts",
      "Updates whether your account is private or public",
      "Allows you to block other users",
      "Updates where your message go"
    ],
    explanation: "This setting allows you to manage where your messages go, either to your main inbox or the message requests.",
    correctAnswer: "Updates where your message go",
  ),
  SingleAnswerQuestion(
    context: "What does this setting do? Choose from these options:",
    question: "What does this setting do?",
    photo: "assets/images/mentions.png",
    answerOptions: [
      "Updates who can tag you in their posts",
      "Updates who can see your posts",
      "Updates whether your account is private or public",
      "Allows you to block other users",
      "Updates where your message go"
    ],
    explanation: "This setting updates who can tag you in their posts, offering you control over the visibility of your interactions.",
    correctAnswer: "Updates who can tag you in their posts",
  ),
  MultipleAnswersQuestion(
    context: "On Instagram, why would you want to limit who can reply to your story?",
    question: "Why would you want to limit who can reply to your story?",
    photo: "no",
    answerOptions: [
      "textField"
    ],
    explanation: "Limiting replies to your story helps maintain privacy and avoid unwanted or negative interactions.",
    correctAnswers: [],
  ),
  MultipleAnswersQuestion(
    context: "On Instagram, why would you want to adjust where messages go (e.g., to the chat inbox or the message requests)?",
    question: "Why would you want to adjust where messages go?",
    photo: "no",
    answerOptions: [
      "textField"
    ],
    explanation: "Adjusting message delivery can help you filter unwanted or spammy messages, ensuring your inbox stays organized.",
    correctAnswers: [],
  ),
  MultipleAnswersQuestion(
    context: "On Instagram, why would you want to set your social media account to private?",
    question: "Why would you want to set your Instagram account to private?",
    photo: "no",
    answerOptions: [
      "textField"
    ],
    explanation: "Setting your account to private restricts access to your posts and stories, keeping your content safe from people you don't know.",
    correctAnswers: [],
  ),
];