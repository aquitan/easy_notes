import 'package:easy_notes/repository/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // INITIALIZE - DB
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteModelSchema],
      directory: dir.path,
      inspector: true,
    );
  }

  // list if notes
  final List<NoteModel> notes = [];
  NoteModel? noteById;

  // CREATE NOTE
  Future<void> createNote(NoteModel note) async {
    // final newNote = NoteModel() = note;
    await isar.writeTxn(() => isar.noteModels.put(note));

    // re-read from db
    fetchNotes();
  }

  // READ NOTE
  Future<void> fetchNotes() async {
    List<NoteModel> fetchedNotes = await isar.noteModels.where().findAll();
    notes.clear();
    notes.addAll(fetchedNotes);
    notifyListeners();
  }

  // UPDATE NOTE
  Future<void> updateNote(int id, NoteModel note) async {
    NoteModel? foundNote = await isar.noteModels.get(id);

    if (foundNote != null) {
      foundNote.title = note.title;
      foundNote.text = note.text;
      foundNote.category = note.category;
      await isar.writeTxn(() => isar.noteModels.put(foundNote));
      await fetchNotes();
    }

  }

  // GET NOTE BY ID
  Future<void> getNoteById(int id) async {
    NoteModel? note = await isar.noteModels.get(id);
    noteById = note;
    notifyListeners();
  }


  // DELETE NOTE
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.noteModels.delete(id));
    await fetchNotes();
  }

  // Clear datababase
  Future<void> clearDatabase() async {
    await isar.writeTxn(() => isar.noteModels.clear());
    await fetchNotes();
  }
}