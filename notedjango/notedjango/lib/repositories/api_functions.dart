import 'dart:convert';
import 'dart:developer';
import 'package:notedjango/models/note_model.dart';
import 'package:http/http.dart' as http;
import 'package:notedjango/repositories/url.dart';

class Api {
  Future<List<Note>> getNotes() async {
    try {
      final response = await http.get(Uri.parse("${Env.urlPrefix}/todos"));

      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Note> notes = items.map<Note>((json) {
          return Note.fromJson(json);
        }).toList();

        return notes;
      } else {
        log("Failed to fetch notes. Status code: ${response.statusCode}");
        log("Response body: ${response.body}");
        return [];
      }
    } catch (e) {
      log("Error: $e");
      return [];
    }
  }

  Future<bool> addNote(Note note) async {
    final url = Uri.parse('${Env.urlPrefix}/todos');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(note.toJson());
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        log('success note created');
        return true;
      } else {
        log("Failed to create note. Status code: ${response.statusCode}");
        log("Response body: ${response.body}");
        return false;
      }
    } catch (e) {
      log('error :$e');
      return false; 
    }
  }

  Future<bool> updateNote(Note note, String id) async {
    final url = Uri.parse("${Env.urlPrefix}/todos/$id");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(note.toJson());

    try {
      final response = await http.patch(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        log("Note updated successfully");
        return true;
      } else {
        log("Failed to update note. Status code: ${response.statusCode}");
        log("Response body: ${response.body}");
         return false;
      }
    } catch (e) {
      log("Error: $e");
       return false;
    }
  }

  Future<bool> deleteNote(String noteId) async {
    final url = Uri.parse("${Env.urlPrefix}/todos/$noteId");

    try {
      final response = await http.delete(url);

      if (response.statusCode == 204) {
        log("Note deleted successfully");
        return true;
      } else {
        log("Failed to delete note. Status code: ${response.statusCode}");
        log("Response body: ${response.body}");
         return false; 
      }
    } catch (e) {
      log("Error: $e");
      return false; 
    }
  }
}
