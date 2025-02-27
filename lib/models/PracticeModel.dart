import 'PracticeAttemptModel.dart';

class PracticeModel {
  final String practiceId;
  final List<PracticeAttemptModel> attempts;

  PracticeModel({
    required this.practiceId,
    required this.attempts,
  });

  factory PracticeModel.fromJson(Map<String, dynamic> json) {
    return PracticeModel(
      practiceId: json['practiceId'],
      attempts: (json['attempts'] as List)
          .map((e) => PracticeAttemptModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'practiceId': practiceId,
      'attempts': attempts.map((attempt) => attempt.toJson()).toList(),
    };
  }
}