import 'package:ftwitter/domain/repos/supabase_repository.dart';

class SignOutUserUsecase {
  final FirebaseRepository repository;

  SignOutUserUsecase({required this.repository});

  Future<void> call() {
    return repository.signOut();
  }
}
