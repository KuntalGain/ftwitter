import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ftwitter/domain/entities/comment/comment_entity.dart';
import 'package:ftwitter/domain/usecases/comment/create_comment_usecase.dart';
import 'package:ftwitter/domain/usecases/comment/delete_comment_usecase.dart';
import 'package:ftwitter/domain/usecases/comment/like_comment_usecase.dart';
import 'package:ftwitter/domain/usecases/comment/read_comment_usecase.dart';
import 'package:ftwitter/domain/usecases/comment/update_comment_usecase.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  // final CreateCommentUseCase createCommentUseCase;
  // final DeleteCommentUseCase deleteCommentUseCase;
  // final LikeCommentUseCase likeCommentUseCase;
  // final ReadCommentsUseCase readCommentsUseCase;
  // final UpdateCommentUseCase updateCommentUseCase;

  final CreateCommentUsecase commentUsecase;
  final DeleteCommentUsecase deleteCommentUsecase;
  final LikeCommentUsecase likeCommentUsecase;
  final ReadCommentsUseCase readCommentsUseCase;
  final UpdateCommentUsecase updateCommentUsecase;

  CommentCubit({
    required this.commentUsecase,
    required this.deleteCommentUsecase,
    required this.likeCommentUsecase,
    required this.readCommentsUseCase,
    required this.updateCommentUsecase,
  }) : super(CommentInitial());

  Future<void> getComments({required String postId}) async {
    emit(CommentLoading());
    try {
      final streamResponse = readCommentsUseCase.call(postId);
      streamResponse.listen((comments) {
        emit(CommentLoaded(comments: comments));
      });
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> likeComment({required CommentEntity comment}) async {
    try {
      await likeCommentUsecase.call(comment);
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> deleteComment({required CommentEntity comment}) async {
    try {
      await deleteCommentUsecase.call(comment);
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> createComment({required CommentEntity comment}) async {
    try {
      await commentUsecase.call(comment);
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> updateComment({required CommentEntity comment}) async {
    try {
      await updateCommentUsecase.call(comment);
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }
}
