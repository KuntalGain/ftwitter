import 'package:ftwitter/domain/entities/user/user_entity.dart';
import 'package:ftwitter/domain/repos/supabase_repository.dart';

class UpdateUserUsecase {
  final FirebaseRepository repository;

  UpdateUserUsecase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.updateUser(user);
  }
}
