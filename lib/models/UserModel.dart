import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:quiz/models/quizModel.dart';
import 'package:quiz/models/readingModel.dart';

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
    numTickets = map['numTickets'];
    if (map['quizList'] != null) {
      if (map['quizList'] is String && (map['quizList'] as String).isNotEmpty) {
        try {
          List<dynamic> decodedList = jsonDecode(map['quizList']);
          quizList = decodedList.map((e) => QuizModel.fromJson(Map<String, dynamic>.from(e))).toList();
        } catch (e) {
          print('Error decoding quizList: $e');
          quizList = [];
        }
      } else if (map['quizList'] is List) {
        quizList = (map['quizList'] as List)
            .map((e) => QuizModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
    }

    if (map['accessories'] != null) {
      accessories = (map['accessories'] is String)
          ? List<bool>.from(jsonDecode(map['accessories']))
          : List<bool>.from(map['accessories']);
    }

    if (map['ifEachModuleComplete'] != null) {
      ifEachModuleComplete = (map['ifEachModuleComplete'] is String)
          ? List<bool>.from(jsonDecode(map['ifEachModuleComplete']))
          : List<bool>.from(map['ifEachModuleComplete']);
    }

    if (map['readingList'] != null) {
      if (map['readingList'] is String && (map['readingList'] as String).isNotEmpty) {
        try {
          List<dynamic> decodedList = jsonDecode(map['readingList']);
          readingList = decodedList.map((e) => readingModel.fromJson(Map<String, dynamic>.from(e))).toList();
        } catch (e) {
          print('Error decoding readingList: $e');
          readingList = [];
        }
      } else if (map['readingList'] is List) {
        readingList = (map['readingList'] as List)
            .map((e) => readingModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
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
