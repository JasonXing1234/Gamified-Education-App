import 'package:quiz/models/question.dart';

// TODO: Put in correct answers
// TODO: Not sure how to do the text field questions

const quiz2 = [
  SingleAnswerQuestion(
    'no',
    'What does this setting do? Choose from this options',
    'assets/images/blocking.png',
    [
      'Updates who can tag you in their posts',
      'Updates who can see your posts',
      'Updates whether your account is private or public',
      'Allows you to block other users',
      'Updates where your message go'
    ],
    0,
  ),
  SingleAnswerQuestion(
    'no',
    'What does this setting do? Choose from these options: ',
    'assets/images/posts.png',
    [
      'Updates who can tag you in their posts',
      'Updates who can see your posts',
      'Updates whether your account is private or public',
      'Allows you to block other users',
      'Updates where your message go'
    ],
    0,
  ),
  TextFieldQuestion(
    'no',
    'Why would you want to limit who can tag you in posts, stories, and comments?',
    'no',
    [
      'textField'
    ],
    [],
  ),
  TextFieldQuestion(
    'no',
    'Why would you want to block another user?',
    'no',
    [
      'textField'
    ],
    [],
  ),
  SingleAnswerQuestion(
    'no',
    'What does this setting do? Choose from these options: ',
    'no',
    [
      'Updates who can tag you in their posts',
      'Updates who can see your posts',
      'Updates whether your account is private or public',
      'Allows you to block other users',
      'Updates where your message go'
    ],
    0,
  ),
  SingleAnswerQuestion(
    'no',
    'You have an account on Instagram where you post photos of yourself and friends. What type of account is this? ',
    'no',
    [
      'Personal Account',
      'Alternate Personal Account (finista)',
      'Business Account',
      'Verified Celebrity or Influencer Account',
      'Top/Interest Account'
    ],
    0,
  ),
  SingleAnswerQuestion(
    'no',
    'What does this setting do? Choose from these options: ',
    'assets/images/messageControls.png',
    [
      'Personal Account',
      'Alternate Personal Account (finista)',
      'Business Account',
      'Verified Celebrity or Influencer Account',
      'Top/Interest Account'
    ],
    0,
  ),
  SingleAnswerQuestion(
    'no',
    'What does this setting do? Choose from these options: ',
    'assets/images/mentions.png',
    [
      'Personal Account',
      'Alternate Personal Account (finista)',
      'Business Account',
      'Verified Celebrity or Influencer Account',
      'Top/Interest Account'
    ],
    0,
  ),
  TextFieldQuestion(
    'no',
    'On Instagram, why would you want to limit who can reply to your story? ',
    'no',
    [
      'textField'
    ],
    [],
  ),
  TextFieldQuestion(
    'no',
    'On Instagram, why would you want to adjust where messages go (e.g., to the chat inbox or the message requests)?',
    'no',
    [
      'textField'
    ],
    [],
  ),
  TextFieldQuestion(
    'no',
    'On Instagram, why would you want to set your social media account to private? ',
    'no',
    [
      'textField'
    ],
    [],
  ),
];
