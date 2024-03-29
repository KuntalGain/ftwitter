import 'package:ftwitter/domain/repos/supabase_repository.dart';

class GetCurrentUidUsecase {
  final FirebaseRepository repository;

  GetCurrentUidUsecase({required this.repository});

  Future<String> call() {
    return repository.getCurrentUid();
  }
}
