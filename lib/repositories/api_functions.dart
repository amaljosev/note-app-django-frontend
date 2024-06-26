import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tododjango/models/models.dart';
import 'package:tododjango/repositories/url.dart';

class Api extends GetxController {
  Future<List<Note>> getNotes() async {
    final response = await http.get(Uri.parse("${Env.urlPrefix}/todo/getpost/"));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Note> employees = items.map<Note>((json) {
      return Note.fromJson(json);
    }).toList();

    return employees; 
  }

  Future<void> createNote(Note note) async {
    final url = Uri.parse("${Env.urlPrefix}/todo/getpost/");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(note.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        isSuccess();
      } else {
        print("Failed to create note. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> isSuccess() async {
    await getNotes();
    Get.back();
  }

  Future<void> updateNote(Note note,String id) async {
    final url = Uri.parse("${Env.urlPrefix}/todo/byid/$id/");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(note.toJson());

    try {
      final response = await http.patch(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print("Note updated successfully");
      } else {
        print("Failed to update note. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
    getNotes();
    Get.back();
  }

  Future<void> deleteNote(String noteId) async {
    final url = Uri.parse("${Env.urlPrefix}/todo/byid/$noteId/"); 

    try {
      final response = await http.delete(url);

      if (response.statusCode == 204) {

        print("Note deleted successfully");
      } else {
        print("Failed to delete note. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  
}
