import 'package:ftwitter/domain/entities/post/post_entities.dart';
import 'package:ftwitter/domain/repos/supabase_repository.dart';

class UpdatePostUsecase {
  final FirebaseRepository repository;

  UpdatePostUsecase({required this.repository});

  Future<void> call(PostEntity post) async {
    return repository.updatePost(post);
  }
}
