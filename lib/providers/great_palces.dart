import 'package:flutter/foundation.dart';
import '../models/place.dart';
import 'dart:io';

//now let's use the model of our place in the great_places.dart
class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  //we are creating a method to add a new place
  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: PlaceLocation(
        latitude: 37.422,
        longitude: -122.084,
        address: 'San Francisco, CA',
      ),
      image: pickedImage,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}
