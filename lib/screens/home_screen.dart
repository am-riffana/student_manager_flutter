import 'package:flutter/material.dart';

import '../models/student_model.dart';
import '../services/student_storage.dart';
import '../services/auth_services.dart';
import '../widgets/student_tile.dart';
import 'add_edit.dart';
import 'student_detail.dart';
import 'login_screen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Student> students = [];
  List<Student> filtered = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    students = await StudentStorage.getStudents();
    filtered = List.from(students);
    setState(() {});
  }

  void search(String value) {
    filtered = students.where((e) => e.name.toLowerCase().contains(value.toLowerCase())).toList();
    setState(() {});
  }

  void delete(String id) async {
    students.removeWhere((e) => e.id == id);
    await StudentStorage.saveStudents(students);
    load();
  }

  void logout() async {
    await AuthService.logout();
    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 207, 248, 248),
      appBar: AppBar(
        title:  Text('Students'),
        actions: [
          IconButton(
            onPressed: logout,
             icon:  Icon(Icons.logout))],
              ),
      floatingActionButton: FloatingActionButton(
        child:  Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
             MaterialPageRoute(builder: (_) =>  AddEditStudent()));
          load();
        },
      ),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.all(8),
            child: TextField(
              onChanged: search, 
              decoration:  InputDecoration
              (prefixIcon: Icon(Icons.search),
               hintText: 'Search')),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final s = filtered[i];
               return StudentTile(
                  student: s,
                 onDelete: () => delete(s.id),
                   onTap: () {
                     Navigator.push(
                      context,
                     MaterialPageRoute(
                        builder: (_) => StudentDetail(student: s),
                     ),
               );
               },
               );

              },
            ),
          ),
        ],
      ),
    );
  }
}
