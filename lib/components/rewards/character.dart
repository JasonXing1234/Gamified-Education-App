
enum Phase {
  adult,
  teen,
  baby,
  egg,
  unknown,
}

class Character {
  Character(this.name, this.stats, this.photos, this.currentPhase);

  final String name;
  final Map<Phase, Map<String, String>> stats;
  final Map<Phase, String> photos;

  Phase currentPhase;

}