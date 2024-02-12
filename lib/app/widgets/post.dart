import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftwitter/app/cubit/post/cubit/post_cubit.dart';
import 'package:ftwitter/app/screens/comment_screen.dart';
import 'package:ftwitter/domain/entities/post/post_entities.dart';
import 'package:intl/intl.dart';

class TweetCard extends StatefulWidget {
  const TweetCard({super.key, required this.tweet, required this.currentUser});

  final PostEntity tweet;
  final String currentUser;

  @override
  State<TweetCard> createState() => _TweetCardState();
}

class _TweetCardState extends State<TweetCard> {
  _likePost(PostEntity post) {
    BlocProvider.of<PostCubit>(context).likePost(
      post: post,
    );
  }

  bool isLiked(String user) => widget.tweet.likes!.contains(user);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                    'https://placekitten.com/200/200', // Replace with your profile image URL
                  ),
                ),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.tweet.username.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '${widget.tweet.username} • ${DateFormat("DD/MMM/yyy").format(widget.tweet.createAt!.toDate())}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              widget.tweet.description.toString(),
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
                height:
                    16.0), // Add some space between the description and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _likePost(widget.tweet);
                  },
                  icon: Icon(
                    isLiked(widget.currentUser)
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: Colors.red,
                  ),
                  label: Text(widget.tweet.totalLikes.toString()),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Comment button press
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => CommentScreen(
                          post: widget.tweet,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.comment),
                  label: Text(widget.tweet.totalComments.toString()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
