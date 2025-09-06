class NetworkService {
  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay

    // Mocked response
    if (data["email"] == "test@mail.com" && data["password"] == "123456") {
      return {
        "id": 1,
        "email": data["email"],
        "token": "mocked_token_123",
      };
    } else {
      throw Exception("Invalid credentials");
    }
  }
}
