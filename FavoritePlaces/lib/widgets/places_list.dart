import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({required this.favoritePlaces, super.key});

  final List<Place> favoritePlaces;

  void _onSelectPlace(Place place, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => SelectedPlace(
          place: place,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: favoritePlaces.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(favoritePlaces[index].title),
          onTap: () {
            _onSelectPlace(favoritePlaces[index], context);
          },
        );
      },
    );
  }
}
