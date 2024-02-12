import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftwitter/app/cubit/post/cubit/post_cubit.dart';
import 'package:ftwitter/domain/entities/post/post_entities.dart';
import 'package:ftwitter/domain/entities/user/user_entity.dart';
import 'package:uuid/uuid.dart';

class AddTweet extends StatefulWidget {
  final UserEntity user;

  const AddTweet({super.key, required this.user});

  @override
  State<AddTweet> createState() => _AddTweetState();
}

class _AddTweetState extends State<AddTweet> {
  final _controller = TextEditingController();

  postTweet({required String tweet}) {
    BlocProvider.of<PostCubit>(context)
        .createPost(
      post: PostEntity(
        description: tweet,
        createAt: Timestamp.now(),
        creatorUid: widget.user.uid,
        likes: [],
        postId: Uuid().v1(),
        totalComments: 0,
        totalLikes: 0,
        username: widget.user.username,
        userProfileUrl: widget.user.profileUrl,
      ),
    )
        .then((value) {
      setState(() {
        _controller.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Tweet'),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            margin: EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 3,
                  color: Color(0xFFC2C2C2),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  height: 80,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(12),
                        child: const CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 25,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.user.name}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            '${widget.user.username}',
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      controller: _controller,
                      expands: true,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              postTweet(tweet: _controller.text);
              Navigator.of(context).pop();
            },
            child: Container(
              height: 60,
              width: 160,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                  child: Text(
                'Tweet',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )),
            ),
          )
        ],
      ),
    );
  }
}
