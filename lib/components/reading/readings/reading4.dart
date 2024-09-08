import 'package:quiz/components/reading/reading_page.dart';

import '../../question.dart';

// Social Tags

const reading4 = [
  ReadingPage(
    "WHAT IS A SOCIAL TAG?",
    [
      "A social tag is a way to label people based on their relationship with you.",
    ],
    "assets/lesson_images/social_tags_images/social_tags_1.png",
  ),
  ReadingPage(
    "WHY DOES IT MATTER?",
    [
      "You may only want to share certain information with certain people.",
      "For example, you may not want your boss to know about your personal life.",
    ],
    "assets/lesson_images/social_tags_images/social_tags_1.png",
  ),
  ReadingPage(
    "HOW TO USE SOCIAL TAGS",
    [
      "Step 1",
    ],
    "assets/lesson_images/social_tags_images/making_social_tags_1.png",
  ),
  ReadingPage(
    "HOW TO USE SOCIAL TAGS",
    [
      "Step 2",
    ],
    "assets/lesson_images/social_tags_images/making_social_tags_2.png",
  ),
  ReadingPage(
    "HOW TO USE SOCIAL TAGS",
    [
      "Step 3",
    ],
    "assets/lesson_images/social_tags_images/making_social_tags_3.png",
  ),
  ReadingPage(
    "DIFFERENT TAGS \nCLOSE FAMILY",
    [
      "Close Family are the people in your family who you talk to or see often. They help you.",
      "This may be parents, partner, sibling, or spouse.",
    ],
    "no",
  ),
  ReadingPage(
    "DIFFERENT TAGS \nDISTANT FAMILY",
    [
      "Distant Family are the people in your family who you don't talk to or see often.",
      "This may be grandparents, uncle, aunt, or cousin.",
    ],
    "no",
  ),
  ReadingPage(
    "DIFFERENT TAGS \nIN-PERSON FRIEND",
    [
      "In-Person Friends are people you have met many times in person. You feel comfortable around them.",
      "This may be a school friend, work friend, church friend, close friend, or neighbor friend.",
    ],
    "no",
  ),
  ReadingPage(
    "DIFFERENT TAGS \nSCHOOL PEER",
    [
      "School Peers are students you interact with at school.",
      "This may be a classmate or a tutor",
    ],
    "no",
  ),
  ReadingPage(
    "DIFFERENT TAGS \nPERSONAL SERVICE PROVIDER", // TODO: Remove reference to scenic view for broader audience
    [
      "Personal Service Providers are adults who assist you at scenic view or are in charge of your health such as "
          "your Doctor, Therapist, or Dentist.",
      "This may be a personal mentor, personal case-worker, personal job-coach, "
          "personal health provider, or personal life-skills coach.",
    ],
    "no",
  ),
  ReadingPage(
    "DIFFERENT TAGS \nWORK PEER",
    [
      "Work Peers are people who you work with.",
      "This may be a colleague or someone who works at the same place as you",
    ],
    "no",
  ),
  ReadingPage(
    "DIFFERENT TAGS",
    [
      "So far we've mentioned the following people \n\n- Close Family \n- Distant Family "
          "\n- In-Person Friends \n- School Peers \n-Personal Service Providers \n- Work Peers",
    ],
    "no",
  ),
  // SingleAnswerQuestion(
  //   "You have a friend from school that you have played sports with every week for the past 6 months.",
  //   "Is this an in-person friend?",
  //   "no",
  //   [
  //     "Yes",
  //     "No",
  //   ],
  //   "Yes",
  // ),
  ReadingPage(
    "DIFFERENT TAGS \nBOSSES & TEACHERS",
    [
      "Bosses and Teachers are people who are in charge at work or school.",
      "This may be a boss at work or teacher at school.",
    ],
    "no",
  ),
  ReadingPage(
    "DIFFERENT TAGS \nONLINE FRIEND",
    [
      "Online Friends are friends that you talk to online and have NEVER met in person",
      "This may be an online boyfriend/girlfriend/partner, someone you've only "
          "spoken to on social media, or someone you've only spoken to on a video game.",
    ],
    "no",
  ),
  ReadingPage(
    "DIFFERENT TAGS \nCOMMUNITY HELPER",
    [
      "Community Helpers are people, whose job is to help people",
      "This may be a firefighter, police, lifeguard, teacher, nurse, crossing guard, military, or doctor.",
    ],
    "no",
  ),
  ReadingPage(
    "DIFFERENT TAGS \nACQUAINTANCE",
    [
      "Acquaintances are people you have met before in-person, but not other tag fits them.",
      "This may be a neighbor you don't know well, mail person, bus driver, or landlord.",
    ],
    "no",
  ),
  ReadingPage(
    "DIFFERENT TAGS \nSTRANGER",
    [
      "Strangers are people you have not met before in-person and no other tag fits them.",
      "This may be anyone you've never met online or in-person, fake profiles, "
          "people you ride transit with, celebrity social media pages, or people who you see on the street.",
    ],
    "no",
  ),
  ReadingPage(
    "DIFFERENT TAGS",
    [
      "So far we've mentioned the following people \n\n- Close Family \n- Distant Family "
          "\n- In-Person Friends \n- School Peers \n-Personal Service Providers \n- Work Peers "
          "\n- Bosses and Teachers \n- Online Friend \n- Community Helper \n- Acquaintance \n- Stranger",
    ],
    "no",
  ),
  ReadingMultipleAnswersQuestion(
    "QUESTION",
    [
      "Your favorite teacher from school",
      "What social tag(s) apply this person?"
    ],
    "no",
    [
      "In-Person Friend",
      "School Peer",
      "Personal Service Provider",
      "Work Peer",
      "Boss / Teacher",
      "Online Friend",
      "Acquaintance",
      "Community Helper",
      "Stranger"
    ],
    [
      "Boss / Teacher",
    ],
  ),
  // MultipleAnswersQuestion(
  //   "Your father who is a police officer",
  //   "What social tag(s) apply this person?",
  //   "no",
  //   [
  //     "Close Family",
  //     "Distant Family",
  //     "In-Person Friend",
  //     "School Peer",
  //     "Personal Service Provider",
  //     "Work Peer",
  //     "Boss / Teacher",
  //     "Online Friend",
  //     "Acquaintance",
  //     "Community Helper",
  //     "Stranger"
  //   ],
  //   [
  //     "Close Family",
  //     "Community Helper",
  //   ],
  // ),
  // MultipleAnswersQuestion(
  //   "A person who you've never seen or spoken to that sends you a 'Friend' request",
  //   "What social tag(s) apply this person?",
  //   "no",
  //   [
  //     "Close Family",
  //     "Distant Family",
  //     "In-Person Friend",
  //     "School Peer",
  //     "Personal Service Provider",
  //     "Work Peer",
  //     "Boss / Teacher",
  //     "Online Friend",
  //     "Acquaintance",
  //     "Community Helper",
  //     "Stranger"
  //   ],
  //   [
  //     "Stranger",
  //   ],
  // ),

];