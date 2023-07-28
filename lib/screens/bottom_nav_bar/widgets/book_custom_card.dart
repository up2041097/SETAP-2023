import 'package:flutter/material.dart';
import 'package:library_management_system/models/book_model.dart';
import 'package:library_management_system/screens/bottom_nav_bar/books/book_detail_screen.dart';
import 'package:library_management_system/utils/navigations.dart';

class BookCustomCard extends StatelessWidget {
  final BookModel bookModel;
  const BookCustomCard({super.key, required this.bookModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToPage(context, BookDetailScreen(data: bookModel));
      },
      child: Card(
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
                  child: Image.network(bookModel.bookImage!, fit: BoxFit.fill),
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
                        bookModel.bookName!,
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
                        "Author:${bookModel.authorName!}",
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
    );
  }
}
