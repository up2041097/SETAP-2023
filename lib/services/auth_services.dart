import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:library_management_system/models/user_model.dart';
import 'package:library_management_system/utils/navigations.dart';

import '../screens/bottom_nav_bar/bottom_nav_bar.dart';

class AuthServices {
  static signUp({BuildContext? context, String? email, String? password, String? username}) async {
    if (username!.isEmpty) {
      EasyLoading.showError("Please Enter Your Full Name");
    } else if (email!.isEmpty) {
      EasyLoading.showError("Please Enter Your Email");
    } else if (password!.isEmpty) {
      EasyLoading.showError("Please Enter Your Password");
    } else {
      try {
        EasyLoading.show(status: "Please Wait");
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        UserModel userModel = UserModel(
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: email,
          username: username,
        );
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(userModel.toMap());
        EasyLoading.dismiss();
        navigateToPage(context!, const BottomNavBAr());
      } on FirebaseAuthException catch (e) {
        EasyLoading.dismiss();
        EasyLoading.showError(e.message.toString());
      }
    }
  }

  static signIn({BuildContext? context, String? email, String? password}) async {
    if (email!.isEmpty) {
      EasyLoading.showError("Email Must Be Filled");
    } else if (password!.isEmpty) {
      EasyLoading.showError("Password Must Be Filled");
    } else {
      try {
        EasyLoading.show(status: "Please Wait");
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        EasyLoading.dismiss();
        navigateToPage(context!, const BottomNavBAr());
      } on FirebaseAuthException catch (e) {
        EasyLoading.showError(e.message.toString());
        EasyLoading.dismiss();
      }
    }
  }
}
