import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/student_model.dart';
import '../services/student_storage.dart';

class AddEditStudent extends StatefulWidget {
  final Student? student;
  const AddEditStudent({super.key, this.student});

  @override
  State<AddEditStudent> createState() => _AddEditStudentState();
}

class _AddEditStudentState extends State<AddEditStudent> {
  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final classCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  String imagePath = '';

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      nameCtrl.text = widget.student!.name;
      ageCtrl.text = widget.student!.age;
      classCtrl.text = widget.student!.studentClass;
      addressCtrl.text = widget.student!.address;
      imagePath = widget.student!.imagePath;
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => imagePath = image.path);
    }
  }

  void saveStudent() async {
    if (nameCtrl.text.isEmpty || ageCtrl.text.isEmpty) return;

    final students = await StudentStorage.getStudents();

    if (widget.student == null) {
      students.add(
        Student(
          id: DateTime.now().toString(),
          name: nameCtrl.text,
          age: ageCtrl.text,
          studentClass: classCtrl.text,
          address: addressCtrl.text,
          imagePath: imagePath,
        ),
      );
    } else {
      final index = students.indexWhere((e) => e.id == widget.student!.id);
      students[index] = Student(
        id: widget.student!.id,
        name: nameCtrl.text,
        age: ageCtrl.text,
        studentClass: classCtrl.text,
        address: addressCtrl.text,
        imagePath: imagePath,
      );
    }

    await StudentStorage.saveStudents(students);
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 202, 171),
      appBar: AppBar(
        title: Text(widget.student == null ? 'Add Student' : 'Edit Student'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    imagePath.isNotEmpty ? FileImage(File(imagePath)) : null,
                child: imagePath.isEmpty
                    ?  Icon(Icons.camera_alt, size: 40)
                    : null,
              ),
            ),
            TextField(
              controller: nameCtrl, 
              decoration:  InputDecoration(
                labelText: 'Name')),
            TextField(
              controller: ageCtrl, 
              decoration:  InputDecoration(
                labelText: 'Age')),
            TextField(
              controller: classCtrl, 
              decoration:  InputDecoration(
                labelText: 'Class')),
            TextField(
              controller: addressCtrl, 
              decoration:  InputDecoration(
                labelText: 'Address')),
             SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveStudent, 
              child:  Text('Save')),
          ],
        ),
      ),
    );
  }
}
