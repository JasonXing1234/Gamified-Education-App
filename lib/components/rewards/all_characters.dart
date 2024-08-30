import 'character.dart';


final Character lockedCharacter = Character(
  "Locked",
  {
    Phase.adult: {"weight": "unknown", "height" : "unknown"},
    Phase.teen: {"weight": "unknown", "height" : "unknown"},
    Phase.egg: {"weight": "unknown", "height" : "unknown"},
    Phase.teen: {"weight": "unknown", "height" : "unknown"},
  },
  {
    Phase.adult: "assets/images/lock.png",
    Phase.teen: "assets/images/lock.png",
    Phase.baby: "assets/images/lock.png",
    Phase.egg: "assets/images/lock.png",
  },
  Phase.egg,
);


final Character orangeDragon = Character(
    "Orange Dragon",
    {
      Phase.adult: {"weight": "4 tons", "height" : "20 feet"},
      Phase.teen: {"weight": "4 tons", "height" : "20 feet"},
      Phase.egg: {"weight": "4 tons", "height" : "20 feet"},
      Phase.teen: {"weight": "4 tons", "height" : "20 feet"},
    },
    {
      Phase.adult: "assets/character_images/orange_dragon/orange_dragon_adult.png",
      Phase.teen: "assets/character_images/orange_dragon/orange_dragon_adult.png",
      Phase.baby: "assets/character_images/orange_dragon/orange_dragon_adult.png",
      Phase.egg: "assets/character_images/orange_dragon/orange_dragon_adult.png",
    },
    Phase.adult,
);
