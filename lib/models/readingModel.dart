class readingModel {
  String readingID;
  int progress;


  readingModel({
    required this.readingID,
    required this.progress
  });

  Map<String, dynamic> toJson() {
    return {
      'bookId': readingID,
      'progress': progress,
    };
  }

  factory readingModel.fromJson(Map<String, dynamic> json) {
    return readingModel(
      readingID: json['bookId'] as String,
      progress: json['progress'] as int,
    );
  }
}