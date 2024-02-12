import 'package:ftwitter/domain/entities/comment/comment_entity.dart';
import 'package:ftwitter/domain/repos/supabase_repository.dart';

class DeleteCommentUsecase {
  final FirebaseRepository repository;

  DeleteCommentUsecase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.deleteComment(comment);
  }
}
