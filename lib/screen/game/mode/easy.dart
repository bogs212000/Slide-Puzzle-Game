import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:slide_puzzle/screen/game/online.easy.dart';
import 'package:slide_puzzle/utils/images.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/fonts.dart';
import '../../../utils/text.dart';
import '../offline/offline.game.dart';

class EasyMode extends StatefulWidget {
  const EasyMode({super.key});

  @override
  State<EasyMode> createState() => _EasyModeState();
}

class _EasyModeState extends State<EasyMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: 'Easy Mode'.text.bold.make(),
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
                      '4x4'.text.size(15).fontFamily(Fonts.figtree).bold.make(),

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
                              Get.to(() => OnlineEasy(), arguments:[ 1, 2])
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
                .make(),
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
                      '4x4'.text.size(15).fontFamily(Fonts.figtree).bold.make(),
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
                              Get.to(() => OfflineGame(), arguments:[ 1, 4])
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
                .make(),
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
