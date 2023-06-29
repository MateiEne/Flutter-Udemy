import 'dart:math';

import 'package:flutter/material.dart';

final Random _randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({Key? key}) : super(key: key);

  @override
  _DiceRollerState createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  int _currentDiceNumber = _randomizer.nextInt(6) + 1;

  void rollDice() {
    setState(() {
      _currentDiceNumber = _randomizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          'assets/images/dice-$_currentDiceNumber.png',
          width: 200,
        ),
        const SizedBox(
          height: 50,
        ),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: const Text(
            'Roll Dice',
          ),
        ),
      ],
    );
  }
}
