import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select your category"),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 3 / 2,
        ),
        children: <Widget>[
          Container(color: Colors.red),
          Container(color: Colors.blueAccent),
          Container(color: Colors.deepPurple),
          Container(color: Colors.orange),
          Container(color: Colors.purpleAccent),
          Container(color: Colors.blue),
        ],
      ),
    );
  }
}
