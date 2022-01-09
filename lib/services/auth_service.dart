import 'dart:async';
import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  get onAuthStateChanged =>
      FirebaseAuth.instance.authStateChanges().map((user) => user?.uid);
  Future<String> getCurrentUID() async {
    String? uid = (await _firebaseAuth.currentUser)?.uid;
    if (uid != null) {
      return uid;
    } else {
      return "no uid";
    }
  }

  //Emails $ PW sign up
  Future createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    //Update the username
    if (currentUser.user != null) {
      await updateUserName(name, currentUser.user);
    }
    return currentUser.user?.uid;
  }

  Future<void> updateUserName(String name, User? currentUser) async {
    var userUpdateInfo = _firebaseAuth.currentUser;
    userUpdateInfo?.updateDisplayName(name);
    await currentUser?.updateDisplayName(name);
    await currentUser?.reload();
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

  //create Anonymous user
  Future signInAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }

  //link anonymous user to EmailAccount
  Future convertUserWithEmail(
      String email, String password, String name) async {
    final currentUser = await _firebaseAuth.currentUser;

    final credential =
        EmailAuthProvider.credential(email: email, password: password);
    await currentUser?.linkWithCredential(credential);
    await updateUserName(name, currentUser);
  }

  //link anonymous account to google account
  Future convertWithGoogle() async {
    final currentUser = await _firebaseAuth.currentUser;

    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? _googleAuth =
        await account?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleAuth?.idToken,
      accessToken: _googleAuth?.accessToken,
    );
    await currentUser?.linkWithCredential(credential);
    final String? name = _googleSignIn.currentUser?.displayName;
    if (name != null) {
      await updateUserName(name, currentUser);
    }
  }

  // google sign in
  Future<String?> signInWithGoogle() async {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? _googleAuth =
        await account?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleAuth?.idToken,
      accessToken: _googleAuth?.accessToken,
    );
    return (await _firebaseAuth.signInWithCredential(credential)).user?.uid;
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
    if (value.length > 50) {
      return "Name must be less than 50 characters long";
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
