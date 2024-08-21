import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class SelectedPlace extends StatelessWidget {
  const SelectedPlace({
    required this.place,
    super.key,
  });

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
    );
  }
}
