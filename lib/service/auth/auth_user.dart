import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;
  final String email;
  final String id;
  const AuthUser({required this.id,required this.email, required this.isEmailVerified});

//factory constructor
  factory AuthUser.fromFirebase(FirebaseAuth.User user) => AuthUser(
        id:user.uid,
        email: user.email!,
        isEmailVerified: user.emailVerified,
      );
}

//class MyAuthUser extends AuthUser {}
