import '../../../core/models/user_model.dart';
import '../../features/auth/data/auth_repository.dart';

class AuthService {
  final AuthRepository repository;

  AuthService(this.repository);

  Future<UserModel> loginUser(String email, String password) {
    return repository.login(email, password);
  }
}
