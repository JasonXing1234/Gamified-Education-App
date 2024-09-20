import 'package:quiz/components/question.dart';

// TODO: Put in correct answers
// TODO: Not sure how to do the text field questions
// TODO: Put in explanations for answers

var quiz2 = [
  const SingleAnswerQuestion(
    "no",
    "What does this setting do? Choose from this options",
    "assets/images/blocking.png",
    [
      "Updates who can tag you in their posts",
      "Updates who can see your posts",
      "Updates whether your account is private or public",
      "Allows you to block other users",
      "Updates where your message go"
    ],
    "explain",
    "Allows you to block other users",
  ),
  const SingleAnswerQuestion(
    "no",
    "What does this setting do? Choose from these options: ",
    "assets/images/posts.png",
    [
      "Updates who can tag you in their posts",
      "Updates who can see your posts",
      "Updates whether your account is private or public",
      "Allows you to block other users",
      "Updates where your message go"
    ],
    "explain",
    "Updates who can see your posts",
  ),
  MultipleAnswersQuestion(
    "no",
    "Why would you want to limit who can tag you in posts, stories, and comments?",
    "no",
    [
      "textField"
    ],
    "explain",
    [],
  ),
  MultipleAnswersQuestion(
    "no",
    "Why would you want to block another user?",
    "no",
    [
      "textField"
    ],
    "explain",
    [],
  ),
  const SingleAnswerQuestion(
    "no",
    "What does this setting do? Choose from these options: ",
    "assets/images/privacy.png",
    [
      "Updates who can tag you in their posts",
      "Updates who can see your posts",
      "Updates whether your account is private or public",
      "Allows you to block other users",
      "Updates where your message go"
    ],
    "explain",
    "Updates whether your account is private or public",
  ),
  const SingleAnswerQuestion(
    "no",
    "What does this setting do? Choose from these options: ",
    "assets/images/messageControls.png",
    [
      "Updates who can tag you in their posts",
      "Updates who can see your posts",
      "Updates whether your account is private or public",
      "Allows you to block other users",
      "Updates where your message go"
    ],
    "explain",
    "Updates where your message go",
  ),
  const SingleAnswerQuestion(
    "no",
    "What does this setting do? Choose from these options: ",
    "assets/images/mentions.png",
    [
      "Updates who can tag you in their posts",
      "Updates who can see your posts",
      "Updates whether your account is private or public",
      "Allows you to block other users",
      "Updates where your message go"
    ],
    "explain",
    "Updates who can tag you in their posts",
  ),
  MultipleAnswersQuestion(
    "no",
    "On Instagram, why would you want to limit who can reply to your story? ",
    "no",
    [
      "textField"
    ],
    "explain",
    [],
  ),
  MultipleAnswersQuestion(
    "no",
    "On Instagram, why would you want to adjust where messages go (e.g., to the chat inbox or the message requests)?",
    "no",
    [
      "textField"
    ],
    "explain",
    [],
  ),
  MultipleAnswersQuestion(
    "no",
    "On Instagram, why would you want to set your social media account to private? ",
    "no",
    [
      "textField"
    ],
    "explain",
    [],
  ),
];
