import 'package:flutter/material.dart';
import 'package:tutorials/common/constants.dart';
import 'package:tutorials/notes/models/note.dart';
import 'package:tutorials/notes/services/sqlite.dart';

class NoteProvider with ChangeNotifier {
  final SQLiteHelper _db = SQLiteHelper();

  List<Note> _items = [];

  Future<void> loadNotes() async {
    final List<Map<String, dynamic>> data = await _db.notes;
    _items = data.map((note) {
      return Note(
        id: note['id'] as int?,
        title: note['title'] as String?,
        content: note['content'] as String?,
      );
    }).toList();
    notifyListeners();
  }

  Future<void> addOrUpdate(
    String title,
    String? content,
    EditMode? editMode, [
    int? id,
  ]) async {
    final int idSaved = await _db.insertNote(
      Note(
        id: id,
        title: title,
        content: content,
      ).toMap(),
    );

    final Note note = Note(
      id: idSaved,
      title: title,
      content: content,
    );
    if (idSaved != 0) {
      if (editMode == EditMode.add) {
        _items.insert(0, note);
      } else if (editMode == EditMode.update) {
        _items[_items.indexWhere((element) => element.id == note.id)] = note;
      }
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
