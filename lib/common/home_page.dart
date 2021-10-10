import 'package:flutter/material.dart';
import 'package:tutorials/common/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Widget List with all _RouteLisTile.
    const List<Widget> routes = [
      _RouteListTile('Google Sign In', Routes.googleSignInExample),
      _RouteListTile('Notes App', Routes.notesHome),
      _RouteListTile('Search delegate example', Routes.searchDelegateExample),
      _RouteListTile('Google Maps Example', Routes.googleMapsExample),
    ];
    // Scaffold contain the ListView with routes.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorials'),
      ),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (_, index) => routes[index],
      ),
    );
  }
}

class _RouteListTile extends StatelessWidget {
  final String title;
  final String namedRoute;

  const _RouteListTile(
    this.title,
    this.namedRoute, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).pushNamed(namedRoute);
      },
    );
  }
}
