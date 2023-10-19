import 'package:flutter/material.dart';

class TODO extends StatefulWidget {
  const TODO({Key? key}) : super(key: key);

  @override
  _TODOState createState() => _TODOState();
}

class _TODOState extends State<TODO> {
  bool _isUnderstand = false;

  @override
  Widget build(BuildContext context) {
    print("a intrat in build");

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TODO App'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Every flutter developer should have a basic understanding of Flutter's internals!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Do you understand how Flutter updates UI?",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    if (!_isUnderstand) {
                      setState(() {
                        _isUnderstand = true;
                      });
                    }
                  },
                  child: const Text(
                    "Yes!",
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_isUnderstand) {
                      setState(() {
                        _isUnderstand = false;
                      });
                    }
                  },
                  child: const Text(
                    "No!",
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            if (_isUnderstand) const Text("Awesome!")
          ],
        ),
      ),
    );
  }
}
