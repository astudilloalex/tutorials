import 'package:flutter/material.dart';

/// Shown if the requested page doesn't exist.
class NotFoundPage extends StatelessWidget {
  /// Define a [NotFoundPage] class.
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: Text('Page not found'))),
    );
  }
}
