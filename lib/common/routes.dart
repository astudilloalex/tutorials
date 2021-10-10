import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorials/notes/routes/home_page.dart';
import 'package:tutorials/notes/routes/not_found_page.dart';

/// Manage all named routes used in the app.
class Routes {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  const Routes._();

  /// Named route to navigate home page.
  static const String home = '/';
  static const String notesHome = '/notes';
  static const String editNote = '/edit-note';
  static const String searchNote = '/search-note';
  static const String searchDelegateExample = '/search-delegate-example';
  static const String googleSignInExample = '/google-sign-in-example';

  /// Returns a route by [settings] name if exist otherwise return a [NotFoundPage].
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomePage(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const NotFoundPage(),
        );
    }
  }

  /// Returns a initial routes based in your [initialRoute] name.
  static List<Route<dynamic>> generateInitialRoutes(String initialRoute) {
    return [
      generateRoute(const RouteSettings(name: home)),
    ];
  }
}
