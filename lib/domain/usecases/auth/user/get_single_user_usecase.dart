import 'package:ftwitter/domain/entities/user/user_entity.dart';
import 'package:ftwitter/domain/repos/supabase_repository.dart';

class SingleUserUsecase {
  final FirebaseRepository repository;

  SingleUserUsecase({required this.repository});

  Stream<List<UserEntity>> call(String uid) {
    return repository.getSingleUsers(uid);
  }
}
