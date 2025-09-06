import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/user_model.dart';
import '../../../core/network/network_service.dart';
import '../../../core/storage/shared_prefs_helper.dart';
import '../../../service/auth/auth_service.dart';
import '../data/auth_repository.dart';

/// ---------------- STATE ----------------
class AuthState {
  final bool isLoading;
  final UserModel? user;
  final String? error;

  const AuthState({this.isLoading = false, this.user, this.error});

  AuthState copyWith({bool? isLoading, UserModel? user, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}

/// ---------------- NOTIFIER ----------------
class AuthNotifier extends Notifier<AuthState> {
  late final AuthService _service;

  @override
  AuthState build() {
    _service = ref.read(authServiceProvider);
    return const AuthState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _service.loginUser(email, password);
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

/// ---------------- PROVIDERS ----------------
final networkServiceProvider = Provider((ref) => NetworkService());
final prefsHelperProvider = Provider((ref) => SharedPrefsHelper());

final authRepositoryProvider = Provider(
      (ref) => AuthRepository(ref.read(networkServiceProvider), ref.read(prefsHelperProvider)),
);

final authServiceProvider = Provider(
      (ref) => AuthService(ref.read(authRepositoryProvider)),
);

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
