// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slide_puzzle/screen/auth/signin.dart';
import 'package:slide_puzzle/screen/home.screen.dart';



class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? email = FirebaseAuth.instance.currentUser?.email.toString();
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> userData) {
        if (!userData.hasData) {
          return Center(
            // child: Lottie.asset('assets/lottie/animation_loading.json',
            //     width: 100, height: 100),
          );
        } else if (userData.connectionState == ConnectionState.waiting) {
          return Center(
            // child: Lottie.asset('assets/lottie/animation_loading.json',
            //     width: 100, height: 100),
          );
        } else if (userData.hasError) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Something went wrong!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 231, 25, 25),
                ),
              ),
            ],
          );
        } else if (userData.hasData) {
          return Builder(
            builder: (
                context,
                ) {
              if ((userData.data!['role'] == "user")) {
                return HomePage();
              }
              else {
                return SignInScreen();
              }
            },
          );
        } else {
          return SignInScreen();
        }
      },
    );
  }
}