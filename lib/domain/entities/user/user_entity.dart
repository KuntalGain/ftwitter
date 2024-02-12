import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? username;
  final String? name;
  final String? bio;
  final String? email;
  final String? profileUrl;
  final List? followers;
  final List? following;
  final num? totalFollower;
  final num? totalFollowing;
  final num? totalPosts;

  // Confidential Data
  final String? password;
  final String? otherUid;

  UserEntity({
    this.uid,
    this.username,
    this.name,
    this.bio,
    this.email,
    this.profileUrl,
    this.followers,
    this.following,
    this.totalFollower,
    this.totalFollowing,
    this.password,
    this.otherUid,
    this.totalPosts,
  });

  @override
  List<Object?> get props => [
        uid,
        username,
        name,
        bio,
        email,
        profileUrl,
        followers,
        following,
        totalFollower,
        totalFollowing,
        password,
        otherUid,
        totalPosts,
      ];
}
