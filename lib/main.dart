import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() => runApp(const MyPetApp());

class MyPetApp extends StatelessWidget {
  const MyPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '宠物互动软件',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomePage(),
    );
  }
}