import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:slide_puzzle/screen/game/online.easy.dart';
import 'package:slide_puzzle/utils/images.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../functions/fetch.dart';
import '../../../utils/fonts.dart';
import '../../../utils/text.dart';
import '../offline/offline.game.dart';
import '../online.hard.dart';

class HardMode extends StatefulWidget {
  const HardMode({super.key});

  @override
  State<HardMode> createState() => _HardModeState();
}

class _HardModeState extends State<HardMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: 'Hard Mode'.text.bold.make(),
      ),
      body: VxBox(
        child: Column(
          children: [
            Txt.note_play_online.text.size(15).fontFamily(Fonts.figtree).bold.make(),
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
                      '$hard x $hard'.text.size(15).fontFamily(Fonts.figtree).bold.make(),

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
                            onPressed: ()=> {
                              Get.to(() => OnlineHard(), arguments:[ 1, hard])
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
                .padding(EdgeInsets.all(20))
                .make().animate().fade(duration: 200.ms).scale(delay: 200.ms),
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
                      '$hard x $hard'.text.size(15).fontFamily(Fonts.figtree).bold.make(),
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
                            onPressed: ()=> {
                              Get.to(() => OfflineGame(), arguments:[ 1, hard])
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
                .padding(EdgeInsets.all(20))
                .make().animate().fade(duration: 400.ms).scale(delay: 400.ms),
          ],
        ),
      )
          .height(MediaQuery.of(context).size.height)
          .width(MediaQuery.of(context).size.width)
          .padding(EdgeInsets.all(20))
          .white
          .make(),
    );
  }
}
