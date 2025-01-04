import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:slide_puzzle/screen/auth/signin.dart';
import 'package:slide_puzzle/screen/home.screen.dart';
import 'package:slide_puzzle/screen/loadiing/loading.screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../functions/auth.functions.dart';
import '../../utils/fonts.dart';
import '../../utils/images.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool _isPasswordVisible = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title:
                  'Create Account'.text.fontFamily(Fonts.figtree).bold.make(),
            ),
            body: VxBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: username,
                      keyboardType: TextInputType.text,
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
                        hintText: 'Username',
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  20.heightBox,
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: email,
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
                      controller: password,
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
                        prefixIcon:
                            Icon(Icons.lock_outline, color: Colors.green),
                      ),
                    ),
                  ),
                  20.heightBox,
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: confirmPassword,
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
                        hintText: 'Confirm password',
                        // suffixIcon: IconButton(
                        //   icon: Icon(
                        //     _isPasswordVisible
                        //         ? Icons.visibility
                        //         : Icons.visibility_off,
                        //   ),
                        //   onPressed: () {
                        //     setState(() {
                        //       _isPasswordVisible = !_isPasswordVisible;
                        //     });
                        //   },
                        // ),
                        prefixIcon:
                            Icon(Icons.lock_outline, color: Colors.green),
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
                        if (email.text.isEmpty ||
                            username.text.isEmpty ||
                            confirmPassword.text.isEmpty ||
                            password.text.isEmpty) {
                          showSnackBar(
                              context, 'Please input the required details.');
                        } else if (confirmPassword.text != password.text) {
                          showSnackBar(context, 'Password not match.');
                        } else {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return LoadingAnimationWidget.threeRotatingDots(
                                    color: Colors.white, size: 40);
                              });
                          Auth().SignUp(
                              context,
                              username.text,
                              email.text.toLowerCase().trim(),
                              confirmPassword.text.trim());
                        }
                      },
                      child: 'Sign up'.text.white.make(),
                    ),
                  ),
                  20.heightBox,
                ],
              ),
            )
                .height(MediaQuery.of(context).size.height)
                .width(MediaQuery.of(context).size.width)
                .padding(EdgeInsets.only(left: 40, right: 40))
                .bgImage(DecorationImage(
                    image: AssetImage(Images.home_bg), fit: BoxFit.cover))
                .make(),
          );
  }
}
