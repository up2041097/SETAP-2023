import 'package:flutter/material.dart';
import 'package:library_management_system/screens/bottom_nav_bar/logout_screen/logout_screen.dart';
import 'package:library_management_system/screens/bottom_nav_bar/reserved/book_reserved_screen.dart';

import '../../utils/navigations.dart';
import 'books/book_adding_screen.dart';
import 'books/books_main_screen.dart';

class BottomNavBAr extends StatefulWidget {
  const BottomNavBAr({Key? key}) : super(key: key);

  @override
  State<BottomNavBAr> createState() => _BottomNavBArState();
}

class _BottomNavBArState extends State<BottomNavBAr> {
  int currentIndex = 0;
  List pages = [
    const BooksMainScreen(),
    const BookReservedScreen(),
    const LogOutScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToPage(context, const BookAddingScreen());
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.none,
        height: 90,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.home,
                      color: currentIndex == 0 ? Colors.deepPurple : Colors.grey,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        color: currentIndex == 0 ? Colors.deepPurple : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.home_repair_service_outlined,
                      color: currentIndex == 1 ? Colors.deepPurple : Colors.grey,
                    ),
                    Text(
                      "Reserved",
                      style: TextStyle(
                        color: currentIndex == 1 ? Colors.deepPurple : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.logout,
                      color: currentIndex == 2 ? Colors.deepPurple : Colors.grey,
                    ),
                    Text(
                      "LogOut",
                      style: TextStyle(
                        color: currentIndex == 2 ? Colors.deepPurple : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
