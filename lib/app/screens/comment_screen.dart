import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftwitter/app/cubit/comment/cubit/comment_cubit.dart';
import 'package:ftwitter/app/widgets/comment.dart';
import 'package:ftwitter/app/widgets/post.dart';
import 'package:ftwitter/domain/entities/comment/comment_entity.dart';
import 'package:ftwitter/domain/entities/post/post_entities.dart';
import 'package:ftwitter/domain/usecases/auth/user/get_current_uid_usecase.dart';
import 'package:ftwitter/injection_container.dart' as di;
import 'package:uuid/uuid.dart';

class CommentScreen extends StatefulWidget {
  final PostEntity post;

  const CommentScreen({super.key, required this.post});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  String uid = '';

  @override
  void initState() {
    di.sl<GetCurrentUidUsecase>().call().then((value) {
      setState(() {
        uid = value;
      });
    });
    super.initState();
  }

  _createComment(String commentText) {
    print('Send to Method');
    return BlocProvider.of<CommentCubit>(context).createComment(
      comment: CommentEntity(
        commentId: Uuid().v1(),
        postId: widget.post.postId,
        creatorUid: uid,
        description: commentText,
        username: widget.post.username,
        userProfileUrl: widget.post.userProfileUrl,
        createAt: Timestamp.now(),
        likes: [],
        totalReplays: 0,
      ),
    );
  }

  _likeComment(String uid) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: BlocProvider<CommentCubit>(
        create: (context) => di.sl<CommentCubit>()
          ..getComments(postId: widget.post.postId.toString()),
        child: BlocBuilder<CommentCubit, CommentState>(
          builder: (context, state) {
            if (state is CommentLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }

            if (state is CommentLoaded) {
              return Column(
                children: [
                  TweetCard(
                    tweet: widget.post,
                    currentUser: uid,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.comments.length,
                      itemBuilder: (context, index) {
                        final comment = state.comments[index];
                        return commentCard(comment: comment);
                      },
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              hintText: 'Add a comment...',
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        ElevatedButton(
                          onPressed: () {
                            // Add the new comment to the list
                            setState(() {
                              print('button pressed');
                              _createComment(_commentController.text);
                              print(
                                  '{${_commentController.text}} is Send Successfully');
                              _commentController.clear();
                            });
                          },
                          child: Text('Post'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            if (state is CommentFailure) {
              return Center(
                child: Text('Something Went Wrong'),
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
