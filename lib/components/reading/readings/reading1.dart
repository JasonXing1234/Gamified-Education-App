
import 'package:quiz/components/question.dart';

import '../reading_page.dart';

// Social Media Norms

var reading1 = [
  const ReadingPage(
    "WHAT IS A NORM?",
    ["A norm is the way which something is usually done"],
    "no",
  ),
  const ReadingPage(
    "IMPACT",
    [
      "When you follow the norms of social media, you may have a better experience.",
      "People expect you to use social media a certain way. If you don't follow the norm, others may be confused or upset.",
    ],
    "assets/lesson_images/social_media_norms_images/computer.png",
  ),
  const ReadingQuestion(
    "QUESTION",
    [
      "Why do we follow norms when we use social media?",
    ],
    "no",
    [
      "So we and others can have a good experience online",
      "To gain popularity on social media",
      "Because it's fun to follow rules",
      "Because everyone else follows them",
    ],
    "So we and others can have a good experience online",
    "explain",
  ),
  const ReadingPage(
    "PLATFORMS",
    [
      "On social media platforms anyone is able to create a profile.",
      "There are many different types of profiles on different platforms.",
    ],
    "no",
  ),
  const ReadingPage(
    // TODO: Maybe split this into two slides, if you don't want scrolling
    "INSTAGRAM NORMS",
    [
      "Common to create your own content",
      "Primarily post photos",
      "Common to follow any account you’re interested in",
      "You can follow others or be followed by others. Sometimes you may follow someone who doesn't follow you back."
    ],
    "no",
  ),
  // TODO: Add Interactive questions?
  // SingleAnswerQuestion(
  //     "no",
  //     "Can you follow someone without them following you back?",
  //     "no",
  //     [
  //       "Yes",
  //       "No",
  //     ],
  //     "Yes",
  // ),
  const ReadingPage(
    "FACEBOOK NORMS",
    [
      "Common to create your own or share other's content",
      "More text-based posts but also photos and videos",
      "Common to only become 'Friends' with people you know in-person",
      "When you become 'Friends' with someone, you can automatically see their posts and they can see yours.",
    ],
    "no",
  ),

  // TODO: With checking answers should there be an answer explanation right after?
  const ReadingMultipleAnswersQuestion(
    "QUESTION",
    [
      "What happens when you become 'Friends' with someone on Facebook?",
    ],
    "no",
    [
      "textField",
    ],
    [],
  ),
  const ReadingMultipleAnswersQuestion(
    "QUESTION",
    [
      "Why would you use Instagram instead of Facebook?",
    ],
    "no",
    [
      "textField",
    ],
    [],
  ),
  const ReadingMultipleAnswersQuestion(
    "QUESTION",
    [
      "Why would you use Facebook instead of Instagram?",
    ],
    "no",
    [
      "textField",
    ],
    [],
  ),
  const ReadingPage(
    "PERSONAL FACEBOOK",
    [
      "These are the accounts you automatically have when you sign up for Facebook.",
      "You are able to see what others post and they can see what you post",
    ],
    "assets/lesson_images/social_media_norms_images/facebook_personal.png",
  ),
  const ReadingPage(
    "FACEBOOK 'FRIENDS'",
    [
      "Just because Facebook calls it a 'Friend' does not mean that all of your Facebook 'Friends' are truly your friend.",
      "When other users send ‘Friend’ requests, they aren’t asking to be your real-life friend. They are just asking to connect with you on Facebook.",
    ],
    "assets/lesson_images/social_media_norms_images/facebook_personal.png",
  ),
  const ReadingPage(
    "WHY CREATE A PERSONAL FACEBOOK?",
    [
      "Someone may create a user account to connect with their Friends over social media.",
      "They can post about what is going on in their lives."
    ],
    "assets/lesson_images/social_media_norms_images/facebook_personal.png",
  ),
  const ReadingPage(
    "FACEBOOK GROUP",
    [
      "These are accounts where you can talk with people about specific interests.",
      "These people do not have to be on your 'Friend' list.",
      "You are able to see what others post and they can see what you post.",
    ],
    "assets/lesson_images/social_media_norms_images/facebook_group.png",
  ),
  const ReadingPage(
    "WHY CREATE A GROUP",
    [
      "Someone may create a group to have a place to discuss something they are interested in with others. Groups tend to be interactive."
    ],
    "assets/lesson_images/social_media_norms_images/facebook_group.png",
  ),
  const ReadingPage(
    "FACEBOOK PAGE",
    [
      "These accounts are normally about a business or interest. They are less interactive.",
    ],
    "assets/lesson_images/social_media_norms_images/facebook_page.png",
  ),
  const ReadingPage(
    "WHY CREATE A PAGE?",
    [
      "Someone may create a page to share information about events and news. People don’t often comment on the posts."
    ],
    "assets/lesson_images/social_media_norms_images/facebook_page.png",
  ),
  const ReadingPage(
    "REMEMBER",
    [
      "On Facebook, it is NOT common to create different personal accounts for different purposes.",
      "It is actually against the terms and services of Facebook!",
      "Instead, you will have one personal account to interact with people you know.",
    ],
    "no",
  ),
  const ReadingPage(
    "PERSONAL INSTAGRAM",
    [
      "These are the accounts you automatically have when you sign up for Instagram.",
      "You are able to see what others post and others can see what you post.",
    ],
    "assets/lesson_images/social_media_norms_images/instagram_personal.png",
  ),
  const ReadingPage(
    "WHY CREATE A PERSONAL INSTAGRAM?",
    [
      "So that they can post about themselves and their lives for their friends to see.",
      "Also, so that they can follow their friends and other accounts which interest them.",
    ],
    "assets/lesson_images/social_media_norms_images/instagram_personal.png",
  ),
  const ReadingPage(
    "ALTERNATE PERSONAL (FINSTA)",
    [
      "These are accounts which are typically used by individuals to post things that they only want certain people to see",
    ],
    "assets/lesson_images/social_media_norms_images/instagram_finsta.png",
  ),
  const ReadingPage(
    "WHY CREATE A FINSTA?",
    [
      "So that they can post about themselves and their lives for a limited number of friends to see."
    ],
    "assets/lesson_images/social_media_norms_images/instagram_finsta.png",
  ),
  const ReadingPage(
    "BUSINESS ACCOUNTS",
    [
      "These are accounts which are typically used to post images of promotionals or products which are for sale",
    ],
    "assets/lesson_images/social_media_norms_images/instagram_business.png",
  ),
  const ReadingPage(
    "WHY CREATE A BUSINESS ACCOUNT?",
    [
      "Someone (or a company) would use a business profile when they want to advertise their products which are for sale",
    ],
    "assets/lesson_images/social_media_norms_images/instagram_business.png",
  ),
  const ReadingPage(
    "VERIFIED CELEBRITY & INFLUENCER",
    [
      "These are accounts which are used by a celebrity or influencer. These accounts will have a 'verified' symbol.",
    ],
    "assets/images/verifiedSymbol.png",
  ),
  const ReadingPage(
    "WHY CREATE AN INFLUENCER ACCOUNT?",
    [
      "A celebrity or influencer uses these accounts to post about their lives. They may promote products or themselves.",
    ],
    "assets/lesson_images/social_media_norms_images/instagram_influencer.png",
  ),
  const ReadingPage(
    "TOPIC / INTEREST ACCOUNT",
    [
      "These are accounts which post about certain topics or interests. These include meme accounts, fan accounts, etc."
    ],
    "assets/lesson_images/social_media_norms_images/instagram_topic.png",
  ),
  const ReadingPage(
    "WHY CREATE A TOPIC ACCOUNT?",
    [
      "Someone may use a topic/interest account to post exclusively about things which they are interested in.",
    ],
    "assets/lesson_images/social_media_norms_images/instagram_topic.png",
  ),
  const ReadingPage(
    "REMEMBER",
    [ // TODO: edited the order of this text and the wording, should this match the original?
      "Anyone can create a social media account",
      "On Facebook, you should only have one personal account. If you create a Page or Group, people can tell you created it.",
      "On Instagram, it is common to create different accounts for different purposes. People cannot always tell they are created by the same person.",
    ],
    "no",
  ),
];