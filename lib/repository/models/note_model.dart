import 'package:isar/isar.dart';

part 'note_model.g.dart';

@Collection()
class NoteModel {
  NoteModel(
      {required this.checked,
      required this.category,
      required this.title,
      required this.text});

  Id id = Isar.autoIncrement;
  late String text;
  late String title;
  final bool checked;
  late String category;
  DateTime? updateDate;

  DateTime creationDate = DateTime.now();
}