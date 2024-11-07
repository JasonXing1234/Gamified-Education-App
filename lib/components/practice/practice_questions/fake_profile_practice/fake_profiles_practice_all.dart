import 'package:quiz/components/question.dart';

var fakeProfilesPracticeAll = [
  // Part 1
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. " + "\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does your friend know this person offline?",
    photo: "assets/images/fb_profile_1.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    photo: "assets/images/fb_profile_1.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Is this your friend's first connection request from this person?",
    photo: "assets/images/fb_profile_1.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does the profile have more than 50 friends and less than 2000 friends?",
    photo: "assets/images/fb_profile_1.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does your friend have 5 or more mutual friends with this account?",
    photo: "assets/images/fb_profile_1.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "This is what you know about the account so far.\n"
        "Does your friend know this person offline? : Yes\n"
        "Does the account have a profile picture and does your friend think it matches what they look like in person? : Yes\n"
        "Is this your friend's first connection request from this person? : Yes\n"
        "Does the profile have more than 50 friends and less than 2000 friends? : Yes\n"
        "Does your friend have 5 or more mutual friends with this account? : Yes\n",
    question: "Given this information, which recommendation would you give your friend about the request?",
    photo: "no",
    answerOptions: [
      "The account is most likely fake. Reject the request.",
      "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
      "The account might be fake. Since the person is not an acquaintance offline, ask a mentor about the request.",
      "The account is most likely real. You can choose to accept the request.",
    ],
    explanation: "explain",
    correctAnswer: "The account is most likely real. You can choose to accept the request.",
  ),

  // Part 2
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. They have not met this person offline. This is the first connection request they have received from this person.",
    question: "Does your friend know this person offline?",
    photo: "assets/images/fb_profile_2.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. They have not met this person offline. This is the first connection request they have received from this person.",
    question: "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    photo: "assets/images/fb_profile_2.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Is this your friend's first connection request from this person?",
    photo: "assets/images/fb_profile_2.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. They have not met this person offline. This is the first connection request they have received from this person.",
    question: "Does the profile have more than 50 friends and less than 2000 friends?",
    photo: "assets/images/fb_profile_2.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. They have not met this person offline. This is the first connection request they have received from this person.",
    question: "Does your friend have 5 or more mutual friends with this account?",
    photo: "assets/images/fb_profile_2.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "This is what you know about the account so far.\n"
        "Does your friend know this person offline? : No\n"
        "Does the account have a profile picture and does your friend think it matches what they look like in person? : No\n"
        "Is this your friend's first connection request from this person? : Yes\n"
        "Does the profile have more than 50 friends and less than 2000 friends? : Yes\n"
        "Does your friend have 5 or more mutual friends with this account? : Yes\n",
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

  // Part 3
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does not match the person they know. This is the first connection request they have received from this person.",
    question: "Does your friend know this person offline?",
    photo: "assets/images/fb_profile_3.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does not match the person they know. This is the first connection request they have received from this person.",
    question: "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    photo: "assets/images/fb_profile_3.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does not match the person they know. This is the first connection request they have received from this person.",
    question: "Is this your friend's first connection request from this person?",
    photo: "assets/images/fb_profile_3.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does not match the person they know. This is the first connection request they have received from this person.",
    question: "Does the profile have more than 50 friends and less than 2000 friends?",
    photo: "assets/images/fb_profile_3.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does not match the person they know. This is the first connection request they have received from this person.",
    question: "Does your friend have 5 or more mutual friends with this account?",
    photo: "assets/images/fb_profile_3.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "This is what you know about the account so far.\n"
        "Does your friend know this person offline? : Yes\n"
        "Does the account have a profile picture and does your friend think it matches what they look like in person? : No\n"
        "Is this your friend's first connection request from this person? : Yes\n"
        "Does the profile have more than 50 friends and less than 2000 friends? : Yes\n"
        "Does your friend have 5 or more mutual friends with this account? : Yes\n",
    question: "Given this information, which recommendation would you give your friend about the request?",
    photo: "no",
    answerOptions: [
      "The account is most likely fake. Reject the request.",
      "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
      "The account might be fake. Since the person is not an acquaintance offline, ask a mentor about the request.",
      "The account is most likely real. You can choose to accept the request.",
    ],
    explanation: "explain",
    correctAnswer: "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
  ),

  // Part 4
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request.\n"
        "They have not met this person offline. This is not the first connection request they have received from this person.",
    question: "Does your friend know this person offline?",
    photo: "assets/images/fb_profile_4.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request.\n"
        "They have not met this person offline. This is not the first connection request they have received from this person.",
    question: "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    photo: "assets/images/fb_profile_4.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request.\n"
        "They have not met this person offline. This is not the first connection request they have received from this person.",
    question: "Is this your friend's first connection request from this person?",
    photo: "assets/images/fb_profile_4.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request.\n"
        "They have not met this person offline. This is not the first connection request they have received from this person.",
    question: "Does the profile have more than 50 friends and less than 2000 friends?",
    photo: "assets/images/fb_profile_4.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request.\n"
        "They have not met this person offline. This is not the first connection request they have received from this person.",
    question: "Does your friend have 5 or more mutual friends with this account?",
    photo: "assets/images/fb_profile_4.png",
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
        "Is this your friend's first connection request from this person? : No\n"
        "Does the profile have more than 50 friends and less than 2000 friends? : No\n"
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
    correctAnswer: "The account is most likely fake. Reject the request.",
  ),

  // Part 5
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request.\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does your friend know this person offline?",
    photo: "assets/images/fb_profile_5.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request.\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    photo: "assets/images/fb_profile_5.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request.\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Is this your friend's first connection request from this person?",
    photo: "assets/images/fb_profile_5.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request.\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does the profile have more than 50 friends and less than 2000 friends?",
    photo: "assets/images/fb_profile_5.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request.\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does your friend have 5 or more mutual friends with this account?",
    photo: "assets/images/fb_profile_5.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "This is what you know about the account so far.\n"
        "Does your friend know this person offline? : Yes\n"
        "Does the account have a profile picture and does your friend think it matches what they look like in person? : Yes\n"
        "Is this your friend's first connection request from this person? : Yes\n"
        "Does the profile have more than 50 friends and less than 2000 friends? : Yes\n"
        "Does your friend have 5 or more mutual friends with this account? : Yes",
    question: "Given this information, which recommendation would you give your friend about the request?",
    photo: "no",
    answerOptions: [
      "The account is most likely fake. Reject the request.",
      "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
      "The account might be fake. Since the person is not an acquaintance offline, ask a mentor about the request.",
      "The account is most likely real. You can choose to accept the request.",
    ],
    explanation: "explain",
    correctAnswer: "The account is most likely real. You can choose to accept the request.",
  ),

  // Part 6
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request.\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does your friend know this person offline?",
    photo: "assets/images/fb_profile_6.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request.\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    photo: "assets/images/fb_profile_6.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request.\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Is this your friend's first connection request from this person?",
    photo: "assets/images/fb_profile_6.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request.\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does the profile have more than 50 friends and less than 2000 friends?",
    photo: "assets/images/fb_profile_6.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request.\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does your friend have 5 or more mutual friends with this account?",
    photo: "assets/images/fb_profile_6.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "This is what you know about the account so far.\n"
        "Does your friend know this person offline? : Yes\n"
        "Does the account have a profile picture and does your friend think it matches what they look like in person? : No\n"
        "Is this your friend's first connection request from this person? : No\n"
        "Does the profile have more than 50 friends and less than 2000 friends? : No\n"
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
    correctAnswer: "The account is most likely fake. Reject the request.",
  ),

  // Part 7
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. "
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does your friend know this person offline?",
    photo: "assets/images/fb_profile_7.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. "
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    photo: "assets/images/fb_profile_7.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. "
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Is this your friend's first connection request from this person?",
    photo: "assets/images/fb_profile_7.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. "
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does the profile have more than 50 friends and less than 2000 friends?",
    photo: "assets/images/fb_profile_7.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
    context: "You are helping someone decide whether or not to accept a friend request. "
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    question: "Does your friend have 5 or more mutual friends with this account?",
    photo: "assets/images/fb_profile_7.png",
    answerOptions: [
      "Yes",
      "No"
    ],
    explanation: "explain",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "This is what you know about the account so far.\n"
        "Does your friend know this person offline? : Yes\n"
        "Does the account have a profile picture and does your friend think it matches what they look like in person? : Yes\n"
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
    correctAnswer: "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
  ),

  // Part 8
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
