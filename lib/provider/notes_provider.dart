import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../modals/note.dart';
import '../services/api_service.dart';

class noteProvider with ChangeNotifier {
  List<Note> notes = [];
  bool isloading = true;
  void fetchnote() async {
    notes = await Api.fetchNote("dharmendrabaghel2900@gmail.com");
    isloading = false;
    notifyListeners();
  }

  void sortNotes() {
    notes.sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
  }

  noteProvider() {
    fetchnote();
  }
  void addNotes(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    Api.addNote(note);
  }

  void deleteNotes(Note note) {
    int indexofnote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));

    notes.removeAt(indexofnote);
    sortNotes();
    notifyListeners();

    Api.deleteNote(note);
  }

  void updateNotes(Note note) {
    int indexofnote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));

    notes[indexofnote] = note;
    sortNotes();
    notifyListeners();
    Api.addNote(note);
  }
}
