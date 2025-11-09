// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:sprung/sprung.dart';

class DynamicDisplacement extends StatefulWidget {
  const DynamicDisplacement({super.key});

  @override
  State<DynamicDisplacement> createState() => _DynamicDisplacementState();
}

class _DynamicDisplacementState extends State<DynamicDisplacement>
    with SingleTickerProviderStateMixin {
  Offset _position = Offset.zero;
  Offset _delta = Offset.zero;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void _updateDragPosition(DragUpdateDetails details) {
    // log(details.localPosition.toString());
    double normalizedX = details.localPosition.dx;
    double normalizedY = details.localPosition.dy;
    // clamping the detla values so they get in_between -500 to 500
    double normalizedDetlaX = (details.delta.dx * 60).clamp(-500, 500);
    double normalizedDetlaY = (details.delta.dy * 60).clamp(-500, 500);
    setState(() {
      _position = Offset(normalizedX, normalizedY);
      if (details.delta != Offset.zero) {
        _delta = Offset.lerp(
          _delta,
          Offset(normalizedDetlaX, normalizedDetlaY),
          0.1,
        )!;
      }
    });
  }

  void _endDragAnimation() {
    // log('Detlta: $_delta');

    _animation =
        Tween<Offset>(begin: _delta, end: Offset.zero).animate(
          CurvedAnimation(parent: _controller, curve: Sprung.overDamped),
        )..addListener(() {
          setState(() {
            _delta = _animation.value;
          });
        });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Dynamic Displacement'), centerTitle: true),
      body: GestureDetector(
        onPanUpdate: _updateDragPosition,
        onPanEnd: (_) => _endDragAnimation(),
        child: addShader(child: textWidget()),
      ),
    );
  }

  Widget addShader({required Widget child}) {
    return ShaderBuilder((ctx, shader, _) {
      return AnimatedSampler((img, size, canvas) {
        shader
          ..setFloat(0, _position.dx)
          ..setFloat(1, _position.dy)
          ..setFloat(2, _delta.dx)
          ..setFloat(3, _delta.dy)
          ..setFloat(4, size.width)
          ..setFloat(5, size.height)
          ..setImageSampler(0, img);
        canvas.drawRect(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Paint()..shader = shader,
        );
      }, child: child);
    }, assetKey: 'shaders/shader.frag');
  }

  Widget textWidget() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        "Ali Hussain, Flutter Developer, Flutter Dev, Hello world Ali,   Ali Hussain, Flutter Developer, Flutter Dev, Hello world Ali,   Ali Hussain, Flutter Developer, Flutter Dev, Hello world Ali,   Ali Hussain, Flutter Developer, Flutter Dev, Hello world Ali,   Ali Hussain, Flutter Developer, Flutter Dev, Hello world Ali,   Ali Hussain, Flutter Developer, Flutter Dev, Hello world Ali,   ",
        style: TextStyle(
          fontSize: 35,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
