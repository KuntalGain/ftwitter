import 'package:ftwitter/domain/entities/comment/comment_entity.dart';
import 'package:ftwitter/domain/repos/supabase_repository.dart';

class CreateCommentUsecase {
  final FirebaseRepository repository;

  CreateCommentUsecase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.createComment(comment);
  }
}
