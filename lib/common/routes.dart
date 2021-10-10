import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_example/google_maps_example.dart';
import 'package:search_delegate_example/search_delegate_example.dart';
import 'package:tutorials/google_sign_in_firebase/home_google_sign_in.dart';
import 'package:tutorials/notes/routes/edit_note/edit_note_page.dart';
import 'package:tutorials/notes/routes/home/home_page.dart';
import 'package:tutorials/common/home_page.dart';
import 'package:tutorials/common/not_found_page.dart';
import 'package:tutorials/notes/routes/search_note/search_note.dart';

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
  static const String googleMapsExample = '/google-maps-example';
  static const String googleSignInExample = '/google-sign-in-example';

  /// Returns a route by [settings] name if exist otherwise return a [NotFoundPage].
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case editNote:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const EditNotePage(),
        );
      case googleMapsExample:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const GoogleMapsExample(),
        );
      case googleSignInExample:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomeGoogleSignIn(),
        );
      case home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomePage(),
        );
      case notesHome:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const NotesHomePage(),
        );
      case searchDelegateExample:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SearchDelegateExample(),
        );
      case searchNote:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SearchNotePage(),
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
