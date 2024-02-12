import 'package:ftwitter/domain/entities/user/user_entity.dart';
import 'package:ftwitter/domain/repos/supabase_repository.dart';

class CreateUserUsecase {
  final FirebaseRepository repository;

  CreateUserUsecase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.createUser(user);
  }
}
