class Student {
  String id;
  String name;
  String age;
  String studentClass;
  String address;
  String imagePath;

  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.studentClass,
    required this.address,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'studentClass': studentClass,
      'address': address,
      'imagePath': imagePath,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      studentClass: json['studentClass'],
      address: json['address'],
      imagePath: json['imagePath'],
    );
  }
}
