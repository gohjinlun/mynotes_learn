import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes_learn/views/login_view.dart';
import 'package:mynotes_learn/views/register_view.dart';

import 'firebase_options.dart';

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
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView()
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            // final user = FirebaseAuth.instance.currentUser;
            // print(FirebaseAuth.instance.currentUser);
            // //final emailVerified = user?.emailVerified ?? false;
            // if (user?.emailVerified ?? false) {
            //   print('You are a verified user');
            //   return const Text('Done！');
            // } else {
            //   print('You need to verify your email');
            //   //not a good idea to do it like this
            //   // Navigator.of(context).push(MaterialPageRoute(
            //   //  builder: (context) => const VerifyEmailView()));
            //   return const VerifyEmailView();
            // }
            print("done");
            //return const Text('Done！');
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //   '/login/',
            //   (route) => false,
            // );
            return const LoginView();
          // return const Text('Done');
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
