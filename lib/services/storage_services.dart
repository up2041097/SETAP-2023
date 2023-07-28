import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class StorageServices {
  String? imageLink;

  Future uploadImageToDataBase({File? selectedImage}) async {
    try {
      FirebaseStorage fs = FirebaseStorage.instance;
      Reference ref = fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
      await ref.putFile(File(selectedImage!.path));
      imageLink = await ref.getDownloadURL();
      return imageLink!;
    } on FirebaseException catch (e) {
      EasyLoading.showError(e.message.toString());
      EasyLoading.dismiss();
    }
  }
}
