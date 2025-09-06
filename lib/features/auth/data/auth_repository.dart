
import '../../../core/models/user_model.dart';
import '../../../core/network/network_service.dart';
import '../../../core/storage/shared_prefs_helper.dart';

class AuthRepository {
  final NetworkService networkService;
  final SharedPrefsHelper prefsHelper;

  AuthRepository(this.networkService, this.prefsHelper);

  Future<UserModel> login(String email, String password) async {
    final response = await networkService.post("/login", {
      "email": email,
      "password": password,
    });

    final user = UserModel.fromJson(response);
    await prefsHelper.saveToken(user.token);
    return user;
  }
}
