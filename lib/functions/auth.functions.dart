import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_puzzle/screen/auth/auth.wrapper.dart';

void showSnackBar(BuildContext context,  String message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Notice, $message!'),
    ),
  );
}

class Auth {
  Future<void> SignIn(BuildContext context, String email, password) async {
    try{
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
    } catch(e){
      Navigator.of(context).pop();
      showSnackBar(context, '$e');
    }
  }

  Future<void> SignUp(BuildContext context, String username, email, password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'username': username,
        'email': email,
        'role' : 'user',
        'score': 0,
        'rank': 0,
      });
      Navigator.of(context).pop();
      Get.offAll(AuthWrapper());
      showSnackBar(context, 'Welcome new player!');
    } catch(e){
      Navigator.of(context).pop();
      showSnackBar(context, '$e');
      print(e);
    }
  }
}
