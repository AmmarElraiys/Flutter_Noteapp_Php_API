import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  final notes;

  const NotesScreen({super.key, this.notes});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  bool isLoading = false;
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final TextEditingController NoteTitle = TextEditingController();
  final TextEditingController NoteContent = TextEditingController();
  final ScrollController _contentScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    NoteTitle.text = widget.notes['notes_title'] ?? '';
    NoteContent.text = widget.notes['notes_content'] ?? '';
  }

  @override
  void dispose() {
    NoteTitle.dispose();
    NoteContent.dispose();
    _contentScrollController.dispose();
    super.dispose();
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
                          style: const TextStyle(
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
                        Container(
                          height:
                              300, // İçeriği kaydırmak için bir sabit yükseklik veriyoruz
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Scrollbar(
                            thumbVisibility: true,
                            controller: _contentScrollController,
                            child: SingleChildScrollView(
                              controller: _contentScrollController,
                              child: TextFormField(
                                controller: NoteContent,
                                enabled: false,
                                maxLines:
                                    null, // Satır sayısını sınırsız yapıyoruz
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isCollapsed: true, // İç boşlukları azaltır
                                ),
                              ),
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
