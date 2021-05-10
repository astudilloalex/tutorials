import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorials/common/constants.dart';
import 'package:tutorials/notes/models/note.dart';
import 'package:tutorials/notes/providers/note_provider.dart';

class EditNotePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<EditNotePage> {
  Note _note = Note(
    title: '',
    content: '',
  );
  late _NoteForm _noteForm;

  @override
  Widget build(BuildContext context) {
    _note = ModalRoute.of(context)!.settings.arguments != null
        ? ModalRoute.of(context)!.settings.arguments as Note
        : _note;
    _noteForm = _NoteForm(_note);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: _noteForm,
      bottomNavigationBar: _BottomNavBar(
        id: _note.id,
      ),
    );
  }
}

class _NoteForm extends StatefulWidget {
  final Note note;

  _NoteForm(this.note);

  @override
  _StateNoteForm createState() => _StateNoteForm();
}

class _StateNoteForm extends State<_NoteForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  late NoteProvider _noteProvider;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.title!;
    _contentController.text = widget.note.content!;
    _noteProvider = Provider.of<NoteProvider>(context, listen: false);
  }

  @override
  Future<void> dispose() async {
    final String title = _titleController.text.trim();
    final String content = _contentController.text.trim();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
    await _save(title, content);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                minLines: 1,
                maxLength: null,
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                minLines: 15,
                maxLines: null,
                controller: _contentController,
                decoration:
                    InputDecoration(hintText: 'Note', border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save(String title, String content) async {
    if (title.isNotEmpty || content.isNotEmpty) {
      if (widget.note.id == null) {
        await _noteProvider.addOrUpdate(title, content, EditMode.ADD);
      } else if (title != widget.note.title || content != widget.note.content) {
        await _noteProvider.addOrUpdate(
            title, content, EditMode.UPDATE, widget.note.id);
      }
    }
  }
}

class _BottomNavBar extends StatelessWidget {
  final int? id;

  _BottomNavBar({this.id});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text('Delete'),
                      onTap: () async {
                        if (id == null) {
                          Navigator.popUntil(context, (route) => route.settings.name==Routes.notesHome);
                        } else {
                          await Provider.of<NoteProvider>(context,
                                  listen: false)
                              .deleteNote(id!);
                          Navigator.popUntil(context, (route) => route.settings.name==Routes.notesHome);
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
