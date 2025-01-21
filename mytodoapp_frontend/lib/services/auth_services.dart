import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytodoapp_frontend/models/user_model.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> signUpUser(UserModel user) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );

    if (userCredential.user != null) {
      UserModel finalUser = UserModel(
        userID: userCredential.user!.uid,
        name: user.name,
        email: user.email,
        password: user.password,
        fcmToken: user.fcmToken,
      );

      await _firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set(finalUser.toJson());
    } else {
      print('User Already Registed!');
    }
  }

  Future<void> signInUser(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
