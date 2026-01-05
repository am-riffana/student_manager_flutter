import 'dart:io';
import 'package:flutter/material.dart';
import '../models/student_model.dart';

class StudentTile extends StatelessWidget {
  final Student student;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const StudentTile({
    super.key,
    required this.student,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundImage: student.imagePath.isNotEmpty
              ? FileImage(File(student.imagePath))
              : null,
          child: student.imagePath.isEmpty
              ? const Icon(Icons.person)
              : null,
        ),
        title: Text(
          student.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}
