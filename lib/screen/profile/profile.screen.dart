import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../functions/auth.functions.dart';
import '../../utils/fonts.dart';
import '../../utils/images.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.white, foregroundColor: Colors.black),
      body: VxBox(
        child: Column(
          children: [
            VxCircle(radius: 80, backgroundImage: DecorationImage(image: NetworkImage(NetImages.profile)),),
            20.heightBox,
            Row(
              children: [
                'Update username'.text.fontFamily(Fonts.figtree).bold.make(),
              ],
            ),
            10.heightBox,
            SizedBox(
              height: 50,
              child: TextField(
                controller: username,
                keyboardType: TextInputType.text,
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
                  hintText: 'New username',
                  prefixIcon: const Icon(
                    Icons.person_2_outlined,
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
                  child: 'Update'.text.bold.size(15).fontFamily(Fonts.figtree).white.make(),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LoadingAnimationWidget.threeRotatingDots(
                              color: Colors.white, size: 40);
                        });
                    Auth().saveUserProfile(context, username.text);
                    username.clear();
                  }),
            ),
            Spacer(),
            "Version 1.0".text.fontFamily(Fonts.figtree).make()
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
