import 'package:ftwitter/domain/entities/comment/comment_entity.dart';
import 'package:ftwitter/domain/repos/supabase_repository.dart';

class UpdateCommentUsecase {
  final FirebaseRepository repository;

  UpdateCommentUsecase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.updateComment(comment);
  }
}
