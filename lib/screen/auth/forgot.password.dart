import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../functions/auth.functions.dart';
import '../../utils/fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: 'Forgot Password'.text.bold.make(),
        centerTitle: true,
      ),
      body: VxBox(
        child: Column(
          children: [
            30.heightBox,
            'Kindly provide your email address, and we will send a link to reset your password to your inbox.'
                .text
                .size(20)
                .fontFamily(Fonts.figtree)
                .make(),
            20.heightBox,
            SizedBox(
              height: 50,
              child: TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              width: double.infinity,
              child: GlowButton(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green,
                onPressed: () {
                  if (email.text.isEmpty) {
                    showSnackBar(
                        context, 'Please enter your email address.');
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return
                            LoadingAnimationWidget.threeRotatingDots(
                                color: Colors.white, size: 40);
                        });
                    Auth().sendChangePasswordLink(context, email.text.toLowerCase().trim());
                  }
                },
                child: 'Request link'.text.white.make(),
              ),
            ),
          ],
        ),
      )
          .height(MediaQuery.of(context).size.height)
          .width(MediaQuery.of(context).size.width)
          .white
          .padding(EdgeInsets.all(40))
          .make(),
    );
  }
}
