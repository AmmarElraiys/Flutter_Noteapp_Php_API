import 'package:flutter/material.dart';
import 'package:notes_app_php/constant/links.dart';
import 'package:notes_app_php/model/notemodel.dart';

class CardCustom extends StatelessWidget {
  final NoteModel noteModel;

  final void Function()? onTap;
  final void Function()? onPressedDelete;
  final void Function()? onPressedEdit;

  const CardCustom({
    Key? key,
    required this.noteModel,

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
            Image.network(
              "$linkServerNameImage/${noteModel.notesImage ?? ''}",
              width: 100,
              height: 100,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Colors.grey,
                );
              },
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
