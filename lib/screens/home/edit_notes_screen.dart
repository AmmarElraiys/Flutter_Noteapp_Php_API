import 'package:flutter/material.dart';
import 'package:notes_app_php/constant/links.dart';
import 'package:notes_app_php/utils/auth/username_validator.dart';
import 'package:notes_app_php/widgets/data/crud.dart';

class EditNotesScreen extends StatefulWidget {
  final notes;
  EditNotesScreen({super.key, this.notes});

  @override
  State<EditNotesScreen> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNotesScreen> {
  Crud _crud = Crud();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController edittNoteTitle = TextEditingController();
  TextEditingController editNoteContent = TextEditingController();
  bool isLoading = false;
  editNotes() async {
    isLoading = true;
    setState(() {});
    var response = await _crud.postRequest(linkNotesEdit, {
      "title": edittNoteTitle.text,
      "content": editNoteContent.text,
      "id": widget.notes['notes_id'].toString(),
    });
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
      appBar: AppBar(title: const Text("Add New Note")),
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
