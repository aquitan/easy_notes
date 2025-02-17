import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'note_model.g.dart';

@collection
class NoteModel {
  NoteModel({required this.title, required this.text});

  late int id = Uuid().v4().replaceAll("-", "").hashCode;
  late String text;
  late String title;

  DateTime creationDate = DateTime.now();
}