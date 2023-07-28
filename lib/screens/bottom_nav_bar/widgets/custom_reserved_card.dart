import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomReservedCard extends StatelessWidget {
  final dynamic data;
  const CustomReservedCard({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: ListTile(
                leading: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                    image: DecorationImage(
                      image: NetworkImage(data['bookImage']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  "Book Name: ${data['bookName']}",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Author Name: ${data['authorName']}",
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
                trailing: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return CupertinoAlertDialog(
                            title: const Text("Wait!"),
                            content: const Text("Do You want to Clear This Book From Reserved List?"),
                            actions: [
                              CupertinoActionSheetAction(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(FirebaseAuth.instance.currentUser!.uid)
                                        .update({
                                      "reservedBooks": FieldValue.arrayRemove([data['bookId']]),
                                    });
                                  },
                                  child: const Text("Yes")),
                              CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No")),
                            ],
                          );
                        });
                  },
                  child: Icon(
                    Icons.delete,
                    size: 20,
                    color: Colors.red[900],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
