import 'package:flutter/material.dart';
import 'package:notes_app_php/constant/links.dart';
import 'package:notes_app_php/main.dart';
import 'package:notes_app_php/utils/auth/username_validator.dart';
import 'package:notes_app_php/widgets/data/crud.dart';

class AddNotesScreen extends StatefulWidget {
  AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  Crud _crud = Crud();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController addtNoteTitle = TextEditingController();
  TextEditingController addtNoteContent = TextEditingController();
  bool isLoading = false;
  addNotes() async {
    isLoading = true;
    setState(() {});
    var response = await _crud.postRequest(linkNotesAdd, {
      "title": addtNoteTitle.text,
      "content": addtNoteContent.text,
      "id": sharedPreferences!.getString("id"),
    });
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

              ElevatedButton.icon(
                onPressed: () {
                  if (formstate.currentState!.validate()) {
                    addNotes();
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
