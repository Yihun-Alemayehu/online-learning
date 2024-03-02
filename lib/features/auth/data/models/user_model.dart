import 'package:online_learning/features/auth/domain/entities/user.dart';

class MyUserModel extends MyUser {
  const MyUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullName,
    super.groupId,
    super.bio,
    super.profilePic,
    super.enrolledCourseIds,
    super.following,
    super.followers,
  });

  factory MyUserModel.empty() {
    return const MyUserModel(
      uid: 'uid',
      email: 'email',
      points: 0,
      fullName: 'fullName',
    );
  }

  MyUserModel copyWith({
    String? uid,
    String? email,
    String? profilePic,
    String? bio,
    int? points,
    String? fullName,
    List<String>? groupId,
    List<String>? enrolledCourseIds,
    List<String>? following,
    List<String>? followers,
  }) {
    return MyUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
      points: points ?? this.points,
      fullName: fullName ?? this.fullName,
      groupId: groupId ?? this.groupId,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }
  

  factory MyUserModel.fromMap(Map<String, dynamic> map) {
    return MyUserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      points: (map['points'] as num).toInt(),
      fullName: map['fullName'] as String,
      profilePic: map['profilePic'] as String?,
      bio: map['bio'] as String?,
      enrolledCourseIds: (map['enrolledCourseIds'] as List<dynamic>).cast<String>(),
      groupId: (map['groupId'] as List<dynamic>).cast<String>(),
      followers: (map['followers'] as List<dynamic>).cast<String>(),
      following: (map['following'] as List<dynamic>).cast<String>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'profilePic': profilePic,
      'bio': bio,
      'points': points,
      'fullName': fullName,
      'groupId': groupId,
      'enrolledCourseIds': enrolledCourseIds,
      'following': following,
      'followers': followers,
    };
  }

  
}
