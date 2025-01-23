import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytodoapp_frontend/models/user_model.dart';

class HomeServices {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  UserModel? user;

  Future<void> getUser() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("Users").doc(_auth.currentUser!.uid).get();

    if (documentSnapshot.exists) {
      UserModel userModel = UserModel(
        userID: '',
        name: documentSnapshot['name'],
        email: documentSnapshot['email'],
        password: '',
        fcmToken: '',
      );

      user = userModel;
    }
  }
}
