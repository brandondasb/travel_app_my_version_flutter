import 'dart:async';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//had to chagne this a lil
//   get onAuthStateChanged =>
//       FirebaseAuth.instance.authStateChanges().listen((User? user) {
//         if (user == null) {
//           print('User is currently signed out!');
//         } else {
//           print('User is signed in!');
//         }
//       });
  get onAuthStateChanged =>
      FirebaseAuth.instance.authStateChanges().map((user) => user?.uid);

  //Emails $ PW sign up
  Future createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    //Update the username
    var userUpdateInfo = _firebaseAuth.currentUser;
    userUpdateInfo?.updateDisplayName(name);
    await currentUser.user?.updateDisplayName(name);
    await currentUser.user?.reload();
    return currentUser.user?.uid;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        ?.uid;
  }

  signOut() {
    return _firebaseAuth.signOut();
  }

  //reset PW
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}

class EmailValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}

class NameValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if (value.length > 2) {
      return "Name must be at less than 50 characters long";
    }
    return null;
  }
}

class PasswordValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }
}
