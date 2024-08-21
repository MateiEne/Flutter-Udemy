import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/favorite_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});

  @override
  ConsumerState<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlace> {
  final _newPlaceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Place"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _newPlaceController,
                decoration: const InputDecoration(
                  label: Text("New place"),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              FilledButton(
                onPressed: () {
                  if (!context.mounted) {
                    return;
                  }
                  Navigator.of(context).pop();

                  ref
                      .read(favoritePlacesProvider.notifier)
                      .addFavoritePlace(Place(id: _newPlaceController.text, title: _newPlaceController.text));
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onSecondary,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Add Place",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
