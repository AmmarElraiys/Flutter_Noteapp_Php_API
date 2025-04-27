import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app_php/constant/links.dart';
import 'package:notes_app_php/customs/home/showimage_widget.dart';
import 'package:notes_app_php/main.dart';
import 'package:notes_app_php/utils/auth/username_validator.dart';
import 'package:notes_app_php/widgets/data/crud.dart';

class AddNotesScreen extends StatefulWidget {
  AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  File? myfile;
  Crud _crud = Crud();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController addtNoteTitle = TextEditingController();
  TextEditingController addtNoteContent = TextEditingController();
  bool isLoading = false;
  addNotes() async {
    isLoading = true;
    setState(() {});
    var response = await _crud.postRequestWithFile(linkNotesAdd, {
      "title": addtNoteTitle.text,
      "content": addtNoteContent.text,
      "id": sharedPreferences!.getString("id"),
    }, myfile!);
    isLoading = false;
    setState(() {});
    if (response["status"] == "success") {
      Navigator.of(context).pushReplacementNamed("/home");
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Note")),
      body: Form(
        key: formstate,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: addtNoteTitle,
                validator: (value) => UsernameValidator.validate(value),
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addtNoteContent,
                maxLines: 5,
                validator: (value) => UsernameValidator.validate(value),
                decoration: const InputDecoration(
                  labelText: "Contents",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              ShowImageWidget(
                onCameraPressed: () async {
                  XFile? xfile = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                  );
                  myfile = File(xfile!.path);
                },
                onGalleryPressed: () async {
                  XFile? xfile = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  myfile = File(xfile!.path);
                },
                cameraIcon: const Icon(Icons.camera_alt),
                galleryIcon: const Icon(Icons.photo_library),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  if (myfile == null) {
                    // Eğer myfile null ise, bir Dialog gösterelim
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text("Where is the Image?"),
                            content: const Text(
                              "Please select an image before saving.",
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Dialog'ı kapat
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                    );
                    return; // Buradan sonra işlem yapma
                  }

                  if (formstate.currentState!.validate()) {
                    await addNotes();
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
