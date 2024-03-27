import 'package:flutter/material.dart';
import 'package:recipe_app/services/auth_services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Login Screen",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
          child: ElevatedButton(
        child: Text("Google SignIn"),
        onPressed: () {
          handleSignIn();
        },
      )),
    );
  }
}
