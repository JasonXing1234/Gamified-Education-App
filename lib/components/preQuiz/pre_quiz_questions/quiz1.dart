import '../../question.dart';

// TODO: Create explanations for correct answer

var quiz1 = [
  SingleAnswerQuestion(
    context: "no",
    question: "Is it appropriate to have more than one account on Instagram?",
    photo: "no",
    answerOptions: [
      "Yes",
      "No",
      "I don't know"
    ],
    explanation: "On Instagram you can create different accounts: Personal, Finsta, Business, Verified Celebrity/Influencer, or an interest/topic account.",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You see George Clooney's (celebrity) account on Instagram. The account has a blue checkmark (shown above) next to it. What type of account is this?",
    question: "What type of account is George Clooney's Instagram account with a blue checkmark?",
    photo: "assets/images/verifiedSymbol.png",
    answerOptions: [
      "Personal Account",
      "Alternate Personal Account (finista)",
      "Business Account",
      "Verified Celebrity or Influencer Account",
      "Top/Interest Account"
    ],
    explanation: "This is a Verified Celebrity or Influencer Account because of the blue checkmark.",
    correctAnswer: "Verified Celebrity or Influencer Account",
  ),
  SingleAnswerQuestion(
    context: "Your cousin created a second Instagram account just for their closest friends to follow. What type of account is this?",
    question: "What type of account is your cousin's second Instagram account for closest friends?",
    photo: "no",
    answerOptions: [
      "Personal Account",
      "Alternate Personal Account (finista)",
      "Business Account",
      "Verified Celebrity or Influencer Account",
      "Top/Interest Account"
    ],
    explanation: "This is an Alternate Personal Account (finsta), used for a smaller, more private group of followers.",
    correctAnswer: "Alternate Personal Account (finsta)",
  ),
  SingleAnswerQuestion(
    context: "You see the Target (store) account on Instagram. What type of account is this?",
    question: "What type of account is the Target store's Instagram account?",
    photo: "no",
    answerOptions: [
      "Personal Account",
      "Alternate Personal Account (finsta)",
      "Business Account",
      "Verified Celebrity or Influencer Account",
      "Top/Interest Account"
    ],
    explanation: "This is a Business Account, used to promote products and services.",
    correctAnswer: "Business Account",
  ),
  SingleAnswerQuestion(
    context: "You see an account on Instagram which only posts about Animal Crossing. What type of account is this?",
    question: "What type of account is the Animal Crossing-themed Instagram account?",
    photo: "no",
    answerOptions: [
      "Personal Account",
      "Alternate Personal Account (finsta)",
      "Business Account",
      "Verified Celebrity or Influencer Account",
      "Top/Interest Account"
    ],
    explanation: "This is a Top/Interest Account, focusing on a specific topic of interest.",
    correctAnswer: "Top/Interest Account",
  ),
  SingleAnswerQuestion(
    context: "You have an account on Instagram where you post photos of yourself and friends. What type of account is this?",
    question: "What type of Instagram account is used for posting photos of yourself and friends?",
    photo: "no",
    answerOptions: [
      "Personal Account",
      "Alternate Personal Account (finsta)",
      "Business Account",
      "Verified Celebrity or Influencer Account",
      "Top/Interest Account"
    ],
    explanation: "This is a Personal Account, typically used to share life updates with friends and family.",
    correctAnswer: "Personal Account",
  ),
  SingleAnswerQuestion(
    context: "If you wanted to, would it be appropriate to have more than one account on Facebook?",
    question: "Is it appropriate to have more than one account on Facebook?",
    photo: "no",
    answerOptions: [
      "Yes",
      "No",
      "I don't know"
    ],
    explanation: "Facebook's policy generally allows only one personal account per person.",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "(Fill in the blank) You can join a ___ where you can talk about your favorite video game with other Facebook users.",
    question: "What kind of Facebook group can you join to talk about video games?",
    photo: "no",
    answerOptions: [
      "Personal",
      "Group",
      "Page"
    ],
    explanation: "You can join a Group on Facebook to discuss topics of common interest, like a video game.",
    correctAnswer: "Group",
  ),
  SingleAnswerQuestion(
    context: "(Fill in the blank) Your mom sent you a friend request on Facebook. Her account is ___.",
    question: "What type of Facebook account is your mom's account?",
    photo: "no",
    answerOptions: [
      "Personal",
      "Group",
      "Page"
    ],
    explanation: "Your mom's account is a Personal account, which is typically used for connecting with friends and family.",
    correctAnswer: "Personal",
  ),
  SingleAnswerQuestion(
    context: "(Fill in the blank) Your favorite actor has a ____ where they post photos from behind the scenes of their show.",
    question: "What type of account does your favorite actor use for posting behind-the-scenes photos?",
    photo: "no",
    answerOptions: [
      "Personal",
      "Group",
      "Page"
    ],
    explanation: "Your favorite actor likely uses a Page to share public content like behind-the-scenes photos.",
    correctAnswer: "Page",
  ),
];