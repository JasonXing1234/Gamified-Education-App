import 'package:quiz/components/question.dart';

const fakeProfilesPracticeAll = [
  // Part 1
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. " + "\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does your friend know this person offline?",
    "assets/images/fb_profile_1.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    "assets/images/fb_profile_1.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Is this your friend's first connection request from this person?",
    "assets/images/fb_profile_1.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does the profile have more than 50 friends and less than 2000 friends?",
    "assets/images/fb_profile_1.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does your friend has 5 or more mutual friends with this account? ",
    "assets/images/fb_profile_1.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "This is what you know about the account so far."
        "Does your friend know this person offline? : Yes"
        "Does the account have a profile picture and does your friend think it matches what they look like in person? : Yes"
        "Is this your friend's first connection request from this person? : Yes"
        "Does the profile have more than 50 friends and less than 2000 friends? : Yes"
        "Does your friend has 5 or more mutual friends with this account?  : Yes",
    "Given this information, which recommendation would you give your friend about the request?",
    "no",
    [
      "The account is most likely fake. Reject the request.",
      "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
      "The account might be fake. Since the person is not an acquaintance offline, ask a mentor about the request.",
      "The account is most likely real. You can choose to accept the request.",
    ],
    "explain",
    "The account is most likely real. You can choose to accept the request.",
  ),

  // Part 2
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have not met this person offline. This is the first connection request they have received from this person.",
    "Does your friend know this person offline?",
    "assets/images/fb_profile_2.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have not met this person offline. This is the first connection request they have received from this person.",
    "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    "assets/images/fb_profile_2.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Is this your friend's first connection request from this person?",
    "assets/images/fb_profile_2.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have not met this person offline. This is the first connection request they have received from this person. ",
    "Does the profile have more than 50 friends and less than 2000 friends?",
    "assets/images/fb_profile_2.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have not met this person offline. This is the first connection request they have received from this person. ",
    "Does your friend has 5 or more mutual friends with this account? ",
    "assets/images/fb_profile_2.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "This is what you know about the account so far."
        "Does your friend know this person offline? : No"
        "Does the account have a profile picture and does your friend think it matches what they look like in person? : No"
        "Is this your friend's first connection request from this person? : Yes"
        "Does the profile have more than 50 friends and less than 2000 friends? : Yes"
        "Does your friend has 5 or more mutual friends with this account? : Yes",
    "Given this information, which recommendation would you give your friend about the request?",
    "no",
    [
      "The account is most likely fake. Reject the request.",
      "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
      "The account might be fake. Since the person is not an acquaintance offline, ask a mentor about the request.",
      "The account is most likely real. You can choose to accept the request.",
    ],
    "explain",
    "The account might be fake. Since the person is not an acquaintance offline, ask a mentor about the request.", //TODO: Not sure???????
  ),

  // Part 3
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does not match the person they know. This is the first connection request they have received from this person.",
    "Does your friend know this person offline?",
    "assets/images/fb_profile_3.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does not match the person they know. This is the first connection request they have received from this person.",
    "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    "assets/images/fb_profile_3.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does not match the person they know. This is the first connection request they have received from this person.",
    "Is this your friend's first connection request from this person?",
    "assets/images/fb_profile_3.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does not match the person they know. This is the first connection request they have received from this person.",
    "Does the profile have more than 50 friends and less than 2000 friends?",
    "assets/images/fb_profile_3.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does not match the person they know. This is the first connection request they have received from this person.",
    "Does your friend has 5 or more mutual friends with this account? ",
    "assets/images/fb_profile_3.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "This is what you know about the account so far."
        "Does your friend know this person offline? : Yes"
        "Does the account have a profile picture and does your friend think it matches what they look like in person? : No"
        "Is this your friend's first connection request from this person? : Yes"
        "Does the profile have more than 50 friends and less than 2000 friends? : Yes"
        "Does your friend has 5 or more mutual friends with this account?  : Yes",
    "Given this information, which recommendation would you give your friend about the request?",
    "no",
    [
      "The account is most likely fake. Reject the request.",
      "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
      "The account might be fake. Since the person is not an acquaintance offline, ask a mentor about the request.",
      "The account is most likely real. You can choose to accept the request.",
    ],
    "explain",
    "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
  ),

  // Part 4
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. " + "\n"
        "They have not met this person offline. This is not the first connection request they have received from this person.",
    "Does your friend know this person offline?",
    "assets/images/fb_profile_4.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. " + "\n"
        "They have not met this person offline. This is not the first connection request they have received from this person.",
    "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    "assets/images/fb_profile_4.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. " + "\n"
        "They have not met this person offline. This is not the first connection request they have received from this person.",
    "Is this your friend's first connection request from this person?",
    "assets/images/fb_profile_4.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. " + "\n"
        "They have not met this person offline. This is not the first connection request they have received from this person.",
    "Does the profile have more than 50 friends and less than 2000 friends?",
    "assets/images/fb_profile_4.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. " + "\n"
        "They have not met this person offline. This is not the first connection request they have received from this person.",
    "Does your friend has 5 or more mutual friends with this account? ",
    "assets/images/fb_profile_4.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "This is what you know about the account so far."
        "Does your friend know this person offline? : No"
        "Does the account have a profile picture and does your friend think it matches what they look like in person? : No"
        "Is this your friend's first connection request from this person? : No"
        "Does the profile have more than 50 friends and less than 2000 friends? : No"
        "Does your friend has 5 or more mutual friends with this account?  : No",
    "Given this information, which recommendation would you give your friend about the request?",
    "no",
    [
      "The account is most likely fake. Reject the request.",
      "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
      "The account might be fake. Since the person is not an acquaintance offline, ask a mentor about the request.",
      "The account is most likely real. You can choose to accept the request.",
    ],
    "explain",
    "The account is most likely fake. Reject the request.",
  ),

  // Part 5
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. " + "\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does your friend know this person offline?",
    "assets/images/fb_profile_5.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. " + "\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    "assets/images/fb_profile_5.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. " + "\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Is this your friend's first connection request from this person?",
    "assets/images/fb_profile_5.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. " + "\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does the profile have more than 50 friends and less than 2000 friends?",
    "assets/images/fb_profile_5.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. " + "\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does your friend has 5 or more mutual friends with this account? ",
    "assets/images/fb_profile_5.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "This is what you know about the account so far."
        "Does your friend know this person offline? : Yes"
        "Does the account have a profile picture and does your friend think it matches what they look like in person? : Yes"
        "Is this your friend's first connection request from this person? : Yes"
        "Does the profile have more than 50 friends and less than 2000 friends? : Yes"
        "Does your friend has 5 or more mutual friends with this account?  : Yes",
    "Given this information, which recommendation would you give your friend about the request?",
    "no",
    [
      "The account is most likely fake. Reject the request.",
      "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
      "The account might be fake. Since the person is not an acquaintance offline, ask a mentor about the request.",
      "The account is most likely real. You can choose to accept the request.",
    ],
    "explain",
    "The account is most likely real. You can choose to accept the request.",
  ),

  // Part 6
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. " + "\n"
        "They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does your friend know this person offline?",
    "assets/images/fb_profile_6.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    "assets/images/fb_profile_6.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Is this your friend's first connection request from this person?",
    "assets/images/fb_profile_6.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does the profile have more than 50 friends and less than 2000 friends?",
    "assets/images/fb_profile_6.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does your friend has 5 or more mutual friends with this account? ",
    "assets/images/fb_profile_6.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "This is what you know about the account so far."
        "Does your friend know this person offline? : Yes"
        "Does the account have a profile picture and does your friend think it matches what they look like in person? : No"
        "Is this your friend's first connection request from this person? : No"
        "Does the profile have more than 50 friends and less than 2000 friends? : No"
        "Does your friend has 5 or more mutual friends with this account?  : No",
    "Given this information, which recommendation would you give your friend about the request?",
    "no",
    [
      "The account is most likely fake. Reject the request.",
      "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
      "The account might be fake. Since the person is not an acquaintance offline, ask a mentor about the request.",
      "The account is most likely real. You can choose to accept the request.",
    ],
    "explain",
    "The account is most likely fake. Reject the request.",
  ),

  // Part 7
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does your friend know this person offline?",
    "assets/images/fb_profile_7.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    "assets/images/fb_profile_7.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Is this your friend's first connection request from this person?",
    "assets/images/fb_profile_7.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does the profile have more than 50 friends and less than 2000 friends?",
    "assets/images/fb_profile_7.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have met this person offline and the profile photo does match the person they know. This is the first connection request they have received from this person.",
    "Does your friend has 5 or more mutual friends with this account? ",
    "assets/images/fb_profile_7.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "This is what you know about the account so far."
        "Does your friend know this person offline? : Yes"
        "Does the account have a profile picture and does your friend think it matches what they look like in person? : Yes"
        "Is this your friend's first connection request from this person? : Yes"
        "Does the profile have more than 50 friends and less than 2000 friends? : Yes"
        "Does your friend has 5 or more mutual friends with this account?  : No",
    "Given this information, which recommendation would you give your friend about the request?",
    "no",
    [
      "The account is most likely fake. Reject the request.",
      "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
      "The account might be fake. Since the person is not an acquaintance offline, ask a mentor about the request.",
      "The account is most likely real. You can choose to accept the request.",
    ],
    "explain",
    "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
  ),

  // Part 8
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have not met this person offline. This is the first connection request they have received from this person.",
    "Does your friend know this person offline?",
    "assets/images/fb_profile_8.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have not met this person offline. This is the first connection request they have received from this person.",
    "Does the account have a profile picture and does your friend think it matches what they look like in person?",
    "assets/images/fb_profile_8.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have not met this person offline. This is the first connection request they have received from this person.",
    "Is this your friend's first connection request from this person?",
    "assets/images/fb_profile_8.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have not met this person offline. This is the first connection request they have received from this person.",
    "Does the profile have more than 50 friends and less than 2000 friends?",
    "assets/images/fb_profile_8.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "Yes",
  ),
  SingleAnswerQuestion(
    "You are helping someone decide whether or not to accept a friend request. They have not met this person offline. This is the first connection request they have received from this person.",
    "Does your friend has 5 or more mutual friends with this account? ",
    "assets/images/fb_profile_8.png",
    [
      "Yes",
      "No"
    ],
    "explain",
    "No",
  ),
  SingleAnswerQuestion(
    "This is what you know about the account so far."
        "Does your friend know this person offline? : No"
        "Does the account have a profile picture and does your friend think it matches what they look like in person? : No"
        "Is this your friend's first connection request from this person? : Yes"
        "Does the profile have more than 50 friends and less than 2000 friends? : Yes"
        "Does your friend has 5 or more mutual friends with this account?  : No",
    "Given this information, which recommendation would you give your friend about the request?",
    "no",
    [
      "The account is most likely fake. Reject the request.",
      "The account might be fake. Since the person is an acquaintance offline, ask that person about the request.",
      "The account might be fake. Since the person is not an acquaintance offline, ask a mentor about the request.",
      "The account is most likely real. You can choose to accept the request.",
    ],
    "explain",
    "The account might be fake. Since the person is not an acquaintance offline, ask a mentor about the request.",
  ),
];
