import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:slide_puzzle/screen/auth/auth.wrapper.dart';
import 'package:slide_puzzle/screen/game/game.screen.dart';
import 'package:slide_puzzle/screen/leaderboard/leaderboard.dart';
import 'package:slide_puzzle/screen/loadiing/loading.screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../functions/fetch.dart';
import '../utils/fonts.dart';
import '../utils/images.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData(setState);
    getPlayerRank(setState);
  }

  @override
  Widget build(BuildContext context) {
    return username == null
        ? LoadingScreen()
        : Scaffold(
            // appBar: AppBar(),
            body: VxBox(
              child: Column(
                children: [
                  20.heightBox,
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.green,
                        radius: 25,
                        backgroundImage: NetworkImage(
                            'https://i.pinimg.com/originals/ed/dc/c3/eddcc3a683b8650eff4a22f47441b032.jpg'),
                      ),
                      10.widthBox,
                      VxBox(
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow),
                            5.widthBox,
                            '$score'.text.fontFamily(Fonts.figtree).bold.make()
                          ],
                        ),
                      )
                          .padding(EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5))
                          .rounded
                          .border(color: Colors.green, width: 0.5)
                          .white
                          .make(),
                      Spacer(),
                      rank == null
                          ? ''.text.size(30).extraBold.make()
                          : '$rank'.text.size(30).extraBold.make(),
                      5.widthBox,
                      GestureDetector(
                        onTap: () {
                          Get.to(() => LeaderboardScreen());
                        },
                        child: 'Rank'
                            .text
                            .size(15)
                            .gray500
                            .fontFamily(Fonts.figtree)
                            .bold
                            .make(),
                      ),
                      Icon(
                        Icons.show_chart,
                        size: 20,
                        color: Vx.gray500,
                      ),
                    ],
                  ),
                  5.heightBox,
                  Row(
                    children: [
                      '$username'.text.fontFamily(Fonts.figtree).bold.make(),
                    ],
                  ),
                  Row(
                    children: [
                      '$email'.text.size(10).fontFamily(Fonts.figtree).make(),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () => {

                              },
                          child: const Icon(Icons.lightbulb_circle_outlined,
                              color: Colors.blue, size: 30)),
                      15.widthBox,
                      GestureDetector(
                          onTap: () => {
                            FirebaseAuth.instance.signOut(),
                            Get.offAll(AuthWrapper())
                          },
                          child: const Icon(Icons.outbond_outlined,
                              color: Colors.redAccent, size: 30)),
                      Spacer(),
                    ],
                  ),
                  Row(
                    children: [
                      2.widthBox,
                      'Help'.text.size(5).fontFamily(Fonts.figtree).make(),
                      7.widthBox,
                      'Sign out'.text.size(5).fontFamily(Fonts.figtree).make(),
                      Spacer(),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 50,
                            width: 200,
                            child: GlowButton(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green,
                                child: 'Easy'.text.size(25).bold.white.make(),
                                onPressed: () {
                                  Get.to(() => PuzzleScreen());
                                })),
                        10.heightBox,
                        SizedBox(
                            height: 50,
                            width: 200,
                            child: GlowButton(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green,
                                child: 'Medium'.text.size(25).bold.white.make(),
                                onPressed: () {})),
                        10.heightBox,
                        SizedBox(
                            height: 50,
                            width: 200,
                            child: GlowButton(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green,
                                child: 'Hard'.text.size(25).bold.white.make(),
                                onPressed: () {})),
                        10.heightBox,
                      ],
                    ),
                  ),
                ],
              ),
            )
                .height(MediaQuery.of(context).size.height)
                .width(MediaQuery.of(context).size.width)
                .padding(EdgeInsets.all(20))
                // .bgImage(DecorationImage(
                //     image: AssetImage(Images.home_bg), fit: BoxFit.cover))
                .white
                .make(),
          );
  }
}
