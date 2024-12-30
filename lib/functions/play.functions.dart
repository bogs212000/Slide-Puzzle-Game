import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> addScore(int score) async {
  try {
    String userEmail = FirebaseAuth.instance.currentUser!.email.toString();
    final userRef =
    FirebaseFirestore.instance.collection('users').doc(userEmail);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final userDoc = await transaction.get(userRef);
      if (!userDoc.exists) {
        throw Exception("User does not exist!");
      }

      final currentScore =
          userDoc['score'] ?? 0; // Default to 0 if not present
      transaction.update(userRef, {
        'score': currentScore + score, // Increment total score
      });
    });
  } catch(e){
    print(e);
  }
}

