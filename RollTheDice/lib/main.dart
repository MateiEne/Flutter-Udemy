import 'package:flutter/material.dart';
import 'package:roll_the_dice/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          <Color>[
            Colors.purple,
            Colors.deepPurple,
          ],
        ),
      ),
    ),
  );
}
