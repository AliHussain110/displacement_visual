import 'package:flutter/material.dart';
import 'dynamic_displacement.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Displacemet',
      home: DynamicDisplacement(),
    );
  }
}
