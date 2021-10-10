import 'package:flutter/material.dart';
import 'package:tutorials/common/routes.dart';
import 'package:tutorials/notes/models/note.dart';

class NoteTile extends StatelessWidget {
  final Note note;

  const NoteTile(this.note, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Text(
            note.title!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Text(
            note.content!.replaceAll('\n', ' '),
            maxLines: 6,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        onTap: () {
          if (ModalRoute.of(context)!.settings.name == Routes.searchNote) {
            Navigator.popAndPushNamed(
              context,
              Routes.editNote,
              arguments: note,
            );
          } else {
            Navigator.pushNamed(
              context,
              Routes.editNote,
              arguments: note,
            );
          }
        },
      ),
    );
  }
}
