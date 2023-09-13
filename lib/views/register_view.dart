import 'package:flutter/material.dart';
import 'package:mynotes_learn/constants/routes.dart';
import 'package:mynotes_learn/service/auth/auth_exceptions.dart';
import 'package:mynotes_learn/service/auth/auth_service.dart';
import 'package:mynotes_learn/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register view'),
      ),
      body: Column(children: [
        TextField(
          controller: _email,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: 'Enter your email here'),
        ),
        TextField(
          controller: _password,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration:
              const InputDecoration(hintText: 'Enter your Password here'),
        ),
        TextButton(
          onPressed: () async {
            final email = _email.text;
            final password = _password.text;
            try {
              //can remover userCredential var
              await AuthService.firebase().createUser(
                email: email,
                password: password,
              );
              //will not remove the page b4
              final user = AuthService.firebase().currentUser;
              await AuthService.firebase().sendEmailVerification();
              //if (!mounted) return;
              Navigator.of(context).pushNamed(verifyEmailRoute);
            } on WeakPasswordAuthException {
              await showErrorDialog(
                context,
                'Your password is too weak.',
              );
            } on EmailAlreadyInUseAuthException {
              await showErrorDialog(
                context,
                'The email you key in is already in use',
              );
            } on InvalidEmailAuthException {
              await showErrorDialog(
                context,
                'Format of your email is wrong',
              );
            } on GenericAuthException {
              await showErrorDialog(
                context,
                'Failed to register',
              );
            } catch (e) {
              await showErrorDialog(
                context,
                e.toString(),
              );
            }
          },
          child: const Text('Register'),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already Registered? Login Here'))
      ]),
    );
  }
}
