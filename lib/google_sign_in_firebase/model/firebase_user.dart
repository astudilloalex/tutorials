import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUser {
  String? _uid;
  String? _name;
  String? _email;
  String? _imageUrl;

  void user(User? user) {
    _uid = user?.uid;
    _name = user?.displayName;
    _email = user?.email;
    _imageUrl = user?.photoURL;
  }

  String? get uid => _uid;

  String? get name => _name;

  String? get email => _email;

  String? get imageUrl => _imageUrl;
}
