import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_puzzle/functions/fetch.dart';
import 'package:slide_puzzle/screen/auth/auth.wrapper.dart';
import 'package:slide_puzzle/screen/loadiing/loading.screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/fonts.dart';
import '../../utils/images.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController easyController =
      TextEditingController(text: easy.toString());
  TextEditingController mediumController =
      TextEditingController(text: medium.toString());
  TextEditingController hardController =
      TextEditingController(text: hard.toString());
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? LoadingScreen()
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              centerTitle: true,
              title: 'Change level size'.text.white.make(),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
            ),
            body: VxBox(
              child: Column(
                children: [
                  70.heightBox,
                  Row(
                    children: [
                      'Easy mode'
                          .text
                          .fontFamily(Fonts.figtree)
                          .bold
                          .size(20)
                          .white
                          .make(),
                    ],
                  ),
                  20.heightBox,
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: easyController,
                      keyboardType: TextInputType.number,
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
                        hintText: 'Easy mode',
                        prefixIcon: Icon(
                          Icons.numbers,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  20.heightBox,
                  Row(
                    children: [
                      'Medium mode'
                          .text
                          .fontFamily(Fonts.figtree)
                          .bold
                          .size(20)
                          .white
                          .make(),
                    ],
                  ),
                  20.heightBox,
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: mediumController,
                      keyboardType: TextInputType.number,
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
                        hintText: 'Medium mode',
                        prefixIcon: Icon(
                          Icons.numbers,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  20.heightBox,
                  Row(
                    children: [
                      'Hard mode'
                          .text
                          .fontFamily(Fonts.figtree)
                          .bold
                          .size(20)
                          .white
                          .make(),
                    ],
                  ),
                  20.heightBox,
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: hardController,
                      keyboardType: TextInputType.number,
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
                        hintText: 'Hard mode',
                        prefixIcon: Icon(
                          Icons.numbers,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              await FirebaseFirestore.instance
                                  .collection('app')
                                  .doc('mode size')
                                  .update({
                                'easy': int.tryParse(easyController.text) ?? 0,
                                'medium':
                                    int.tryParse(mediumController.text) ?? 0,
                                'hard': int.tryParse(hardController.text) ?? 0,
                              });
                              Get.offAll(AuthWrapper());
                              setState(() {
                                isLoading = false;
                              });
                            } catch (e) {
                              setState(() {
                                isLoading = false;
                              });
                              print(e);
                            }
                          },
                          child: 'Save'.text.make())
                    ],
                  )
                ],
              ),
            )
                .height(MediaQuery.of(context).size.height)
                .width(MediaQuery.of(context).size.width)
                .padding(EdgeInsets.all(20))
                .bgImage(const DecorationImage(
                    image: AssetImage(Images.home_bg), fit: BoxFit.cover))
                .white
                .make(),
          );
  }
}
