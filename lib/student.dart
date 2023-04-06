import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Student extends StateNotifier {
  String _name;
  int _age;
  double _height;
  String _studentClass;

  String get name => _name;
  int get age => _age;
  double get height => _height;
  String get studentClass => _studentClass;

  set name(String value) => _name = value;
  set age(int value) => _age = value;
  set height(double value) => _height = value;
  set studentClass(String value) => _studentClass = value;

  Student(
      {required String name,
      required int age,
      required double height,
      required String studentClass})
      : _name = name,
        _age = age,
        _height = height,
        _studentClass = studentClass,
        super(null);
}

final studentProvider = StateNotifierProvider(
    (ref) => Student(age: 0, height: 0, name: '', studentClass: ''));

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listen to Student Changes"),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final student = watch.watch(studentProvider.notifier);
          return Column(
            children: <Widget>[
              Text("Name: ${student.name}"),
              Text("Age: ${student.age}"),
              Text("Height: ${student.height}"),
              Text("Class: ${student.studentClass}"),
            ],
          );
        },
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          final student = ref.read(studentProvider.notifier);
          return FloatingActionButton(
            onPressed: () {
              student.state = Student(
                name: "Jane Doe",
                age: 22,
                height: 168.0,
                studentClass: "Class B",
              );
            },
            child: const Icon(Icons.edit),
          );
        },
      ),
    );
  }
}
