import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:library_management_system/models/book_model.dart';
import 'package:library_management_system/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:library_management_system/services/storage_services.dart';
import 'package:uuid/uuid.dart';

class DataBaseServices {
  static addBookInformation({String? bookName, File? bookImage, String? authorName, BuildContext? context}) async {
    try {
      if (bookImage == null || bookName!.isEmpty || authorName!.isEmpty) {
        EasyLoading.showError("All Field Are Required");
      } else {
        var bookId = const Uuid().v4();
        EasyLoading.show(status: "Please Wait");
        String image = await StorageServices().uploadImageToDataBase(selectedImage: bookImage);
        BookModel bookModel = BookModel(
          bookId: bookId,
          userId: FirebaseAuth.instance.currentUser!.uid,
          bookName: bookName,
          bookImage: image,
          authorName: authorName,
        );
        await FirebaseFirestore.instance.collection("books").doc(bookId).set(bookModel.toMap());
        EasyLoading.dismiss();
        Navigator.pop(context!);
      }
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message.toString());
    }
  }

  static reservedBook(BuildContext context, String bookId) async {
    try {
      EasyLoading.show(status: "Please Wait");
      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();

      if (snap['reservedBooks'].contains(bookId)) {
        EasyLoading.showError("You Already Reserved This Book");
      } else {
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
          "reservedBooks": FieldValue.arrayUnion([bookId]),
        });
        EasyLoading.dismiss();
        EasyLoading.showSuccess("Successfully Added");
        Navigator.of(context!).push(MaterialPageRoute(builder: (_) => const BottomNavBAr()));
      }
    } on FirebaseException catch (e) {
      EasyLoading.showError(e.message.toString());
      EasyLoading.dismiss();
    }
  }
}
