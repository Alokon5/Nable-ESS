import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/data/models/management_user_model.dart';
import 'package:nable_ess/app/data/providers/storage_provider.dart';

import '../../core/values/keys.dart';

class FirebaseProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // ignore: unused_field
  final StorageProvider _storageProvider = StorageProvider();

  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (!userCredential.user!.emailVerified) {
        userCredential.user!.sendEmailVerification();
      }

      // await _storageProvider.writeUserModel(userModel);
      printInfo(info: "Login SuccessFully");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Warning", "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", 'The account already exists for that email.');
      } else if (e.code == 'operation-not-allowed') {
        Get.snackbar("Error", 'There is a problem with auth service config');
      } else {
        Get.snackbar("Error", e.code);
      }
      return false;
    }
  }

  // For Testing Purpuse
  Future<bool> createManagementUser(
      String name, String email, String password) async {
    CollectionReference users =
        _firestore.collection(KeysConstant.managementUser);
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: "prakhar@gmail.com", password: "India@123");
      ManagemenetUserModel management = ManagemenetUserModel(
        email: email,
        emailVerified: user.user!.emailVerified,
        name: name,
        phoneNumber: user.user!.phoneNumber,
        photoUrl: user.user!.photoURL,
        role: "MANAGEMENT",
        uid: user.user!.uid,
      );
      users.doc(user.user!.uid).set(management.toJson());
      return true;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    }
  }
}
