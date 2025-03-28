import 'package:quiz/components/question.dart';

var fakeProfilesPractice8 = [
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. "
        "They have not met this person offline. This is the first connection request they have received from this person.",
    question: "Does your friend know this person offline?",
    photo: "assets/images/fb_profile_8.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. "
        "They have not met this person offline. This is the first connection request they have received from this person.",
    question: "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    photo: "assets/images/fb_profile_8.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. "
        "They have not met this person offline. This is the first connection request they have received from this person.",
    question: "Is this your friend's first connection request from this person?",
    photo: "assets/images/fb_profile_8.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. "
        "They have not met this person offline. This is the first connection request they have received from this person.",
    question: "Does the profile have more than 50 friends and less than 2000 friends?",
    photo: "assets/images/fb_profile_8.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. "
        "They have not met this person offline. This is the first connection request they have received from this person.",
    question: "Does your friend have 5 or more mutual friends with this account?",
    photo: "assets/images/fb_profile_8.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "This is what you know about the account so far.\n"
        "Does your friend know this person offline? : No\n"
        "Does the account have a profile picture and does your friend think it matches what they look like in person? : No\n"
        "Is this your friend's first connection request from this person? : Yes\n"
        "Does the profile have more than 50 friends and less than 2000 friends? : Yes\n"
        "Does your friend have 5 or more mutual friends with this account? : No",
    question: "Given this information, which recommendation would you give your friend about the request?",
    photo: "no",
    answerOptions: [
      "The account is most likely fake. Reject the request.",
      "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
      "The account might be fake. Since the person is not an acquaintance offline, ask a mentor about the request.",
      "The account is most likely real. You can choose to accept the request.",
    ],
    explanation: "explain",
    correctAnswer: "The account might be fake. Since the person is not an acquaintance offline, ask a mentor about the request.",
  ),
];
