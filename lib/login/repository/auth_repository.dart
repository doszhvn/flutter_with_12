import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  logIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }
}
