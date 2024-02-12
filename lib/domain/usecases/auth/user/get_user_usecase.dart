import 'package:ftwitter/domain/entities/user/user_entity.dart';
import 'package:ftwitter/domain/repos/supabase_repository.dart';

class GetUserUsecase {
  final FirebaseRepository repository;

  GetUserUsecase({required this.repository});

  Stream<List<UserEntity>> call(UserEntity user) {
    return repository.getUsers(user);
  }
}
