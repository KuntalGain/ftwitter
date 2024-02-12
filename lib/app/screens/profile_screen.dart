import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftwitter/app/cubit/auth/cubit/auth_cubit.dart';
import 'package:ftwitter/domain/entities/user/user_entity.dart';

class ProfileScreen extends StatelessWidget {
  final UserEntity currentUser;

  const ProfileScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).loggedOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                    'https://placekitten.com/200/200', // Replace with your profile image URL
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '${currentUser.name}', // Replace with the user's name
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '${currentUser.username}', // Replace with the user's username
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '${currentUser.bio}', // Replace with the user's bio
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Tweets'),
            subtitle: Text(
                '${currentUser.totalPosts}'), // Replace with the actual tweet count
          ),
          ListTile(
            title: Text('Followers'),
            subtitle: Text(
                '${currentUser.totalFollower}'), // Replace with the actual followers count
          ),
          ListTile(
            title: Text('Following'),
            subtitle: Text(
                '${currentUser.totalFollowing}'), // Replace with the actual following count
          ),
        ],
      ),
    );
  }
}
