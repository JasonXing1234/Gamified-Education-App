import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:quiz/models/quizModel.dart';
import 'package:quiz/models/readingModel.dart';
import 'package:quiz/models/PracticeModel.dart';

class UserModel extends Equatable {
  String? key;
  String? email;
  String? userId;
  String? deviceToken;
  String? userName;
  String? profilePic;
  String? bannerImage;
  int? numTickets;
  int? totalTimeSpent; // Tracks total time spent in the app
  List<QuizModel>? quizList;
  List<QuizModel>? preQuizList;
  List<PracticeModel>? practiceList; // List for practice attempts
  List<readingModel>? readingList;
  List<bool>? accessories;
  List<List<bool>>? ifEachModuleComplete;
  String? currentTask;
  bool? isLoggedIn;

  UserModel({
    this.email,
    this.userId,
    this.deviceToken,
    this.profilePic,
    this.bannerImage,
    this.key,
    this.userName,
    this.preQuizList,
    this.quizList,
    this.practiceList,
    this.readingList,
    this.numTickets,
    this.accessories,
    this.ifEachModuleComplete,
    this.currentTask,
    this.totalTimeSpent = 0,
    this.isLoggedIn = false,
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
    currentTask = map['currentTask'];
    totalTimeSpent = map['totalTimeSpent'] ?? 0; // Default to 0 if not present
    isLoggedIn = (map['isLoggedIn'] == 1);

    if (map['preQuizList'] != null) {
      if (map['preQuizList'] is String && (map['preQuizList'] as String).isNotEmpty) {
        try {
          List<dynamic> decodedList = jsonDecode(map['preQuizList']);
          quizList = decodedList.map((e) => QuizModel.fromJson(Map<String, dynamic>.from(e))).toList();
        } catch (e) {
          print('Error decoding quizList: $e');
          quizList = [];
        }
      } else if (map['preQuizList'] is List) {
        quizList = (map['preQuizList'] as List)
            .map((e) => QuizModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
    }

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

    if (map['practiceList'] != null) {
      if (map['practiceList'] is String && (map['practiceList'] as String).isNotEmpty) {
        try {
          List<dynamic> decodedList = jsonDecode(map['practiceList']);
          practiceList = decodedList.map((e) => PracticeModel.fromJson(Map<String, dynamic>.from(e))).toList();
        } catch (e) {
          print('Error decoding practiceList: $e');
          practiceList = [];
        }
      } else if (map['practiceList'] is List) {
        practiceList = (map['practiceList'] as List)
            .map((e) => PracticeModel.fromJson(Map<String, dynamic>.from(e)))
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
          ? (jsonDecode(map['ifEachModuleComplete']) as List)
          .map((innerList) => List<bool>.from(innerList))
          .toList()
          : (map['ifEachModuleComplete'] as List)
          .map((innerList) => List<bool>.from(innerList))
          .toList();
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

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      "userId": userId,
      "email": email,
      "deviceToken": deviceToken,
      'profilePic': profilePic,
      'bannerImage': bannerImage,
      'preQuizList': preQuizList?.map((e) => e.toJson()).toList(),
      'quizList': quizList?.map((e) => e.toJson()).toList(),
      'practiceList': practiceList?.map((e) => e.toJson()).toList(),
      'userName': userName,
      'numTickets': numTickets,
      'readingList': readingList?.map((e) => e.toJson()).toList(),
      'accessories': accessories,
      'ifEachModuleComplete': ifEachModuleComplete,
      'currentTask': currentTask,
      'totalTimeSpent': totalTimeSpent,
      'isLoggedIn': isLoggedIn! ? 1 : 0,
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
    preQuizList,
    practiceList,
    readingList,
    accessories,
    ifEachModuleComplete,
    currentTask,
    totalTimeSpent,
    isLoggedIn,
  ];
}