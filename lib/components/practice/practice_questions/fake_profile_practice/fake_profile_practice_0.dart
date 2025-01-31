import 'package:quiz/components/question.dart';



var fakeProfilesPractice0 = [
  SingleAnswerQuestion(
    context: "no",
    question: "Why might someone create a fake profile?",
    photo: "no",
    answerOptions: [
      "To trick people into giving them money",
      "To get personal pictures",
      "To get personal information from people",
      "All of the above",
    ],
    explanation: "People make fake profiles to take advantage of others in many ways.",
    correctAnswer: "All of the above",
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "Is it difficult to make a fake profile?",
    photo: "no",
    answerOptions: [
      "Yes",
      "No",
    ],
    explanation: "To make a fake profile, you only need a basic info to sign up. You don't need to prove who you are.",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "Cathy got a friend request from a profile that looks like it belongs to her best friend Maggie. Cathy thought that she was already Facebook friends with Maggie.",
    question: "Should Cathy accept the friend request?",
    photo: "no",
    answerOptions: [
      "Yes, it is safe for her to accept the friend request.",
      "Not yet. Cathy should verify that this profile actually belongs to Maggie, first.",
      "No. This profile definitely doesn't belong to Maggie.",
    ],
    explanation: "If you get multiple follow requests from the same person one of them is might be a fake profile, so it's good to check with the person.",
    correctAnswer: "Not yet. Cathy should verify that this profile actually belongs to Maggie, first.",
  ),
  SingleAnswerQuestion(
    context: "You get a follow request from someone on Instagram. The profile picture doesn't look like anyone you know, but the person looks nice.",
    question: "Is it safe to accept the follow request?",
    photo: "no",
    answerOptions: [
      "Yes. The person looks like they are nice, so it should be fine.",
      "Not yet. You should double-check to make sure the person is actually who they say they are first.",
      "No. It isn’t safe to accept follow requests from people you don’t know.",
    ],
    explanation: "If someone you don’t know is requesting to follow you, it may be a fake profile or someone who is trying to take advantage of you.",
    correctAnswer: "No. It isn’t safe to accept follow requests from people you don’t know.",
  ),
  SingleAnswerQuestion(
    context: "You get a friend request from a Youtuber that you like to watch.",
    question: "Is it safe to accept this friend request?",
    photo: "no",
    answerOptions: [
      "Yes. You know the Youtuber pretty well from their videos so you can trust the profile.",
      "Not yet. You should make sure that the profile actually belongs to the Youtuber.",
      "No. It isn’t safe to accept friend requests from people you don’t know in person.",
    ],
    explanation: "You don’t know the Youtuber personally, so it isn’t safe to accept their friend request.",
    correctAnswer: "No. It isn’t safe to accept friend requests from people you don’t know in person.",
  ),
  SingleAnswerQuestion(
    context: "Boris got a friend request from a profile that looks like his friend Joe, but has less than 50 Facebook friends. He wants to verify that the profile actually belongs to Joe.",
    question: "How should he check that this profile is really his friend?",
    photo: "no",
    answerOptions: [
      "He should dm the profile asking for proof that this is Joe.",
      "He should ask Joe in person or text Joe off the social media app to ask if the profile belongs to Joe.",
      "He should write a post asking if the profile belongs to Joe, then tag him.",
      "It is safe to accept the friend request. Boris doesn't need to verify with Joe.",
    ],
    explanation: "In order to verify that someone you know in person sent you a follow request, you need to contact them offline. If you contact them online, you might be messaging someone who is pretending to be someone you know. Offline is safer.",
    correctAnswer: "He should ask Joe in person or text Joe off the social media app to ask if the profile belongs to Joe.",
  ),
  SingleAnswerQuestion(
    context: "You get a follow request on Instagram. When you click on the profile, it says it belongs to your friend Benji, although the profile picture is of a mountain. The profile has 700 followers and is following 900 people. You have 23 mutual followers.",
    question: "Is it safe to accept the follow request?",
    photo: "no",
    answerOptions: [
      "Yes. The account looks like it is actually your friend.",
      "Not yet. You should talk to Benji to verify that it is actually his profile.",
      "No. The profile has too many red flags.",
    ],
    explanation: "If the profile picture doesn't look like the person, then it might be a fake profile.",
    correctAnswer: "Not yet. You should talk to Benji to verify that it is actually his profile.",
  ),
  SingleAnswerQuestion(
    context: "You get a friend request on Facebook. The profile picture is of your friend Melissa, but the name on the profile is Annie. You have 6 mutual friends and the account has 3735 friends. You look at your friends list and see that you are already friends with Melissa.",
    question: "Should you accept the friend request?",
    photo: "no",
    answerOptions: [
      "Yes. You know Melissa in person, so it is safe to accept a friend request from a profile with her photo.",
      "Not yet. You should check with Melissa to see if this is actually her account.",
      "No. This is probably a fake profile.",
    ],
    explanation: "If a profile meets less than 2 of the criteria, it is probably a fake profile.",
    correctAnswer: "No. This is probably a fake profile.",
  ),
  SingleAnswerQuestion(
    context: "Victor got a follow request on Instagram. The profile picture and name belong to his coworker Julia. He hasn’t ever gotten a follow request from her before. The profile is following 179 people and has 213 followers. They have 13 mutual followers. ",
    question: "Is it safe for Victor to accept this follow request?",
    photo: "no",
    answerOptions: [
      "Yes. Everything about this profile looks like it belongs to Julia.",
      "Not yet. Victor should ask Julia if she sent him a follow request.",
      "No. This profile is probably fake.",
    ],
    explanation: "If a profile meets all 5 criteria, it is safe to accept.",
    correctAnswer: "Yes. Everything about this profile looks like it belongs to Julia.",
  ),
  SingleAnswerQuestion(
    context: "Alison got a friend request from a profile that says it belongs to her cousin Thomas. It doesn’t have a profile picture, so she wants to make sure that the profile is real. She calls Thomas on the phone to ask if it is his profile.",
    question: "Is this a good way to verify that the profile is real?",
    photo: "no",
    answerOptions: [
      "Yes",
      "No",
    ],
    explanation: "In order to verify that someone you know in person sent you a follow request, you need to contact them offline. If you contact them online, you might be messaging someone who is pretending to be someone you know. Offline is safer.",
    correctAnswer: "Yes",
  ),
  MultipleAnswersQuestion(
    context: "no",
    question: "What are the signs that a profile is real? Check all that apply",
    photo: "no",
    answerOptions: [
      "You have met the person in real life",
      "The profile picture looks like the person",
      "The profile has a birthday on it",
      "The profile has more than 50 and less than 2,000 friends.",
      "You share 5 or more mutual friends with the profile.",
    ],
    explanation: "", //TODO: Link to reading with the criteria
    correctAnswers: [
      "You have met the person in real life",
      "The profile picture looks like the person",
      "The profile has more than 50 and less than 2,000 friends.",
      "You share 5 or more mutual friends with the profile.",
    ],
  ),
  SingleAnswerQuestion(
    context: "You got a follow request from a profile that says it belongs to your buddy Chad. The profile picture looks like Chad. The profile has 4192 followers. You have 37 mutual followers and it is your first follow request from this profile.",
    question: "Why should you verify that this account belongs to Chad?",
    photo: "no",
    answerOptions: [
      "You don’t have enough mutual friends.",
      "The profile photo doesn't look like Chad.",
      "The profile has too many followers",
      "You don’t know a person named Chad.",
    ],
    explanation: "If an account has less than 50 followers or more than 2000, it might be a fake profile.",
    correctAnswer: "The profile has too many followers",
  ),
  SingleAnswerQuestion(
    context: "no",
    question: "Why isn’t it safe to accept a follow request just because the name and picture match someone you know?",
    photo: "no",
    answerOptions: [
      "It isn’t safe to let people you know in person follow you on social media.",
      "Anybody could copy a name and picture off of the internet and create a fake profile to look like someone you know.",
      "It is safe to accept the follow request.",
    ],
    explanation: "There are more criteria that need to be met. A matching name and profile pic are a good sign, but somebody could easily copy that information to make an account.",
    correctAnswer: "Anybody could copy a name and picture off of the internet and create a fake profile to look like someone you know.",
  ),
  SingleAnswerQuestion(
    context: "You got a friend request. The profile picture and name look like your neighbor Mrs. Wilson. The profile had 328 friends and you have 7 mutual friends. However, you already have Mrs. Wilson in your friends list.",
    question: "Is it safe to accept the friend request?",
    photo: "no",
    answerOptions: [
      "Yes. The account looks like it is real.",
      "Not yet. You should ask Mrs. Wilson if she sent you this friend request first.",
      "No. You should reject the friend request.",
    ],
    explanation: "If you get multiple friend requests that look like they are from the same person, it is likely that one of them is a fake profile.",
    correctAnswer: "Not yet. You should ask Mrs. Wilson if she sent you this friend request first.",
  ),
  SingleAnswerQuestion(
    context: "You got a friend request from Mara, but want to double-check that the profile actually belongs to her.",
    question: "Should you message her over social media to ask her?",
    photo: "no",
    answerOptions: [
      "Yes",
      "No",
    ],
    explanation: "In order to verify that someone you know in person sent you a follow request, you need to contact them offline. If you contact them online, you might be messaging someone who is pretending to be someone you know. Offline is safer.",
    correctAnswer: "No",
  ),

  //TODO: Finish: just did question 15, next one to add is 16




];