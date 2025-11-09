import 'package:flutter/material.dart';

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

class DynamicDisplacement extends StatefulWidget {
  const DynamicDisplacement({super.key});

  @override
  State<DynamicDisplacement> createState() => _DynamicDisplacementState();
}

class _DynamicDisplacementState extends State<DynamicDisplacement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Dynamic Displacement')),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          "Ali Hussain, Flutter Developer, Flutter Dev, Hello world Ali,   Ali Hussain, Flutter Developer, Flutter Dev, Hello world Ali,   Ali Hussain, Flutter Developer, Flutter Dev, Hello world Ali,   Ali Hussain, Flutter Developer, Flutter Dev, Hello world Ali,   Ali Hussain, Flutter Developer, Flutter Dev, Hello world Ali,   Ali Hussain, Flutter Developer, Flutter Dev, Hello world Ali,   ",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
