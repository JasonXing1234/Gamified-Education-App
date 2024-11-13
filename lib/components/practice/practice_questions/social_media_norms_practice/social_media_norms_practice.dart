import 'package:quiz/components/question.dart';

var socialMediaNormsPractice = [
  SingleAnswerQuestion(
    context: "Your friend wants to make a second personal account on Facebook to post memes on. "
        "Is it ok for your friend to do that?",
    question: "Is it ok for your friend to make a second personal account on Facebook?",
    photo: "no",
    answerOptions: [
      "Yes",
      "No",
      "I don’t know"
    ],
    explanation: "Facebook has rules against making multiple accounts.",
    correctAnswer: "No",
  ),
  SingleAnswerQuestion(
    context: "Who is able to make a social media account?",
    question: "Who is allowed to make a social media account?",
    photo: "no",
    answerOptions: [
      "People who are older than 13",
      "Trustworthy people",
      "People that pass a background check",
      "Anyone",
    ],
    explanation: "It is easy for anyone to make a social media account.",
    correctAnswer: "Anyone",
  ),
  SingleAnswerQuestion(
    context: "Jill has an Instagram account where she posts pictures of her dog for a small "
        "group of her friends to see. What kind of account is this?",
    question: "What kind of Instagram account does Jill have?",
    photo: "no",
    answerOptions: [
      "Top/Interest Account",
      "Alternate Personal Account (finista)",
      "Page",
      "Verified Celebrity or Influencer Account",
    ],
    explanation: "People use alternate personal accounts to post for a smaller group of friends.",
    correctAnswer: "Alternate Personal Account (finista)",
  ),
  SingleAnswerQuestion(
    context: "What is a social media norm?",
    question: "What does the term 'social media norm' refer to?",
    photo: "no",
    answerOptions: [
      "A way that people typically use social media",
      "A popup ad",
      "Business Account",
      "A guy on social media whose name is Norman",
      "A post on social media"
    ],
    explanation: "Norms are the way something is typically done.",
    correctAnswer: "A way that people typically use social media",
  ),
  SingleAnswerQuestion(
    context: "Which kind of Facebook account allows strangers to discuss common interests?",
    question: "Which kind of Facebook account is designed for strangers to interact?",
    photo: "no",
    answerOptions: [
      "Personal",
      "Page",
      "Facebook messenger",
      "Group",
    ],
    explanation: "Groups are designed for strangers with common interests to interact with each other.",
    correctAnswer: "Group",
  ),
  SingleAnswerQuestion(
    context: "You see a post from McDonalds on Instagram. What kind of account is this?",
    question: "What kind of account is McDonald's Instagram post from?",
    photo: "no",
    answerOptions: [
      "Business Account",
      "Personal Account",
      "Alternate Personal Account (finista)",
      "Page",
    ],
    explanation: "Business accounts are used to promote products, and McDonalds is a business that promotes products.",
    correctAnswer: "Business Account",
  ),
  SingleAnswerQuestion(
    context: "Your cousin wants to make a second Instagram account to promote their music. "
        "Is it ok to make multiple personal accounts on Instagram?",
    question: "Is it okay to make multiple personal accounts on Instagram?",
    photo: "no",
    answerOptions: [
      "Yes",
      "No",
      "I don't know",
    ],
    explanation: "Instagram allows users to have multiple accounts.",
    correctAnswer: "Yes",
  ),
  SingleAnswerQuestion(
      context: "no",
      question: "Are you able to see who made a Facebook page or group?",
      photo: "no",
      answerOptions: [
        "Yes",
        "No",
        "Only if they choose to put that information on the group",
      ],
      explanation: "Facebook makes it so users can see what user created a group or page.",
      correctAnswer: "Yes"
  ),
  SingleAnswerQuestion(
      context: "no",
      question: "Are you always able to see who made an Instagram account?",
      photo: "no",
      answerOptions: [
        "Yes",
        "No",
        "Only if the creator chooses to put that information on the account"
      ],
      explanation: "Instagram doesn't say who created an account.",
      correctAnswer: "Only if the creator chooses to put that information on the account"
  ),
  SingleAnswerQuestion(
    //TODO: Question 10 -> Work on simplifying more
      context: "You log on to Instagram and see the profile of one of your friends "
          "on school. You would like to follow them and see their posts.",
      question: "Would following their account be a social media norm?",
      photo: "no",
      answerOptions: [
        "Yes, it is normal to follow people that you know in real life and that you want to follow on social media.",
        "No, it is not normal to follow people on social media.",
        "Yes, it is normal to follow everyone you know on social media.",
        "No, it is not normal to follow classmates on social media.",
      ],
      explanation: "It is common to follow people that you know in real life.",
      correctAnswer: "Yes, it is normal to follow people that you know in real life and that you want to follow on social media."
  ),
  MultipleAnswersQuestion(
      context: "Your sister is new to Facebook. She really likes musicals and wants to discuss musicals with other people with similar interests.",
      question: "How can she do that on Facebook? Choose all that apply.",
      photo: "no",
      answerOptions: [
        "She can make a secondary personal account where she only posts about musicals.",
        "She can join a Facebook group that is about musicals.",
        "She can create a Facebook group that is about musicals for others to join.",
        "She can follow a Facebook page that posts the times of upcoming musicals.",
      ],
      explanation: "Groups allow people with similar interests to interact on Facebook.",
      correctAnswers: [
        "She can join a Facebook group that is about musicals.",
        "She can create a Facebook group that is about musicals for others to join.",
      ],
  ),
  SingleAnswerQuestion(
      context: "You are on Instagram and see an account that has a blue checkmark.",
      question: "What does the blue checkmark mean?",
      photo: "assets/images/verifiedSymbol.png",
      answerOptions: [
        "The account has been around for 10 years.",
        "The account is a verified celebrity/influencer account.",
        "The account belongs to someone you know.",
        "The account belongs to a business.",
      ],
      explanation: "Instagram puts blue checkmarks on accounts that belong to celebrities and influencers.",
      correctAnswer: "The account is a verified celebrity/influencer account.",
  ),
  SingleAnswerQuestion(
      context: "One of your friends likes basketball, so they follow a basketball fan account on Instagram. ",
      question: "What kind of account is this?",
      photo: "no",
      answerOptions: [
        "Personal Account",
        "Business Account",
        "Alternate Personal Account (finista)",
        "Topic/Interest Account",
      ],
      explanation: "The account is about a topic/interest and isn’t a personal account.",
      correctAnswer: "Topic/Interest Account"
  ),
  SingleAnswerQuestion(
      context: "You want to create a group on Facebook so that you can discuss your interests with people who have similar interests.",
      question: "Will people be able to see that you made the group?",
      photo: "no",
      answerOptions: [
        "Yes",
        "No",
        "Only if you have that setting turned on"
      ],
      explanation: "Facebook allows users to see whoever created a group or page.",
      correctAnswer: "Yes"
  ),
  SingleAnswerQuestion(
    // TODO: Original question 15 is worded funny -> How does this version sound
      context: "You got a friend request on Facebook from someone that you have never met.",
      question: "Is it normal to accept the friend request?",
      photo: "no",
      answerOptions: [
        "Yes",
        "No",
      ],
      explanation: "It is NOT normal to accept a friend request from someone you don't know.",
      correctAnswer: "No"
  ),
  SingleAnswerQuestion(
      context: "Your friend created a fan account on Instagram for a TV show that they like.",
      question: "Will anyone be able to tell that your friend made the account?",
      photo: "no",
      answerOptions: [
        "Yes. Your friend’s personal account will be associated with the fan account.",
        "No. People will not be able to see that your friend made the account.",
      ],
      explanation: "Instagram accounts don’t say who created them.",
      correctAnswer: "No. People will not be able to see that your friend made the account."
  ),
  SingleAnswerQuestion(
      context: "no",
      question: "What does it mean if someone sends you a Friend request on Facebook?",
      photo: "no",
      answerOptions: [
        "They are asking to be your friend in real life.",
        "They are asking to connect with you so that they can see your posts and you can see their posts on Facebook.",
        "They are asking to chat online."
      ],
      explanation: "Facebook calls users that follow each other 'friends', but that is NOT the same as being friends in real life.",
      correctAnswer: "They are asking to connect with you so that they can see your posts and you can see their posts on Facebook."
  ),
  MultipleAnswersQuestion(
      context: "no",
      question: "What can you do with a personal Facebook account? Check all that apply.",
      photo: "no",
      answerOptions: [
        "You can share posts from other people",
        "You can write posts for your Facebook friends to see.",
        "You can make a website",
        "You can make a secondary account",
      ],
      explanation: "Personal accounts allow you to post and for you to view posts from people you follow.",
      correctAnswers: [
        "You can share posts from other people",
        "You can write posts for your Facebook friends to see."
      ],
  ),
  SingleAnswerQuestion(
      context: "no",
      question: "What kind of account do you make when you first start Facebook?",
      photo: "no",
      answerOptions: [
        "Group",
        "Personal",
        "Page"
      ],
      explanation: "When you first create an account with Facebook, it will only let you create a personal account.",
      correctAnswer: "Personal"
  ),
  SingleAnswerQuestion(
      context: "Henry wants to sell wristbands on Instagram.",
      question: "What sort of account should he make?",
      photo: "no",
      answerOptions: [
        "Alternate Personal Account (finista)",
        "Personal Account",
        "Topic/Interest Account",
        "Business Account",
      ],
      explanation: "Henry is going to be promoting and selling products, so he should use an account that allows that.",
      correctAnswer: "Business Account",
  ),
  SingleAnswerQuestion(
      context: "no",
      question: "Which social media site is it more common to post photos/videos on?",
      photo: "no",
      answerOptions: [
        "Instagram",
        "Facebook",
      ],
      explanation: "Instagram is primarily used for sharing your own non-text content.",
      correctAnswer: "Instagram"
  ),
  SingleAnswerQuestion(
      context: "no",
      question: "On which social media site is it more common to repost things that other people posted?",
      photo: "no",
      answerOptions: [
        "Instagram",
        "Facebook",
      ],
      explanation: "It is more common to share other posts on Facebook than it is on Instagram.",
      correctAnswer: "Facebook",
  ),
  SingleAnswerQuestion(
      context: "no",
      question: "Is it normal to follow a celebrity/influencer on Instagram?",
      photo: "no",
      answerOptions: [
        "Yes",
        "No",
      ],
      explanation: "It is normal to follow accounts that you are interested in on Instagram, even if you don’t know the person who made the account.",
      correctAnswer: "Yes"
  ),
  SingleAnswerQuestion(
      context: "Denise wants to be able to post announcements about neighborhood "
          "activities on Facebook, but doesn't want to post them on her personal account.",
      question: "What kind of account should she post them on?",
      photo: "no",
      answerOptions: [
        "Page",
        "Group",
        "Personal"
      ],
      explanation: "Facebook pages are primarily used to share information like announcements.",
      correctAnswer: "Page"
  ),
  SingleAnswerQuestion(
    //TODO: Question 25: These are long answer options
      context: "You made a post in a Facebook group and see that some people that you don’t know have commented on your post.",
      question: "Is this normal?",
      photo: "no",
      answerOptions: [
        "Yes. Facebook groups are interactive, so people often respond to posts and comments in groups, even to people they don’t know in person.",
        "No. Facebook groups are meant to share announcements and updates, not to have conversations.",
        "No. Facebook groups are interactive, but people usually only respond to others that they know in real life."
      ],
      explanation: "People can join Facebook groups to discuss common interests with others, even if they are strangers.",
      correctAnswer: "Yes. Facebook groups are interactive, so people often respond to posts and comments in groups, even to people they don’t know in person."
  ),
  SingleAnswerQuestion(
      context: "You see that someone who is not your Facebook friend has been responding to posts on your personal account.",
      question: "Is this normal?",
      photo: "no",
      answerOptions: [
        "Yes. Facebook is interactive, so it is normal for people to respond to personal posts from people that they do not know.",
        "No. It is not normal for people to respond to personal posts unless they are Facebook friends.",
        "No. It is not normal to comment on any posts on Facebook."
      ],
      explanation: "It is normal for people to comment on the personal posts of people they know.",
      correctAnswer: "No. It is not normal for people to respond to personal posts unless they are Facebook friends."
  ),
  SingleAnswerQuestion(
    //TODO: Question 27, on instagram there's a close friends list
      context: "Alfredo wants to post pictures of his family on Instagram, but only wants to share them with his close friends.",
      question: "What should he do?",
      photo: "no",
      answerOptions: [
        "Post the photos on his personal account.",
        "Post the photos on a secondary personal account that only his close friends can follow.",
        "Post the photos on a topic/interest account.",
        "Post the photos on a business account.",
      ],
      explanation: "explain",
      correctAnswer: "Post the photos on a secondary personal account that only his close friends can follow."
  ),
  SingleAnswerQuestion(
      context: "no",
      question: "What makes a business account different from a personal account?",
      photo: "no",
      answerOptions: [
        "A personal account is for sharing photos with friends and family, while a business account is for selling products.",
        "A business account is for sharing photos with friends and family, while a personal account is for selling products.",
        "A personal account is for posting about interests, while a business account it for celebrities and influencers."
      ],
      explanation: " Personal accounts are to connect with family and friends and business accounts are to promote businesses.",
      correctAnswer: "A personal account is for sharing photos with friends and family, while a business account is for selling products."
  ),
  SingleAnswerQuestion(
      context: "no",
      question: "Is it common to comment on a Facebook page?",
      photo: "no",
      answerOptions: [
        "Yes",
        "No",
      ],
      explanation: "Facebook pages are mostly for announcements and updates. They aren’t very interactive.",
      correctAnswer: "No"
  ),
  SingleAnswerQuestion(
      context: "no",
      question: " Is it allowed to have several accounts on Instagram?",
      photo: "no",
      answerOptions: [
        "Yes",
        "No",
      ],
      explanation: "Instagram allows users to have multiple accounts. It is common.",
      correctAnswer: "Yes"
  ),
];
