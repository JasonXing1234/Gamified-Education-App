import 'character.dart';


final Character lockedCharacter = Character(
  "Locked",
  {
    Phase.adult: {"weight": "unknown", "height" : "unknown"},
    Phase.teen: {"weight": "unknown", "height" : "unknown"},
    Phase.baby: {"weight": "unknown", "height" : "unknown"},
    Phase.egg: {"weight": "unknown", "height" : "unknown"},
    Phase.unknown: {"weight": "unknown", "height" : "unknown"},
  },
  {
    Phase.adult: "assets/images/lock.png",
    Phase.teen: "assets/images/lock.png",
    Phase.baby: "assets/images/lock.png",
    Phase.egg: "assets/images/lock.png",
    Phase.unknown: "assets/images/lock.png",
  },
  Phase.unknown,
);

final Character questionCharacter = Character(
  "Unknown",
  {
    Phase.adult: {"weight": "unknown", "height" : "unknown"},
    Phase.teen: {"weight": "unknown", "height" : "unknown"},
    Phase.baby: {"weight": "unknown", "height" : "unknown"},
    Phase.egg: {"weight": "unknown", "height" : "unknown"},
    Phase.unknown: {"weight": "unknown", "height" : "unknown"},
  },
  {
    Phase.adult: "assets/images/question_mark.png",
    Phase.teen: "assets/images/question_mark.png",
    Phase.baby: "assets/images/question_mark.png",
    Phase.egg: "assets/images/question_mark.png",
    Phase.unknown: "assets/images/question_mark.png",
  },
  Phase.unknown,
);


final Character orangeDragon = Character(
    "Orange Dragon",
    {
      Phase.adult: {"weight": "4 tons", "height" : "20 feet"},
      Phase.teen: {"weight": "4 tons", "height" : "20 feet"},
      Phase.baby: {"weight": "4 tons", "height" : "20 feet"},
      Phase.egg: {"weight": "25 lbs", "height" : "1 foot"},
      Phase.unknown: {"weight": "unknown", "height" : "unknown"},
    },
    {
      Phase.adult: "assets/character_images/orange_dragon/orange_dragon_adult.png",
      Phase.teen: "assets/character_images/orange_dragon/orange_dragon_teen.png",
      Phase.baby: "assets/character_images/orange_dragon/orange_dragon_baby.png",
      Phase.egg: "assets/character_images/orange_dragon/orange_dragon_adult.png",
      Phase.unknown: "assets/images/question_mark.png",
    },
    Phase.adult,
);
