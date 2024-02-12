import 'package:ftwitter/domain/entities/post/post_entities.dart';
import 'package:ftwitter/domain/repos/supabase_repository.dart';

class LikePostUsecase {
  final FirebaseRepository repository;

  LikePostUsecase({required this.repository});

  Future<void> call(PostEntity post) async {
    return repository.likePost(post);
  }
}
