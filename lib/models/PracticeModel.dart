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
      practiceId: json['practiceId'] ?? 'unknown',
      attempts: (json['attempts'] != null && json['attempts'] is List)
          ? (json['attempts'] as List)
          .where((e) => e != null)
          .map((e) => PracticeAttemptModel.fromJson(Map<String, dynamic>.from(e)))
          .toList()
          : [],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'practiceId': practiceId,
      'attempts': attempts.map((attempt) => attempt.toJson()).toList(),
    };
  }
}