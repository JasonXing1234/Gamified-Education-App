import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  String? key;
  String? email;
  String? userId;
  String? deviceToken;
  String? displayName;
  String? userName;
  String? webSite;
  String? profilePic;
  String? bannerImage;
  String? contact;
  String? bio;
  String? location;
  String? dob;
  String? createdAt;
  bool? isVerified;
  int? followers;
  int? following;
  int? pendingRequests;
  int? groups;
  List<String>? closenessMap;
  String? fcmToken;
  List<String>? followersList;
  List<String>? followingList;
  List<String>? pendingRequestList;
  List<String>? friendList;
  int? numFriends;
  List<String>? grouplist;

  List<String>? equipmentList;

  UserModel(
      {this.email,
      this.userId,
        this.deviceToken,
      this.displayName,
      this.profilePic,
      this.bannerImage,
      this.key,
      this.contact,
      this.bio,
      this.dob,
      this.location,
      this.createdAt,
      this.userName,
      this.followers,
      this.following,
      this.pendingRequests,
      this.webSite,
      this.isVerified,
      this.fcmToken,
      this.followersList,
      this.followingList,
      this.grouplist,
      this.groups,
      this.pendingRequestList,
      this.closenessMap,
      this.friendList,
      this.numFriends,

        this.equipmentList
      });

  UserModel.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    followersList ??= [];
    email = map['email'];
    userId = map['userId'];
    deviceToken = map['deviceToken'];
    displayName = map['displayName'];
    profilePic = map['profilePic'];
    bannerImage = map['bannerImage'];
    key = map['key'];
    dob = map['dob'];
    bio = map['bio'];
    location = map['location'];
    contact = map['contact'];
    createdAt = map['createdAt'];
    groups = map['groups'];
    followers = map['followers'];
    following = map['following'];
    numFriends = map['numFriends'];
    pendingRequests = map['pendingRequests'];
    userName = map['userName'];
    webSite = map['webSite'];
    fcmToken = map['fcmToken'];
    isVerified = map['isVerified'] ?? false;
    if (map['followingList'] != null) {
      followingList = <String>[];
      map['followingList'].forEach((value) {
        followingList!.add(value);
      });
    }
    if (map['pendingRequestList'] != null) {
      pendingRequestList = <String>[];
      map['pendingRequestList'].forEach((value) {
        pendingRequestList!.add(value);
      });
    }
    pendingRequests =
        pendingRequestList != null ? pendingRequestList!.length : null;
    if (map['closenessMap'] != null) {
      closenessMap = <String>[];
      map['closenessMap'].forEach((value) {
        closenessMap!.add(value);
      });
    }
    followers = followersList != null ? followersList!.length : null;
    if (map['followerList'] != null) {
      followersList = <String>[];
      map['followerList'].forEach((value) {
        followersList!.add(value);
      });
    }
    followers = followersList != null ? followersList!.length : null;
    if (map['grouplist'] != null) {
      grouplist = <String>[];
      map['grouplist'].forEach((value) {
        grouplist!.add(value);
      });
    }
    if (map['friendList'] != null) {
      friendList = <String>[];
      map['friendList'].forEach((value) {
        friendList!.add(value);
      });
    }
    if (map['equipmentList'] != null) {
      equipmentList = <String>[];
      map['equipmentList'].forEach((value) {
        equipmentList!.add(value);
      });
    }
    numFriends = friendList != null ? friendList!.length : null;
    groups = grouplist != null ? grouplist!.length : null;
  }
  toJson() {
    return {
      'key': key,
      "userId": userId,
      "email": email,
      "deviceToken": deviceToken,
      'displayName': displayName,
      'profilePic': profilePic,
      'bannerImage': bannerImage,
      'contact': contact,
      'dob': dob,
      'bio': bio,
      'location': location,
      'createdAt': createdAt,
      'followers': followersList != null ? followersList!.length : null,
      'following': followingList != null ? followingList!.length : null,
      'pendingRequests':
          pendingRequestList != null ? pendingRequestList!.length : null,
      'userName': userName,
      'webSite': webSite,
      'isVerified': isVerified ?? false,
      'fcmToken': fcmToken,
      'followerList': followersList,
      'followingList': followingList,
      'friendList': friendList,
      'grouplist': grouplist,
      'groups': grouplist,
      'closenessMap': closenessMap,
      'pendingRequestList': pendingRequestList,
      'equipmentList': equipmentList
    };
  }

  UserModel copyWith(
      {String? email,
      String? userId,
      String? displayName,
        String? deviceToken,
      String? profilePic,
      String? key,
      String? contact,
      String? bio,
      String? dob,
      String? bannerImage,
      String? location,
      String? createdAt,
      String? userName,
      int? followers,
      int? following,
      String? webSite,
      bool? isVerified,
      String? fcmToken,
      List<String>? followingList,
      List<String>? followersList,
      List<String>? pendingRequestList,
      List<String>? friendList,
      int? numFriends,
      List<String>? grouplist,
      List<String>? closenessMap,
      int? groups,
        List<String>? equipmentList,
      }) {
    return UserModel(
        email: email ?? this.email,
        bio: bio ?? this.bio,
        deviceToken: deviceToken ?? this.deviceToken,
        contact: contact ?? this.contact,
        createdAt: createdAt ?? this.createdAt,
        displayName: displayName ?? this.displayName,
        dob: dob ?? this.dob,
        followers: followers ?? this.followers,
        following: following ?? this.following,
        isVerified: isVerified ?? this.isVerified,
        key: key ?? this.key,
        location: location ?? this.location,
        profilePic: profilePic ?? this.profilePic,
        bannerImage: bannerImage ?? this.bannerImage,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        webSite: webSite ?? this.webSite,
        fcmToken: fcmToken ?? this.fcmToken,
        followersList: followersList ?? this.followersList,
        followingList: followingList ?? this.followingList,
        pendingRequestList: pendingRequestList ?? this.pendingRequestList,
        friendList: friendList ?? this.friendList,
        numFriends: numFriends ?? this.numFriends,
        grouplist: grouplist ?? this.grouplist,
        closenessMap: closenessMap ?? this.closenessMap,
        equipmentList: equipmentList ?? this.equipmentList
    );
  }

  String get getFollower {
    return '${followers ?? 0}';
  }

  String get getFollowing {
    return '${following ?? 0}';
  }

  String get getPendingRequests {
    return '${pendingRequests ?? 0}';
  }

  String get getFriends {
    return '${numFriends ?? 0}';
  }

  @override
  List<Object?> get props => [
        key,
        email,
        userId,
        deviceToken,
        displayName,
        userName,
        webSite,
        profilePic,
        bannerImage,
        contact,
        bio,
        location,
        dob,
        createdAt,
        isVerified,
        followers,
        following,
        fcmToken,
        followersList,
        followingList,
        grouplist,
        groups,
        closenessMap,
        pendingRequests,
        pendingRequestList,
        friendList,
    equipmentList
      ];
}
