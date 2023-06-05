import 'dart:convert';
import 'dart:developer';

import '../modals/note.dart';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = "http://192.168.116.173:5000";
  static Future<void> addNote(Note note) async {
    try {
      Uri requestUri = Uri.parse("$baseUrl/add");
      var response = await http.post(requestUri, body: note.toMap());
      var decode = jsonDecode(response.body);

      //  log(decode.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse("$baseUrl/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decode = jsonDecode(response.body);
    log(decode.toString());
  }

  static Future<List<Note>> fetchNote(String userid) async {
    Uri requestUri = Uri.parse("$baseUrl/notes/list");
    var response = await http.post(requestUri, body: {"userid": userid});
    var decode = jsonDecode(response.body);
    if (response.body != null) {
      log(decode.toString());
    } else {
      log('data doesnot detch');
    }

    List<Note> notes = [];
    for (var x in decode) {
      Note newNote = Note.fromMap(x);
      notes.add(newNote);
    }
    return notes;
  }
}
