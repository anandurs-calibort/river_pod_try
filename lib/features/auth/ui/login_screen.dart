import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_notifier.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Demo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Static UI: not affected by state
            const Text("Welcome! Please log in."),
            const SizedBox(height: 20),

            SizedBox(
              width: 300,
              child: TextFormField(

              ),
            ),
            TextFormField(

            ),Consumer(
              builder: (context, ref, _) {
                final authState = ref.watch(authNotifierProvider);

                return ElevatedButton(
                  onPressed: authState.isLoading
                      ? null
                      : () {
                    ref
                        .read(authNotifierProvider.notifier)
                        .login("test@mail.com", "123456");
                  },
                  child: authState.isLoading
                      ? const CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2)
                      : const Text("Login"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
