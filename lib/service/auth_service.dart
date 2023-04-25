import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/toast.dart';

import '../pages/auth/signin_page.dart';
import '../utils/log_service.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static bool isLoggedIn() {
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser != null;
  }

  static String currentUserId() {
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser!.uid;
  }

  static Future<User?> signInUser(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final User firebaseUser = _auth.currentUser!;
      return firebaseUser;
    }catch(e){
      Log.e(e.toString());
    }
    return null;
  }

  static Future<User?> signUpUser(
      String fullName,
      String email,
      String password) async {
    try{
      var authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Log.i(authResult.additionalUserInfo.toString());
      User? user = authResult.user;

      return user;
    }catch(e){
      Log.e(e.toString());
     // fireToast(e.toString());
    }
    return null;

  }

  static Future<void> signOutUser(BuildContext context) async {
   await  _auth.signOut();
    Navigator.pushReplacementNamed(context, '/SignInPage');
  }
}
