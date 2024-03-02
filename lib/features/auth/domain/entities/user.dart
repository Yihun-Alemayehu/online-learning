import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupId;
  final List<String> enrolledCourseIds;
  final List<String> following;
  final List<String> followers;

  const MyUser({
    required this.uid,
    required this.email,
    this.profilePic,
    this.bio,
    required this.points,
    required this.fullName,
    this.groupId = const [],
    this.enrolledCourseIds = const [],
    this.following = const [],
    this.followers = const [],
  });

  factory MyUser.empty() {
    return  const MyUser(
      uid: '_empty.uid',
      email: '_empty.email',
      points: 0,
      bio: '_empty.bio',
      fullName: '_empty.fullName',
      groupId: [],
      enrolledCourseIds: [],
      following: [],
      followers: [],
    );
  }

  
  @override
  String toString() {
    return 'MyUser{uid: $uid, email: $email, fullName: $fullName, bio: $bio, points: $points}';
  }

  @override
  List<Object?> get props => [uid, email];
}
