import 'package:ftwitter/domain/entities/comment/comment_entity.dart';
import 'package:ftwitter/domain/entities/post/post_entities.dart';
import 'package:ftwitter/domain/repos/supabase_repository.dart';

class ReadCommentsUseCase {
  final FirebaseRepository repository;

  ReadCommentsUseCase({required this.repository});

  Stream<List<CommentEntity>> call(String postId) {
    return repository.readComments(postId);
  }
}
