import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  String? key;
  String? email;
  String? userId;
  String? deviceToken;
  String? userName;
  String? profilePic;
  String? bannerImage;
  int? numStars;
  List<int>? quizScoreList;
  List<int>? readingList;
  List<bool>? accessories;
  List<bool>? ifEachModuleComplete;

  UserModel(
      {this.email,
        this.userId,
        this.deviceToken,
        this.profilePic,
        this.bannerImage,
        this.key,
        this.userName,
        this.quizScoreList,
        this.readingList,
        this.numStars,
        this.accessories,
        this.ifEachModuleComplete
      });

  UserModel.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    email = map['email'];
    userId = map['userId'];
    deviceToken = map['deviceToken'];
    profilePic = map['profilePic'];
    bannerImage = map['bannerImage'];
    key = map['key'];
    userName = map['userName'];
    numStars = map['numStars'];
    if (map['quizScoreList'] != null) {
      quizScoreList = <int>[];
      map['quizScoreList'].forEach((value) {
        quizScoreList!.add(value);
      });
    }
    if (map['accessories'] != null) {
      accessories = <bool>[];
      map['accessories'].forEach((value) {
        accessories!.add(value);
      });
    }
    if (map['ifEachModuleComplete'] != null) {
      ifEachModuleComplete = <bool>[];
      map['ifEachModuleComplete'].forEach((value) {
        ifEachModuleComplete!.add(value);
      });
    }
    if (map['readingList'] != null) {
      readingList = <int>[];
      map['readingList'].forEach((value) {
        readingList!.add(value);
      });
    }
  }
  toJson() {
    return {
      'key': key,
      "userId": userId,
      "email": email,
      "deviceToken": deviceToken,
      'profilePic': profilePic,
      'bannerImage': bannerImage,
      'quizScoreList': quizScoreList,
      'userName': userName,
      'numStars': numStars,
      'readingList': readingList,
      'accessories': accessories,
      'ifEachModuleComplete': ifEachModuleComplete
    };
  }

  @override
  List<Object?> get props => [
    key,
    email,
    userId,
    deviceToken,
    userName,
    profilePic,
    bannerImage,
    numStars,
    quizScoreList,
    readingList,
    accessories,
    ifEachModuleComplete
  ];
}
