import 'package:quiz/components/question.dart';

var settingsPractice = [
  SingleAnswerQuestion(
    context: "no",
    question: "Do the default settings on social media sites keep your information very private?",
    photo: "no",
    answerOptions: [
      "Yes",
      "No",
      "I don’t know"
    ],
    explanation: "A lot of social media sites default to public settings.",
    correctAnswer: "No",
  ),
  MultipleAnswersQuestion(
    context: "no",
    question: "How can you keep your information on social media more private? Check all that apply:",
    photo: "no",
    answerOptions: [
      "Go to your privacy settings and make them more private.",
      "Limit the people who can see your posts to just your friends.",
      "Make your accounts public",
      "Accept every friend request you get",
    ],
    explanation: "Users can alter various settings to be more private.",
    correctAnswers: [
      "Go to your privacy settings and make them more private.",
      "Limit the people who can see your posts to just your friends.",
    ],
  ),
  SingleAnswerQuestion(
    context: "Sarah is worried about using social media because she doesn’t want strangers to be able to see her posts on Facebook or Instagram.",
    question: "What can she do to keep strangers from seeing her posts?",
    photo: "no",
    answerOptions: [
      "Sarah can email Facebook and Instagram to say that she wants her information to be private.",
      "Sarah can write a post that says she only wants her friends and family to read her posts.",
      "Sarah can write all her posts in a secret language that only her friends know.",
      "Sarah can go to the settings tab and change her privacy settings.",
    ],
    explanation: "The best way to have a more private social media account is to change your settings to be more private.",
    correctAnswer: "Sarah can go to the settings tab and change her privacy settings.",
  ),
  MultipleAnswersQuestion(
    context: "no",
    question: "Why is it dangerous to have your social media profile set to public? Check all that apply.",
    photo: "no",
    answerOptions: [
      "Strangers and people you don’t trust can see your posts and personal information that you put online",
      "Bad people might try to use your information to pretend to be you online.",
      "You might have more followers/Facebook friends.",
      "Strangers might try to message you about giving them money.",
    ],
    explanation: "Since anyone can make a social media profile, having your profile set to public allows anyone, including bad people, to see your posts, look up your online information, and send you messages.",
    correctAnswers: [
      "Strangers and people you don’t trust can see your posts and personal information that you put online",
      "Bad people might try to use your information to pretend to be you online.",
      "Strangers might try to message you about giving them money.",
    ],
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "Who can see your Facebook posts?",
    photo: "no",
    answerOptions: [
      "Anyone",
      "Just your friends and family",
      "All of your Facebook friends",
      "All of the above are settings you can choose on Facebook.",
    ],
    explanation: "Depending on your settings, anyone could see your Facebook profile. The more private your settings, the few people can see your posts.",
    correctAnswer: "All of the above are settings you can choose on Facebook.",
  ),
  SingleAnswerQuestion(
    //TODO: Question 6: this is very wordy
    context: "Gavin looks at his Facebook posts and notices that there is a stranger who keeps leaving comments that he doesn't like.",
    question: "What can Gavin do to stop getting these comments?",
    photo: "no",
    answerOptions: [
      "Gavin can go to his settings, click on the public content tab, and change his settings so that only his Facebook friends can comment on his posts.",
      "Gavin can reply to the comments and tell the person to stop commenting on his post.",
      "Gavin can’t do anything to stop this person from commenting on his posts."
    ],
    explanation: "There are privacy settings on Facebook that let you control who can comment on your posts.",
    correctAnswer: "Gavin can go to his settings, click on the public content tab, and change his settings so that only his Facebook friends can comment on his posts.",
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "What does it mean if someone tags you in one of their posts on Facebook?",
    photo: "no",
    answerOptions: [
      "They want to be your Facebook Friend",
      "They have added you to a Facebook group.",
      "They added a link to your profile on their post that will make it pop up on your timeline."
      "They are sending you a private message.",
    ],
    explanation: "Linking someone’s profile to a post or photo is called “tagging”.",
    correctAnswer: "They added a link to your profile on their post that will make it pop up on your timeline.",
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "What is active status on Facebook?",
    photo: "no",
    answerOptions: [
      "A green light next to your profile that turns on and lets people know that you are online.",
      "An account that has been used within the past year.",
      "A steak of how many days you have logged in to Facebook",
    ],
    explanation: "Facebook can show other users that you are currently online.",
    correctAnswer: "A green light next to your profile that turns on and lets people know that you are online.",
  ),
  SingleAnswerQuestion(
    context: "Jenny has a Facebook Friend who has been sending her mean messages online. he doesn’t want to see any message from this person anymore.",
    question: "What should Jenny do?",
    photo: "no",
    answerOptions: [
      "Ignore all of the mean person’s messages instead of changing any settings.",
      "Block the person on Facebook so she doesn't have to see any more of the messages.",
      "Send a complaint about the person to Facebook",
      "Do nothing"
    ],
    explanation: "Facebook has some settings that allow users to stop seeing posts they don’t want to see. If you don’t want to see posts from someone for a few days, you can limit their posts. If you don’t want to see their posts ever again, you can block them.",
    correctAnswer: "Block the person on Facebook so she doesn't have to see any more of the messages.",
  ),
  SingleAnswerQuestion(
    //TODO: Question 10 changed the wording of the answer
    context: "no",
    question: "What does it mean to block someone on Facebook?",
    photo: "no",
    answerOptions: [
      "Rejecting a friend request",
      "Leaving a group on Facebook",
      "Ghosting someone online",
      "Preventing someone from messaging you and seeing your posts",
    ],
    explanation: "Facebook has some settings that allow users to stop seeing posts they don’t want to see. If you don’t want to see posts from someone for a few days, you can limit their posts. If you don’t want to see their posts ever again, you can block them.",
    correctAnswer: "Preventing someone from messaging you and seeing your posts",
  ),
  MultipleAnswersQuestion(
    context: "no",
    question: "Who can you block on Facebook? Check all that apply:",
    photo: "no",
    answerOptions: [
      "Yourself",
      "Strangers",
      "Facebook Friends",
      "Acquaintances"
    ],
    explanation: "Facebook will allow you to block any other user.",
    correctAnswers: [
      "Strangers",
      "Facebook Friends",
      "Acquaintances",
    ],
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "What does it mean to have a private social media account?",
    photo: "no",
    answerOptions: [
      "No one can see your profile unless you send them a link.",
      "You can't see any public accounts on your feed.",
      "Only your followers/friends can see your online posts",
      "Anyone can see your posts",
    ],
    explanation: "Public accounts let any user see your account. Private accounts only let people you have accepted as followers see posts on your account.",
    correctAnswer: "Only your followers/friends can see your online posts",
  ),
  SingleAnswerQuestion(
    //TODO: Question 13: changed answer option for no
    context: "no",
    question: "Does having a private account mean that no one can see your personal information?",
    photo: "no",
    answerOptions: [
      "Yes. It hides all of the information on your account from strangers",
      "No. Some information must be manually hidden through other privacy settings",
    ],
    explanation: "There are lots of specific privacy settings that are separate from having a private account. Some can control who sees your stories, who sees your posts, and who can message you, as well as other things.",
    correctAnswer: "No. Some information must be manually hidden through other privacy settings",
  ),
  SingleAnswerQuestion(
    context: "Matt has been getting Instagram messages from people he doesn't know. Matt is confused because his account is private.",
    question: "How come Matt is still getting these messages?",
    photo: "no",
    answerOptions: [
      "There is a glitch in Instagram’s system that let these messages get through.",
      "There is a different setting that controls who can send you messages.",
      "Matt has the wrong type of account. Strangers couldn't message him if he had a public account."
    ],
    explanation: "There are lots of specific privacy settings that are separate from having a private account. Some can control who sees your stories, who sees your posts, and who can message you, as well as other things.",
    correctAnswer: "There is a different setting that controls who can send you messages.",
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "Can strangers respond to stories on Instagram if you have a public account?",
    photo: "no",
    answerOptions: [
      "Yes",
      "No",
    ],
    explanation: "There are lots of specific privacy settings that are separate from having a private account. Some can control who sees your stories, who sees your posts, and who can message you, as well as other things.",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "Is it safe to let strangers see your Instagram stories?",
    photo: "no",
    answerOptions: [
      "Yes",
      "No",
    ],
    explanation: "Since anyone can make a social media profile, having your profile set to public allows anyone, including bad people, to see your posts, look up your online information, and send you messages.",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "question",
    photo: "no",
    answerOptions: [
      "Yes",
      "No",
      "I don’t know"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "Linda was tagged in an Instagram post about makeup by someone she doesn't know. She doesn't want that to happen again.",
    question: "What should Linda do?",
    photo: "no",
    answerOptions: [
      "Send a message to Instagram complaining about this situation.",
      "Ignore notifications that say she has been tagged in posts.",
      "Go to her settings and change them so only people she follows can tag her."
    ],
    explanation: "Instagram has a privacy setting that lets you control who can tag you in posts.",
    correctAnswer: "Go to her settings and change them so only people she follows can tag her.",
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "Are you able to filter out topics you aren’t interested in hearing about on Instagram?",
    photo: "no",
    answerOptions: [
      "Yes",
      "No",
    ],
    explanation: "Instagram has a setting that allows you to block any posts that contain phrases/words that you don’t want to see.",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "Are you able to block users on Instagram?",
    photo: "no",
    answerOptions: [
      "Yes",
      "No",
      "I don’t know"
    ],
    explanation: "Instagram and Facebook allow you to block other users.",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "Which kind of social media account keeps your information safer?",
    photo: "no",
    answerOptions: [
      "Private account",
      "Public account",
    ],
    explanation: "Public accounts allow anyone to see the information on your account, including bad people.",
    correctAnswer: "Private account",
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "Heather has public accounts on Instagram and Facebook. This means that:",
    photo: "no",
    answerOptions: [
      "Heather can see and comment on anyone’s posts",
      "Heather’s stories can only be seen by her followers.",
      "Anyone can see Heather’s posts and stories",
      "Heather can’t block anyone.",
    ],
    explanation: "Public accounts allow anyone to see the information on your account.",
    correctAnswer: "Anyone can see Heather’s posts and stories",
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "Xander doesn't want people to be able to see his age on Facebook. To hide that information, he should:",
    photo: "no",
    answerOptions: [
      "Make a private account",
      "Change his settings so that no one can see his age",
      "Create a fake profile",
    ],
    explanation: "A private account doesn't automatically hide all of your information. To hide specific information, you need to change that specific setting.",
    correctAnswer: "Change his settings so that no one can see his age",
  ),
  SingleAnswerQuestion(
    context: "It is election season, so a lot of people Jade follows are posting political things. Jade doesn't want to see posts from these people until after the election is over.",
    question: "How can Jade do this on Instagram?",
    photo: "no",
    answerOptions: [
      "Jade can block these users.",
      "Jade can go to her settings and limit posts from these people for however long she wants.",
      "Jade can unfollow these users.",
      "Jade can report these accounts.",
    ],
    explanation: "On Facebook and Instagram, you can choose to stop seeing posts for some period of time. This is called limiting.",
    correctAnswer: "Jade can go to her settings and limit posts from these people for however long she wants.",
  ),
  SingleAnswerQuestion(
    //TODO Question 24: Edited wording
    context: "no",
    question: "How are blocking and limiting different on Instagram?",
    photo: "no",
    answerOptions: [
      "Blocking stops a person from commenting on and seeing your account. Limiting allows you remove person's posts from your feed for a certain amount of time.",
      "Blocking stops you from seeing a person’s posts for a certain amount of time. Limiting stops a person from commenting on and seeing your account.",
      "Blocking prevents another person from logging in. Limiting sets the number of logins attempt allowed on your account."
    ],
    explanation: "Blocking is permanent, limiting is temporary.",
    correctAnswer: "Blocking stops a person from commenting on and seeing your account. Limiting allows you remove person's posts from your feed for a certain amount of time.",
  ),
  SingleAnswerQuestion(
    context: "Henry hates the word 'moist'. It makes him feel sick when he sees it. Henry wants to make sure he doesn't see any comments that use the word 'moist' on his posts.",
    question: "How can Henry make that happen?",
    photo: "no",
    answerOptions: [
      "Henry can make a post explaining why he doesn't like the word and ask people not to use it.",
      "Henry can block anyone who uses the word.",
      "Henry can go to his settings and make moist a 'hidden word' so that those comments will be filtered out."
    ],
    explanation: "Instagram will hide posts that contain 'hidden words'. You can set hidden words under settings.",
    correctAnswer: "Henry can go to his settings and make moist a 'hidden word' so that those comments will be filtered out."
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "True or False: The privacy settings and features on Instagram and Facebook are the same.",
    photo: "no",
    answerOptions: [
      "True",
      "False",
    ],
    explanation: "Different social media platforms have different features and settings.",
    correctAnswer: "False",
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "Can strangers respond to your stories on Facebook if you have a public account?",
    photo: "no",
    answerOptions: [
      "Yes",
      "No",
    ],
    explanation: "Anyone can see and interact with a public account.",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "You blocked Amy on Facebook. Can Amy see your new posts?",
    photo: "no",
    answerOptions: [
      "Yes",
      "No",
    ],
    explanation: "Blocking someone on a social media platform prevents people from seeing content you post on the platform.",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "Merle has a private account but wants his family to see his posts. ",
    question: "Will they be able to see them?",
    photo: "no",
    answerOptions: [
      "Yes, all of Merle’s family can see his posts.",
      "All of Merle’s family who have connected with him on social media can see his posts.",
      "No, Merle has a private account so no one can see his posts."
    ],
    explanation: "A private account allows people you have connected with online to see your posts.",
    correctAnswer: "All of Merle’s family who have connected with him on social media can see his posts.",
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "Pedro limited Andrea's posts for two weeks. What does this mean?",
    photo: "no",
    answerOptions: [
      "Andrea can’t send Pedro personal messages for two weeks.",
      "Pedro won’t see Andrea’s posts for two weeks.",
      "Andrea won’t see Pedro’s posts for two weeks.",
      "Pedro unfollowed Andrea.",
    ],
    explanation: "On Facebook and Instagram, you can choose to stop seeing posts for some period of time. This is called limiting.",
    correctAnswer: "Pedro won’t see Andrea’s posts for two weeks.",
  ),
];