import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  String? userId;
  String? bookId;
  String? bookName;
  String? authorName;
  String? bookImage;

  BookModel({
    this.bookId,
    this.authorName,
    this.bookImage,
    this.bookName,
    this.userId,
  });

  factory BookModel.fromDocument(DocumentSnapshot snap) {
    return BookModel(
      bookId: snap['bookId'],
      userId: snap['uid'],
      bookName: snap['bookName'],
      bookImage: snap['bookImage'],
      authorName: snap['authorName'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'uid': userId,
      'bookName': bookName,
      'bookImage': bookImage,
      'authorName': authorName,
    };
  }
}
