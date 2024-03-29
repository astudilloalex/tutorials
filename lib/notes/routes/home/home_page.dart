import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorials/common/routes.dart';
import 'package:tutorials/notes/providers/note_provider.dart';
import 'package:tutorials/notes/widgets/list_tiles.dart';

class NotesHomePage extends StatelessWidget {
  const NotesHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<NoteProvider>(context, listen: false).loadNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _Scaffold();
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class _Scaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Body(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, Routes.editNote);
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                _AppBar(),
                _NoteList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverAppBar(
        automaticallyImplyLeading: false,
        floating: true,
        forceElevated: true,
        titleSpacing: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text('Search'),
          onTap: () {
            Navigator.pushNamed(context, Routes.searchNote);
          },
        ),
      ),
    );
  }
}

class _NoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      child: const Center(
        child: Text('Empty'),
      ),
      builder: (context, provider, child) {
        if (provider.items.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: child,
            ),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return NoteTile(provider.items[index]);
            },
            childCount: provider.items.length,
          ),
        );
      },
    );
  }
}
