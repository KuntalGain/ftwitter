import 'package:ftwitter/domain/entities/user/user_entity.dart';
import 'package:ftwitter/domain/repos/supabase_repository.dart';

class SignUpUserUsecase {
  final FirebaseRepository repository;

  SignUpUserUsecase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.signUpUser(user);
  }
}
