// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:slide_puzzle/screen/auth/forgot.password.dart';
import 'package:slide_puzzle/screen/auth/signup.dart';
import 'package:slide_puzzle/screen/home.screen.dart';
import 'package:slide_puzzle/screen/loadiing/loading.screen.dart';
import 'package:slide_puzzle/utils/fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../functions/auth.functions.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool loading = false;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notice, $message!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? LoadingScreen()
        : Scaffold(
            body: VxBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      'Riddle Resolver'
                          .text
                          .bold
                          .fontFamily(Fonts.figtree)
                          .size(25)
                          .make(),
                    ],
                  ),
                  Row(
                    children: [
                      'Sign in first to continue'
                          .text
                          .fontFamily(Fonts.figtree)
                          .size(15)
                          .make(),
                    ],
                  ),
                  20.heightBox,
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Email',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  20.heightBox,
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_isPasswordVisible,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.green),
                      ),
                    ),
                  ),
                  20.heightBox,
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: GlowButton(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                      onPressed: () {
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          showSnackBar('Please input your email and password');
                        } else {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return
                                  LoadingAnimationWidget.threeRotatingDots(
                                      color: Colors.white, size: 40);
                              });
                          Auth().SignIn(context, emailController.text.trim(),
                              passwordController.text.trim());
                        }
                        // Get.to(()=>HomePage());
                      },
                      child: 'Sign in'.text.white.make(),
                    ),
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Don't have an account?"
                          .text
                          .fontFamily(Fonts.figtree)
                          .make(),
                      5.widthBox,
                      TextButton(
                          onPressed: () {
                            Get.to(() => SignUpScreen());
                          },
                          child: "Sign up"
                              .text
                              .bold
                              .fontFamily(Fonts.figtree)
                              .make()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Get.to(() => ForgotPassword());
                          },
                          child: "Forgot password"
                              .text
                              .bold
                              .fontFamily(Fonts.figtree)
                              .make()),
                    ],
                  )
                ],
              ),
            )
                .height(MediaQuery.of(context).size.height)
                .width(MediaQuery.of(context).size.width)
                .padding(EdgeInsets.all(40))
                .white
                .make(),
          );
  }
}
