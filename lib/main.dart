import 'package:appdemo/todolist/cubit/todolist_cubit.dart';
import 'package:appdemo/todolist/todolist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => TodolistCubit(),
        child: const TodayList(),
      ),
    );
  }
}
