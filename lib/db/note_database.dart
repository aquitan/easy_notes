import 'package:easy_notes/repository/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // INITIALIZE - DB
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.openAsync(
      schemas: [NoteModelSchema],
      directory: dir.path,
    );
  }

  // list if notes
  final List<NoteModel> notes = [];

  // CREATE NOTE
  Future<void> createNote(NoteModel note) async {
    final newNote = NoteModel() = note;
    isar.write((note){
      isar.noteModels.put(newNote);
    });

    // re-read from db
    fetchNotes();
  }

  // READ NOTE
  Future<void> fetchNotes() async {
    List<NoteModel> fetchedNotes = isar.noteModels.where().findAll();
    notes.clear();
    notes.addAll(fetchedNotes);
    notifyListeners();
  }

  // UPDATE NOTE
  Future<void> updateNote(int id, NoteModel note) async {
    final updatedNote = NoteModel() = note;
    final foundNote = await isar.noteModels.getAsync(id);

    if (foundNote != null) {
      await isar.writeAsync((note){
        isar.noteModels.put(updatedNote);
      });
      await fetchNotes();
    }

  }

  // DELETE NOTE
  Future<void> deleteNote(int id) async {
    await isar.writeAsync((isar) {
      isar.noteModels.delete(id);
    });
    await fetchNotes();
  }

  // Clear datababase
  Future<void> clearDatabase() async {
    await isar.writeAsync((isar) {
      isar.noteModels.clear();
    });
    await fetchNotes();
  }
}