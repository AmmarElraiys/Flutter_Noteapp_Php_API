import 'package:flutter/material.dart';
import 'package:notes_app_php/model/notemodel.dart';

class CardCustom extends StatelessWidget {
  final NoteModel noteModel;
  final String image;
  final void Function()? onTap;
  final void Function()? onPressedDelete;
  final void Function()? onPressedEdit;

  const CardCustom({
    Key? key,
    required this.noteModel,
    required this.image,
    this.onTap,
    this.onPressedDelete,
    this.onPressedEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                image,
                width: 30,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: ListTile(
                title: Text(
                  "${noteModel.notesTitle}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1, // en fazla 2 satır
                  overflow: TextOverflow.ellipsis, // taşarsa ... koy
                ),
                subtitle: Text(
                  "${noteModel.notesContent}",
                  maxLines: 1, // en fazla 2 satır
                  overflow: TextOverflow.ellipsis, // taşarsa ... koy
                ),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min, // ICONLAR DARALSIN
                  children: [
                    IconButton(
                      onPressed: onPressedEdit,
                      icon: const Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(
                      onPressed: onPressedDelete,
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
