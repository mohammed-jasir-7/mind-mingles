import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(child: Text("play game")),
      )),
    );
  }
}
