import 'package:flutter/material.dart';
import 'package:notes_app_php/constant/links.dart';
import 'package:notes_app_php/utils/auth/username_validator.dart';
import 'package:notes_app_php/widgets/data/crud.dart';

class NotesScreen extends StatefulWidget {
  final notes;

  const NotesScreen({super.key, this.notes});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  Crud _crud = Crud();
  bool isLoading = false;
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final TextEditingController NoteTitle = TextEditingController();
  final TextEditingController NoteContent = TextEditingController();

  @override
  void initState() {
    super.initState();
    NoteTitle.text = widget.notes['notes_title'] ?? '';
    NoteContent.text = widget.notes['notes_content'] ?? '';
  }

  getNotes() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});

      var response = await _crud.postRequest(linkNotesView, {
        "title": NoteTitle.text,
        "content": NoteContent.text,
        "id": widget.notes['notes_id'].toString(),
      });

      isLoading = false;
      setState(() {});

      if (response['status'] == "success") {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Note Screen",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formstate,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Title",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: NoteTitle,
                          enabled: false,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Contents",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: NoteContent,
                          maxLines: 20,
                          enabled: false,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}
