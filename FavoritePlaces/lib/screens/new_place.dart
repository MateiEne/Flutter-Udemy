import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/favorite_places_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});

  @override
  ConsumerState<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlace> {
  final _newPlaceController = TextEditingController();
  File? _selectedImage;

  @override
  void dispose() {
    _newPlaceController.dispose();
    super.dispose();
  }

  void _savePlace() {
    final enteredText = _newPlaceController.text;

    if (enteredText.isEmpty || _selectedImage == null) {
      return;
    }

    ref //
        .read(favoritePlacesProvider.notifier)
        .addFavoritePlace(
          Place(
            title: enteredText,
            image: _selectedImage!,
          ),
        );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Place"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _newPlaceController,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  decoration: const InputDecoration(
                    label: Text("New place"),
                  ),
                ),
                const SizedBox(height: 16),
                ImageInput(
                  onPickImage: (image) {
                    _selectedImage = image;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _savePlace,
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  label: Text(
                    "Add Place",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
