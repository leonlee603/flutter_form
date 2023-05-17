import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this.submitFn, this.isLoading, {super.key});

  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
  ) submitFn;

  final bool isLoading;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  final _userNameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  void trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      // print(_userEmail);
      // print(_userName);
      // print(_userPassword);
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
      );
    }
  }

  @override
  void dispose() {
    _userNameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email address can't be empty.";
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                  ),
                  onFieldSubmitted: (value) {
                    if (_isLogin) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    } else {
                      FocusScope.of(context).requestFocus(_userNameFocusNode);
                    }
                  },
                  onSaved: (newValue) {
                    _userEmail = newValue!;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 4) {
                        return "Please enter at least 4 characters";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    focusNode: _userNameFocusNode,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    onSaved: (newValue) {
                      _userName = newValue!;
                    },
                  ),
                TextFormField(
                  key: const ValueKey('password'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 7) {
                      return "Password must be at least 7 characters long.";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  focusNode: _passwordFocusNode,
                  onSaved: (newValue) {
                    _userPassword = newValue!;
                  },
                ),
                const SizedBox(height: 12.0),
                if (widget.isLoading)
                  const SizedBox(
                    height: 96,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (!widget.isLoading)
                  ElevatedButton(
                    onPressed: trySubmit,
                    child: Text(_isLogin ? 'Login' : 'SignUp'),
                  ),
                if (!widget.isLoading)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin
                          ? 'Create new account'
                          : 'Already have an account',
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
