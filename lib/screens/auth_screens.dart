import 'package:flutter/material.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
  ) async {
    // print(email);
    // print(password);
    // print(username);
    // print(isLogin);
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        // Logic for login ...
      } else {
        // Logic for create a new user ...
      }
    } catch (err) {
      // print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
