import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/screens/bottom_nav_bar/widgets/custom_reserved_card.dart';

class BookReservedScreen extends StatelessWidget {
  const BookReservedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Reserved"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data!.data() as Map<String, dynamic>;
          var reservedIds = data['reservedBooks'] as List;
          if (reservedIds.isEmpty) {
            return const Center(child: Text("No Book Found"));
          }
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("books")
                .where(FieldPath.documentId, whereIn: reservedIds)
                .snapshots(),
            builder: (context, bookSnap) {
              if (!bookSnap.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (bookSnap.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No Book Reserved"),
                );
              }
              return ListView.builder(
                itemCount: bookSnap.data!.docs.length,
                itemBuilder: (context, index) {
                  return CustomReservedCard(data: bookSnap.data!.docs[index]);
                },
              );
            },
          );
        },
      ),
    );
  }
}
