
enum Phase {
  adult,
  teen,
  baby,
  egg,
  unknown,
  locked,
}

class Animal {
  Animal({
    required this.name,
    required this.stats,
    required this.photos,
    required this.currentPhase
  });

  final String name;
  final Map<Phase, Map<String, String>> stats;
  final Map<Phase, String> photos;

  Phase currentPhase;

}