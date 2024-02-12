import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftwitter/app/cubit/post/cubit/post_cubit.dart';
import 'package:ftwitter/app/widgets/post.dart';
import 'package:ftwitter/domain/entities/post/post_entities.dart';
import 'package:ftwitter/domain/usecases/auth/user/get_current_uid_usecase.dart';
import 'package:ftwitter/injection_container.dart' as di;

class FeedScreen extends StatefulWidget {
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool isLiked = false;
  String currentUid = '';

  @override
  void initState() {
    super.initState();

    di.sl<GetCurrentUidUsecase>().call().then((value) {
      setState(() {
        currentUid = value;
      });
    });

    // Fetch posts when the screen is initialized
    context.read<PostCubit>().fetchPosts(post: PostEntity(likes: const []));
  }

  _likePost(PostEntity post) {
    BlocProvider.of<PostCubit>(context).likePost(
      post: post,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Feed Screen"),
        actions: const [],
      ),
      body: BlocProvider<PostCubit>(
        create: (context) => di.sl<PostCubit>()..fetchPosts(post: PostEntity()),
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, postState) {
            if (postState is PostLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (postState is PostFailure) {
              print("Some Failure occured while creating the post");
            }
            if (postState is PostLoaded) {
              return ListView.builder(
                itemCount: postState.posts.length,
                itemBuilder: (context, index) {
                  final post = postState.posts[index];
                  return BlocProvider(
                    create: (context) => di.sl<PostCubit>(),
                    child: TweetCard(
                      tweet: post,
                      currentUser: currentUid,
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
