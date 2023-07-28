import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? username;
  String? email;
  List? reservedBooks;

  UserModel({this.uid, this.email, this.username, this.reservedBooks});
  factory UserModel.fromDocument(DocumentSnapshot snap) {
    return UserModel(
      reservedBooks: snap['reservedBooks'],
      uid: snap['uid'],
      username: snap['username'],
      email: snap['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'reservedBooks': [],
    };
  }
}
