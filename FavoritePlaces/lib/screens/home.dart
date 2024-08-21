import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/new_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/providers/favorite_places_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void _onAddPlaces() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const NewPlace(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        "No places added yet",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );

    final List<Place> favoritePlaces = ref.watch(favoritePlacesProvider);

    if (favoritePlaces.isNotEmpty) {
      content = ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: favoritePlaces.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(favoritePlaces[index].title),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: <Widget>[
          IconButton(
            onPressed: _onAddPlaces,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
