import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/fonts.dart';
import '../../utils/images.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: 'Leaderboard'.text.bold.make(),
      ),
      body: VxBox(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .orderBy('score', descending: true)
                .where('score', isGreaterThan: 1)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text("Error fetching data."));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No players have played yet."));
              }
              // Extract data
              final users = snapshot.data!.docs;

              // Get current user's UID
              final currentUserEMAIL = FirebaseAuth.instance.currentUser?.email;
              for (int i = 0; i < users.length; i++) {
                if (users[i].id == currentUserEMAIL) {
                  // rank = i + 1; // Rank is index + 1
                  break;
                }
              }
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final username = user['username'];
                  final score = user['score'];
                  final e = user['E'];
                  final m = user['M'];
                  final h = user['H'];
                  final accEmail = user['email'];

                  return GestureDetector(
                    onTap: () {
                      // Handle onTap if needed
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
                      child: VxBox(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              10.widthBox,
                              Expanded(
                                child: VxBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          '$username'.text.bold.size(15).make(),
                                          Spacer(),
                                          "${index + 1}"
                                              .text
                                              .extraBold
                                              .size(30)
                                              .gray900
                                              .make(),
                                          'Rank'
                                              .text
                                              .size(12)
                                              .gray500
                                              .fontFamily(Fonts.figtree)
                                              .bold
                                              .make(),
                                          const Icon(
                                            Icons.show_chart,
                                            size: 12,
                                            color: Vx.gray500,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          'Mode play(E/M/H): '
                                              .text
                                              .fontFamily(Fonts.figtree)
                                              .size(10)
                                              .make(),
                                          '$e/$m/$h'.text.bold.size(10).make(),
                                          Spacer(),
                                          Image.asset(Assets.trophy,
                                              height: 15),
                                          '$score'.text.size(15).bold.make(),
                                          ' - Scores'
                                              .text
                                              .gray500
                                              .size(12)
                                              .make(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ).make(),
                              ),
                            ],
                          ),
                        ),
                      )
                          .height(100)
                          .border(color: Colors.green)
                          .rounded
                          .shadowXs
                          .color(accEmail == FirebaseAuth.instance.currentUser!.email.toString() ? Vx.green100 : Colors.white)
                          .make(),
                    ),
                  );
                },
              );
            }),
      )
          .height(MediaQuery.of(context).size.height)
          .width(MediaQuery.of(context).size.width)
          .white
          .make(),
    );
  }
}
