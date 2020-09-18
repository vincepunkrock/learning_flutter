import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:greatPlaces/helpers/db_helper.dart';
import 'package:greatPlaces/helpers/location_helper.dart';
import 'package:greatPlaces/models/place.dart';

class GreatPlaces with ChangeNotifier {

  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addPlace(String title, File image, PlaceLocation pickedPlace) async {
    final address = await LocationHelper.getPlaceAddress(pickedPlace.latitude, pickedPlace.longitude);
    final updatedLocation = PlaceLocation(
      latitude: pickedPlace.latitude,
      longitude: pickedPlace.longitude,
      address: address
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: updatedLocation
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList.map((item) => Place(
      id: item['id'],
      title: item['title'],
      image: File(item['image']),
      location: PlaceLocation(
        latitude: item['loc_lat'],
        longitude: item['loc_lng'],
        address: item['address']
      )
    )).toList();
    notifyListeners();
  }

}