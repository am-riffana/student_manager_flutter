import 'dart:io';
import 'package:flutter/material.dart';

import '../models/student_model.dart';
import 'add_edit.dart';

class StudentDetail extends StatelessWidget {
  final Student student;
  const StudentDetail({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Student Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditStudent(student: student),
                ),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  student.imagePath.isNotEmpty ? FileImage(File(student.imagePath)) : null,
            ),
             SizedBox(height: 20),
            Text('Name: ${student.name}', style:  TextStyle(fontSize: 18)),
            Text('Age: ${student.age}'),
            Text('Class: ${student.studentClass}'),
            Text('Address: ${student.address}'),
          ],
        ),
      ),
    );
  }
}
