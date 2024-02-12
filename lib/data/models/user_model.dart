import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ftwitter/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
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

  UserModel({
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
    this.totalPosts,
  }) : super(
          uid: uid,
          username: username,
          name: name,
          bio: bio,
          email: email,
          profileUrl: profileUrl,
          followers: followers,
          following: following,
          totalFollower: totalFollower,
          totalFollowing: totalFollowing,
          totalPosts: totalPosts,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapshot['uid'],
      username: snapshot['username'],
      name: snapshot['name'],
      bio: snapshot['bio'],
      email: snapshot['email'],
      profileUrl: snapshot['profileUrl'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      totalFollower: snapshot['totalFollower'],
      totalFollowing: snapshot['totalFollowing'],
      totalPosts: snapshot['totalPosts'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'name': name,
        'bio': bio,
        'email': email,
        'profileUrl': profileUrl,
        'followers': followers,
        'following': following,
        'totalFollower': totalFollower,
        'totalFollowing': totalFollowing,
        'totalPosts': totalPosts,
      };
}
