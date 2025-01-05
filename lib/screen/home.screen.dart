import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:slide_puzzle/screen/auth/auth.wrapper.dart';
import 'package:slide_puzzle/screen/game/mode/hard.dart';
import 'package:slide_puzzle/screen/game/mode/medium.dart';
import 'package:slide_puzzle/screen/game/online.easy.dart';
import 'package:slide_puzzle/screen/game/mode/easy.dart';
import 'package:slide_puzzle/screen/leaderboard/leaderboard.dart';
import 'package:slide_puzzle/screen/loadiing/loading.screen.dart';
import 'package:slide_puzzle/screen/profile/profile.screen.dart';
import 'package:slide_puzzle/screen/profile/settings.dart';
import 'package:velocity_x/velocity_x.dart';

import '../functions/fetch.dart';
import '../utils/fonts.dart';
import '../utils/images.dart';
import '../utils/sounds.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioPlayer player = AudioPlayer();


  void bg_music() async {
    if (!isPlaying) {
      await player.setReleaseMode(ReleaseMode.loop); // Set the music to loop
      await player.play(AssetSource(AppSounds.bg_music)); // Play the music
      setState(() {
        isPlaying = true; // Mark as playing
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData(setState);
    getPlayerRank(setState);
    getGameSize(setState);
    bg_music();
  }

  void signOut() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: 'Notice'.text.bold.size(10).make(),
            content: 'Are you sure you want to sign out?'
                .text
                .fontFamily(Fonts.figtree)
                .make(),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: 'Cancel'.text.make()),
              TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Get.back();
                    Get.offAll(AuthWrapper());
                  },
                  child: 'Confirm'.text.make()),
            ],
          );
        });
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
                        backgroundImage: NetworkImage(NetImages.profile),
                      ).animate().fade(duration: 100.ms).scale(delay: 100.ms),
                      10.widthBox,
                      VxBox(
                        child: Row(
                          children: [
                            Image.asset(Assets.trophy, height: 15),
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
                          .make()
                          .animate()
                          .fade(duration: 200.ms)
                          .scale(delay: 200.ms),
                      Spacer(),
                      rank == null || rank == 0
                          ? ''.text.size(30).extraBold.make()
                          : '$rank'.text.size(30).white.extraBold.make(),
                      5.widthBox,
                      GestureDetector(
                        onTap: () {
                          Get.to(() => LeaderboardScreen());
                        },
                        child: 'Rank'
                            .text
                            .size(15)
                            .white
                            .fontFamily(Fonts.figtree)
                            .bold
                            .make(),
                      ),
                      const Icon(
                        Icons.show_chart,
                        size: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  5.heightBox,
                  Row(
                    children: [
                      '$username'
                          .text
                          .white
                          .fontFamily(Fonts.figtree)
                          .bold
                          .make()
                          .animate()
                          .fade(duration: 200.ms)
                          .scale(delay: 200.ms),
                    ],
                  ),
                  Row(
                    children: [
                      '$email'
                          .text
                          .white
                          .size(10)
                          .fontFamily(Fonts.figtree)
                          .make()
                          .animate()
                          .fade(duration: 200.ms)
                          .scale(delay: 200.ms),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () => {},
                          child: const Icon(Icons.lightbulb_circle_outlined,
                              color: Colors.white, size: 30)),
                      15.widthBox,
                      GestureDetector(
                          onTap: () => {
                                signOut(),
                              },
                          child: const Icon(Icons.outbond_outlined,
                              color: Colors.white, size: 30)),
                      15.widthBox,
                      GestureDetector(
                          onTap: () => {Get.to(() => ProfileScreen())},
                          child: const Icon(Icons.person_2_rounded,
                              color: Colors.white, size: 30)),
                      15.widthBox,
                      if(role == 'admin')GestureDetector(
                          onTap: () => {Get.to(() => SettingsScreen())},
                          child: const Icon(Icons.settings,
                              color: Colors.white, size: 30)),
                      Spacer(),
                    ],
                  ).animate().fade(duration: 200.ms).scale(delay: 200.ms),
                  Row(
                    children: [
                      2.widthBox,
                      'Help'
                          .text
                          .size(5)
                          .white
                          .fontFamily(Fonts.figtree)
                          .make(),
                      7.widthBox,
                      'Sign out'
                          .text
                          .size(5)
                          .white
                          .fontFamily(Fonts.figtree)
                          .make(),
                      7.widthBox,
                      'Profile'
                          .text
                          .size(5)
                          .white
                          .fontFamily(Fonts.figtree)
                          .make(),
                      7.widthBox,
                      if(role == 'admin')'Settings'
                          .text
                          .size(5)
                          .white
                          .fontFamily(Fonts.figtree)
                          .make(),
                      Spacer(),
                    ],
                  ).animate().fade(duration: 200.ms).scale(delay: 200.ms),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: GlowButton(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green,
                                      child: 'Easy'
                                          .text
                                          .size(25)
                                          .fontFamily(Fonts.figtree)
                                          .bold
                                          .white
                                          .make(),
                                      onPressed: () {
                                        Get.to(() => EasyMode());
                                      })),
                              20.heightBox,
                              SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: GlowButton(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green,
                                      child: 'Medium'
                                          .text
                                          .size(25)
                                          .fontFamily(Fonts.figtree)
                                          .bold
                                          .white
                                          .make(),
                                      onPressed: () {
                                        Get.to(() => MediumMode());
                                      })),
                              20.heightBox,
                              SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: GlowButton(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green,
                                      child: 'Hard'
                                          .text
                                          .size(25)
                                          .fontFamily(Fonts.figtree)
                                          .bold
                                          .white
                                          .make(),
                                      onPressed: () {
                                        Get.to(() => HardMode());
                                      })),
                              20.heightBox,
                            ],
                          ),
                    ),
                  ).animate().fade(duration: 200.ms).scale(delay: 200.ms),
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
