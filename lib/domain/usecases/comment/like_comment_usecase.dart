import 'package:ftwitter/domain/entities/comment/comment_entity.dart';
import 'package:ftwitter/domain/repos/supabase_repository.dart';

class LikeCommentUsecase {
  final FirebaseRepository repository;

  LikeCommentUsecase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.likeComment(comment);
  }
}
