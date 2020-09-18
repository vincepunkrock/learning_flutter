import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatPlaces/helpers/location_helper.dart';
import 'package:greatPlaces/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {

  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapUrl = LocationHelper.generateLocationPreviewImage(lat, lng);
    setState(() {
      _previewImageUrl = staticMapUrl;
      print(_previewImageUrl);
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    }
    catch(error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MapScreen(isSelecting: true,)));
    if(selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
          ),
          child: _previewImageUrl == null
              ? Text("No location chosen")
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
          alignment: Alignment.center,
        ),
        Row(
          children: [
            FlatButton.icon(onPressed: _getCurrentUserLocation, icon: Icon(Icons.location_on), label: Text("Current location")),
            FlatButton.icon(onPressed: _selectOnMap, icon: Icon(Icons.map), label: Text("select on map"))
          ],
        )
      ],
    );
  }
}
