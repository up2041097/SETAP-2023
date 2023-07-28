import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/models/book_model.dart';
import 'package:library_management_system/services/database_services.dart';
import 'package:library_management_system/widgets/buttons.dart';

class BookDetailScreen extends StatefulWidget {
  final BookModel data;
  const BookDetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  List reservedBookList = [];

  getReservedBookList() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      reservedBookList = snap['reservedBooks'];
    });
  }

  @override
  void initState() {
    getReservedBookList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: const Text("Book Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 150,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 05),
                      height: 130,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(widget.data.bookImage!, fit: BoxFit.fill),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              widget.data.bookName!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 200,
                            child: Text(
                              "Author:${widget.data.authorName!}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (reservedBookList.contains(widget.data.bookId))
              PrimaryButton(
                onPressed: () {},
                title: "Reserved",
              )
            else
              PrimaryButton(
                onPressed: () async {
                  await DataBaseServices.reservedBook(context, widget.data.bookId!);
                },
                title: "Reserve",
              )
          ],
        ),
      ),
    );
  }
}
