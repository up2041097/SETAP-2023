import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/models/book_model.dart';
import 'package:library_management_system/screens/bottom_nav_bar/widgets/book_custom_card.dart';
import 'package:library_management_system/widgets/text_input.dart';

class BooksMainScreen extends StatefulWidget {
  const BooksMainScreen({Key? key}) : super(key: key);

  @override
  State<BooksMainScreen> createState() => _BooksMainScreenState();
}

class _BooksMainScreenState extends State<BooksMainScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 5,
        title: Image.asset(
          'images/logo.png',
          height: 70,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomTextInput(
                controller: searchController,
                icon: Icons.search,
                title: "Search",
                onChange: (v) {
                  setState(() {});
                },
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('books').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("No Book Data Founds"),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        BookModel bookModel = BookModel.fromDocument(snapshot.data!.docs[index]);
                        if (searchController.text.isEmpty) {
                          return BookCustomCard(bookModel: bookModel);
                        } else if (bookModel.bookName!.toLowerCase().contains(searchController.text.toLowerCase()) ||
                            bookModel.authorName!.toLowerCase().contains(searchController.text.toLowerCase())) {
                          return BookCustomCard(bookModel: bookModel);
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
