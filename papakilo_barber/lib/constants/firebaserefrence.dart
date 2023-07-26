import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

DatabaseReference firebaseDatabaseRefrence = FirebaseDatabase.instance.ref();

ganerataUUId() {
  String key = const Uuid().v4().toString();
  return key;
}
