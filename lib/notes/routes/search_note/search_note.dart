import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorials/notes/models/note.dart';
import 'package:tutorials/notes/providers/note_provider.dart';
import 'package:tutorials/notes/widgets/list_tiles.dart';

class SearchNotePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SearchNotePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_search);
    _notes = Provider.of<NoteProvider>(context, listen: false).items;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: TextField(
              autofocus: true,
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return NoteTile(_filteredNotes[index]);
              },
              childCount: _filteredNotes.length,
            ),
          ),
        ],
      ),
    );
  }

  void _search() {
    setState(() {
      _filteredNotes = _notes.where((note) {
        final find = '${note.title} ${note.content}'.trim().toLowerCase();
        return find.contains((_searchController.text.trim().toLowerCase()));
      }).toList();
    });
  }
}
