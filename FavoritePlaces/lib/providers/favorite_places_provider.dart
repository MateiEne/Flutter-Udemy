import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlacesNotifier extends StateNotifier<List<Place>> {
  FavoritePlacesNotifier() : super([]);

  void addFavoritePlace(Place place) {
    // final bool placeExists = state.contains(place); // state gives access to my state :) in this case List<Place>

    state = [place, ...state];
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<Place>>((ref) => FavoritePlacesNotifier());
