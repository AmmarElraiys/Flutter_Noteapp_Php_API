import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app_php/constant/links.dart';
import 'package:notes_app_php/customs/home/showimage_widget.dart';
import 'package:notes_app_php/utils/auth/username_validator.dart';
import 'package:notes_app_php/widgets/data/crud.dart';

class EditNotesScreen extends StatefulWidget {
  final notes;
  EditNotesScreen({super.key, this.notes});

  @override
  State<EditNotesScreen> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNotesScreen> {
  File? myfile;

  Crud _crud = Crud();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController edittNoteTitle = TextEditingController();
  TextEditingController editNoteContent = TextEditingController();
  bool isLoading = false;
  editNotes() async {
    isLoading = true;
    setState(() {});
    var response;
    if (myfile == null) {
      response = await _crud.postRequest(linkNotesEdit, {
        "title": edittNoteTitle.text,
        "content": editNoteContent.text,
        "id": widget.notes['notes_id'].toString(),
        "imagename": widget.notes['notes_image'].toString(),
      });
    } else {
      response = await _crud.postRequestWithFile(linkNotesEdit, {
        "title": edittNoteTitle.text,
        "content": editNoteContent.text,
        "id": widget.notes['notes_id'].toString(),
        "imagename": widget.notes['notes_image'].toString(),
      }, myfile!);
    }
    isLoading = false;
    setState(() {});
    if (response["status"] == "success") {
      Navigator.of(context).pushReplacementNamed("/home");
    } else {}
  }

  @override
  void initState() {
    edittNoteTitle.text = widget.notes['notes_title'];
    editNoteContent.text = widget.notes['notes_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Note")),
      body: Form(
        key: formstate,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: edittNoteTitle,
                validator: (value) => UsernameValidator.validate(value),
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: editNoteContent,
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
              ElevatedButton.icon(
                onPressed: () {
                  if (formstate.currentState!.validate()) {
                    editNotes();
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
