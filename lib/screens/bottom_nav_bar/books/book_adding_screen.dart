import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_management_system/services/database_services.dart';
import 'package:library_management_system/widgets/buttons.dart';
import 'package:library_management_system/widgets/text_input.dart';

class BookAddingScreen extends StatefulWidget {
  const BookAddingScreen({Key? key}) : super(key: key);

  @override
  State<BookAddingScreen> createState() => _BookAddingScreenState();
}

class _BookAddingScreenState extends State<BookAddingScreen> {
  TextEditingController bookNameController = TextEditingController();
  TextEditingController authorNameController = TextEditingController();

  File? _selectedImage;
  getImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      _selectedImage = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text("Book Adding"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _selectedImage == null
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.deepPurple),
                      ),
                      child: Center(
                        child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) {
                                    return SizedBox(
                                      height: 200,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              Navigator.pop(context);
                                              getImage(ImageSource.camera);
                                            },
                                            leading: const Icon(Icons.camera_alt),
                                            title: const Text('From Camera'),
                                          ),
                                          const Divider(thickness: 1, height: 1),
                                          ListTile(
                                            onTap: () {
                                              Navigator.pop(context);
                                              getImage(ImageSource.gallery);
                                            },
                                            leading: const Icon(Icons.photo),
                                            title: const Text('From Gallery'),
                                          ),
                                          const Divider(thickness: 1, height: 1),
                                          ListTile(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            leading: const Icon(Icons.close),
                                            title: const Text('Cancel'),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: const Icon(Icons.camera_alt, size: 35)),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(
                            File(_selectedImage!.path),
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.deepPurple),
                      ),
                    ),
              const SizedBox(height: 30),
              CustomTextInput(
                controller: bookNameController,
                title: "Add Book Name",
                icon: Icons.book,
              ),
              const SizedBox(height: 20),
              CustomTextInput(
                controller: authorNameController,
                title: "Add Author Name",
                icon: Icons.drive_file_rename_outline,
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                onPressed: () async {
                  await DataBaseServices.addBookInformation(
                    context: context,
                    authorName: authorNameController.text,
                    bookName: bookNameController.text,
                    bookImage: _selectedImage,
                  );
                },
                title: "Submit",
              )
            ],
          ),
        ),
      ),
    );
  }
}
