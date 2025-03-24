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
  int? totalTimeSpent;
  List<QuizModel>? quizList;
  List<QuizModel>? preQuizList;
  List<PracticeModel>? practiceList;
  List<readingModel>? readingList;
  List<bool>? accessories;
  List<List<bool>>? ifEachModuleComplete;
  String? currentTask;
  bool? isLoggedIn;
  List<Map<String, dynamic>>? decorateStickers;
  List<String>? availableStickers;

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
    this.decorateStickers,
    this.availableStickers
  });

  UserModel.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) return;

    email = map['email'];
    userId = map['userId'];
    deviceToken = map['deviceToken'];
    profilePic = map['profilePic'];
    bannerImage = map['bannerImage'];
    key = map['key'];
    userName = map['userName'];
    numTickets = map['numTickets'];
    currentTask = map['currentTask'];
    totalTimeSpent = map['totalTimeSpent'] ?? 0;
    isLoggedIn = (map['isLoggedIn'] == 1);
    if (map['preQuizList'] != null) {
      if (map['preQuizList'] is String && (map['preQuizList'] as String).isNotEmpty) {
        try {
          List<dynamic> decodedList = jsonDecode(map['preQuizList']);
          preQuizList = decodedList
              .map((e) => QuizModel.fromJson(Map<String, dynamic>.from(e)))
              .toList();
        } catch (e) {
          print('Error decoding preQuizList: $e');
          preQuizList = [];
        }
      } else if (map['preQuizList'] is List) {
        preQuizList = (map['preQuizList'] as List)
            .map((e) => QuizModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
    }

    // QuizList
    if (map['quizList'] != null) {
      if (map['quizList'] is String && (map['quizList'] as String).isNotEmpty) {
        try {
          List<dynamic> decodedList = jsonDecode(map['quizList']);
          quizList = decodedList
              .map((e) => QuizModel.fromJson(Map<String, dynamic>.from(e)))
              .toList();
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

    // PracticeList
    if (map['practiceList'] != null) {
      if (map['practiceList'] is String && (map['practiceList'] as String).isNotEmpty) {
        try {
          List<dynamic> decodedList = jsonDecode(map['practiceList']);
          practiceList = decodedList
              .map((e) => PracticeModel.fromJson(Map<String, dynamic>.from(e)))
              .toList();
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

    // Accessories
    if (map['accessories'] != null) {
      accessories = (map['accessories'] is String)
          ? List<bool>.from(jsonDecode(map['accessories']))
          : List<bool>.from(map['accessories']);
    }

    // IfEachModuleComplete
    if (map['ifEachModuleComplete'] != null) {
      ifEachModuleComplete = (map['ifEachModuleComplete'] is String)
          ? (jsonDecode(map['ifEachModuleComplete']) as List)
          .map((innerList) => List<bool>.from(innerList))
          .toList()
          : (map['ifEachModuleComplete'] as List)
          .map((innerList) => List<bool>.from(innerList))
          .toList();
    }

    // ReadingList
    if (map['readingList'] != null) {
      if (map['readingList'] is String && (map['readingList'] as String).isNotEmpty) {
        try {
          List<dynamic> decodedList = jsonDecode(map['readingList']);
          readingList = decodedList
              .map((e) => readingModel.fromJson(Map<String, dynamic>.from(e)))
              .toList();
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
    if (map['decorateStickers'] != null) {
      if (map['decorateStickers'] is String && (map['decorateStickers'] as String).isNotEmpty) {
        try {
          List<dynamic> decodedList = jsonDecode(map['decorateStickers']);
          decorateStickers = decodedList
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        } catch (e) {
          print('Error decoding decorateStickers: $e');
          decorateStickers = [];
        }
      } else if (map['decorateStickers'] is List) {
        decorateStickers = (map['decorateStickers'] as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      }
    }
    if (map['availableStickers'] != null) {
      if (map['availableStickers'] is String && (map['availableStickers'] as String).isNotEmpty) {
        try {
          availableStickers = List<String>.from(jsonDecode(map['availableStickers']));
        } catch (e) {
          print('Error decoding availableStickers: $e');
          availableStickers = [];
        }
      } else if (map['availableStickers'] is List) {
        availableStickers = List<String>.from(map['availableStickers']);
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
      'isLoggedIn': isLoggedIn == true ? 1 : 0,
      'decorateStickers': decorateStickers != null
          ? jsonEncode(decorateStickers)
          : null,
      'availableStickers': availableStickers != null
          ? jsonEncode(availableStickers)
          : null,
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
    decorateStickers,
  ];
}
