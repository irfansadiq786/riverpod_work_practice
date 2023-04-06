// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}


final counterProvider = StateNotifierProvider<Counter, Student>((ref) {
  return Counter();
});

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    log('message');
    return Scaffold(
      body: Center(
        child: Consumer(builder: (context, ref, child) {
          final counter = ref.watch(counterProvider);
          return Wrap(
            children: [
              Text(counter.age.toString()),
              Text(counter.height.toString()),
              Text(counter.rollNumber.toString()),
            ],
          );
        }),
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) => FloatingActionButton(
          onPressed: () {
            ref.read(counterProvider.notifier).setAge(22);
          },
          child: const Text('+'),
        ),
      ),
    );
  }
}

class Counter extends StateNotifier<Student> {
  Counter() : super(Student());

  void setStateMethod(Student value) {
    if (value.age != state.age) {
      state = value;
    }
  }

  void setAge(int age) {
    state = state.copyWith(age: age);
  }
}

class Student {
  int? rollNumber;
  int? age;
  double? height;
  Student({this.rollNumber, this.age, this.height});

  Student copyWith({int? age}) {
    return Student(
      rollNumber: rollNumber,
      age: age ?? this.age,
      height: height,
    );
  }
}
