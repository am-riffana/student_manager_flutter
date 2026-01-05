import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/student_model.dart';


class StudentStorage {
  static const _key = 'students';

  static Future<List<Student>> getStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);

    if (data == null) return [];

    final List decoded = jsonDecode(data);
    return decoded.map((e) => Student.fromJson(e)).toList();
  }

  static Future<void> saveStudents(List<Student> students) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, jsonEncode(students.map((e) => e.toJson()).toList()));
  }
}
