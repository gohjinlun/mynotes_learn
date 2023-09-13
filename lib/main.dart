//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes_learn/constants/routes.dart';
import 'package:mynotes_learn/service/auth/auth_service.dart';
import 'package:mynotes_learn/views/login_view.dart';
import 'package:mynotes_learn/views/notes/create_update_note_view.dart';
import 'package:mynotes_learn/views/notes/notes_view.dart';
import 'package:mynotes_learn/views/register_view.dart';
import 'package:mynotes_learn/views/verify_email_view.dart';
import 'dart:developer' as devtools show log;


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Mynotes Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        createOrUpdateNoteRoute: ((context) => const CreateUpdateNoteView()),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              //to make the stream FirebaseAuth.instance.userChanges() will get triggered if emailVerified has changed.
              FirebaseAuth.instance.currentUser?.reload();
              // user.reload(); when direct using the firebaseAuth
              if (user.isEmailVerified) {
                devtools.log('Email is verified');
              } else {
                // Navigator.of(context).push(MaterialPageRoute(
                //   //  builder: (context) => const VerifyEmailView()));
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
            //if everything ok and logged in
            return const NotesView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
