import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String? username;
String? role;
int? score;
String? email;
int? rank;

int? easy;
int? medium;
int? hard;

Future<void> getUserData(setState) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.email.toString())
      .get();
  setState(() {
    username = snapshot.data()?['username'];
    role = snapshot.data()?['role'];
    score = snapshot.data()?['score'];
    email = snapshot.data()?['email'];
  });
  print('$score, $role, $email, $username');
}

Future<void> getGameSize(setState) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('app')
      .doc('mode size')
      .get();
  setState(() {
    easy = snapshot.data()?['easy'];
    medium = snapshot.data()?['medium'];
    hard = snapshot.data()?['hard'];
  });
  print('$easy, $medium, $hard');
}

Future<int> getPlayerRank(setState) async {
  try {
    // Fetch all users and sort them by score in descending order
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('score', descending: true)
        .where('score', isGreaterThan: 1)
        .get();

    // Get the list of documents (players)
    List<QueryDocumentSnapshot> users = querySnapshot.docs;

    // Iterate to find the player's rank
    for (int i = 0; i < users.length; i++) {
      if (users[i].id == FirebaseAuth.instance.currentUser!.email.toString()) {
        // Rank is index + 1 since ranks are 1-based
        print('rank : $i');
        setState(() {
          rank = i + 1;
        });
        return i + 1;
      }
    }

    // If player email is not found
    throw Exception("Player not found in the leaderboard.");
  } catch (e) {
    print("Error getting player rank: $e");
    return -1; // Return -1 to indicate an error
  }
}

