import 'package:flutter/material.dart';
import 'package:tutorials/common/constants.dart';
import 'package:tutorials/notes/models/note.dart';
import 'package:tutorials/notes/services/sqlite.dart';

class NoteProvider with ChangeNotifier {
  final SQLiteHelper _db = SQLiteHelper();

  List<Note> _items = [];

  Future<void> loadNotes() async {
    List<Map<String, dynamic>> data = await _db.notes;
    _items = data.map((note) {
      return Note(
        id: note['id'],
        title: note['title'],
        content: note['content'],
      );
    }).toList();
    notifyListeners();
  }

  Future<void> addOrUpdate(String title, String? content, EditMode? editMode,
      [int? id]) async {
    id = await _db.insertNote(
      Note(
        id: id,
        title: title,
        content: content,
      ).toMap(),
    );

    final Note note = Note(
      id: id,
      title: title,
      content: content,
    );
    if (id != 0) {
      if (editMode == EditMode.ADD)
        _items.insert(0, note);
      else if (editMode == EditMode.UPDATE)
        _items[_items.indexWhere((element) => element.id == note.id)] = note;
      notifyListeners();
    }
  }

  Future<void> deleteNote(int id) async {
    _items.removeWhere((element) => element.id == id);
    await _db.deleteNote(id);
    notifyListeners();
  }

  List<Note> get items => [..._items];
}