import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ftwitter/domain/entities/post/post_entities.dart';
import 'package:ftwitter/domain/usecases/post/create_post_usecase.dart';
import 'package:ftwitter/domain/usecases/post/delete_post_usecase.dart';
import 'package:ftwitter/domain/usecases/post/fetch_post_usecase.dart';
import 'package:ftwitter/domain/usecases/post/like_post_usecase.dart';
import 'package:ftwitter/domain/usecases/post/update_post_usecase.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final CreatePostUsecase createPostUsecase;
  final UpdatePostUsecase updatePostUsecase;
  final DeletePostUsecase deletePostUsecase;
  final FetchPostUsecase fetchPostUsecase;
  final LikePostUsecase likePostUsecase;

  PostCubit({
    required this.createPostUsecase,
    required this.updatePostUsecase,
    required this.deletePostUsecase,
    required this.fetchPostUsecase,
    required this.likePostUsecase,
  }) : super(PostInitial());

  Future<void> fetchPosts({required PostEntity post}) async {
    emit(PostLoading());
    try {
      final streamResponse = fetchPostUsecase.call(post);

      streamResponse.listen((post) {
        emit(PostLoaded(posts: post));
      });
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> updatePost({required PostEntity post}) async {
    emit(PostLoading());
    try {
      await updatePostUsecase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> likePost({required PostEntity post}) async {
    emit(PostLoading());
    try {
      await likePostUsecase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> deletePost({required PostEntity post}) async {
    emit(PostLoading());
    try {
      await deletePostUsecase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> createPost({required PostEntity post}) async {
    emit(PostLoading());
    try {
      await createPostUsecase.call(post);
    } on SocketException catch (_) {
      emit(PostFailure());
    } catch (_) {
      emit(PostFailure());
    }
  }
}
