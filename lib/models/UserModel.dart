import 'package:equatable/equatable.dart';
import 'package:quiz/models/quizModel.dart';
import 'package:quiz/models/readingModel.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  String? key;
  String? email;
  String? userId;
  String? deviceToken;
  String? userName;
  String? profilePic;
  String? bannerImage;
  int? numTickets;
  List<QuizModel>? quizList;
  List<readingModel>? readingList;
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
        this.quizList,
        this.readingList,
        this.numTickets,
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
    numStars = map['numTickets'];
    if (map['quizList'] != null) {
      quizList = <QuizModel>[];
      map['quizList'].forEach((value) {
        quizList!.add(QuizModel.fromJson(Map<String, dynamic>.from(value)));
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
      readingList = <readingModel>[];
      map['readingList'].forEach((value) {
        readingList!.add(readingModel.fromJson(Map<String, dynamic>.from(value)));
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
      'quizList': quizList?.map((e) => e.toJson()).toList(),
      'userName': userName,
      'numTickets': numTickets,
      'readingList': readingList?.map((e) => e.toJson()).toList(),
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
    numTickets,
    quizList,
    readingList,
    accessories,
    ifEachModuleComplete
  ];
}
