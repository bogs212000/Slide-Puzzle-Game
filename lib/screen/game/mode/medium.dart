import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:slide_puzzle/screen/game/online.easy.dart';
import 'package:slide_puzzle/screen/game/online.medium.dart';
import 'package:slide_puzzle/utils/images.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../functions/fetch.dart';
import '../../../utils/fonts.dart';
import '../../../utils/text.dart';
import '../offline/offline.game.dart';

class MediumMode extends StatefulWidget {
  const MediumMode({super.key});

  @override
  State<MediumMode> createState() => _MediumModeState();
}

class _MediumModeState extends State<MediumMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: 'Medium Mode'.text.white.bold.make(),
      ),
      body: VxBox(
        child: Column(
          children: [
            70.heightBox,
            Txt.note_play_online.text
                .size(15)
                .fontFamily(Fonts.figtree)
                .bold
                .white
                .make(),
            20.heightBox,
            VxBox(
              child: Column(
                children: [
                  Row(
                    children: [
                      'Online Mode'
                          .text
                          .size(20)
                          .color(Colors.green)
                          .bold
                          .make(),
                      Image.asset(Assets.trophy, height: 20),
                      Spacer(),
                      '$medium x $medium'
                          .text
                          .size(15)
                          .fontFamily(Fonts.figtree)
                          .bold
                          .make(),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Spacer(),
                      SizedBox(
                        height: 40,
                        width: 80,
                        child: GlowButton(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                            child: "PLAY".text.white.make(),
                            onPressed: () => {
                                  Get.to(() => OnlineMedium(),
                                      arguments: [1, medium])
                                }),
                      )
                    ],
                  ),
                ],
              ),
            )
                // .height(100)
                .width(MediaQuery.of(context).size.width)
                .rounded
                .border(color: Colors.green)
                .white
                .padding(EdgeInsets.all(20))
                .make()
                .animate()
                .fade(duration: 200.ms)
                .scale(delay: 200.ms),
            10.heightBox,
            VxBox(
              child: Column(
                children: [
                  Row(
                    children: [
                      'Offline Mode'
                          .text
                          .size(20)
                          .color(Colors.green)
                          .bold
                          .make(),
                      Spacer(),
                      '$medium x $medium'
                          .text
                          .size(15)
                          .fontFamily(Fonts.figtree)
                          .bold
                          .make(),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Spacer(),
                      SizedBox(
                        height: 40,
                        width: 80,
                        child: GlowButton(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                            child: "PLAY".text.white.make(),
                            onPressed: () => {
                                  Get.to(() => OfflineGame(),
                                      arguments: [1, medium])
                                }),
                      )
                    ],
                  ),
                ],
              ),
            )
                // .height(100)
                .width(MediaQuery.of(context).size.width)
                .rounded
                .border(color: Colors.green)
                .white
                .padding(EdgeInsets.all(20))
                .make()
                .animate()
                .fade(duration: 400.ms)
                .scale(delay: 400.ms),
          ],
        ),
      )
          .height(MediaQuery.of(context).size.height)
          .width(MediaQuery.of(context).size.width)
          .padding(EdgeInsets.all(20))
          .bgImage(DecorationImage(
              image: AssetImage(Images.home_bg), fit: BoxFit.cover))
          .white
          .make(),
    );
  }
}
