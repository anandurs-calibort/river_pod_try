class SharedPrefsHelper {
  String? _token; // just keep in memory for mock

  Future<void> saveToken(String token) async {
    _token = token;
    print("🔒 Token saved: $token");
  }

  String? getToken() => _token;
}
