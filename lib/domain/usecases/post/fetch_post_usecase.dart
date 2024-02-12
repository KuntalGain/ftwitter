import 'package:ftwitter/domain/entities/post/post_entities.dart';
import 'package:ftwitter/domain/repos/supabase_repository.dart';

class FetchPostUsecase {
  final FirebaseRepository repository;

  FetchPostUsecase({required this.repository});

  Stream<List<PostEntity>> call(PostEntity post) {
    return repository.fetchPosts(post);
  }
}
