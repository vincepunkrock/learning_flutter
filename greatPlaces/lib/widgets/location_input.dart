import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greatPlaces/helpers/location_helper.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    final staticMapUrl = LocationHelper.generateLocationPreviewImage(locData.latitude, locData.longitude);
    setState(() {
      _previewImageUrl = staticMapUrl;
      print(_previewImageUrl);
    });
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
            FlatButton.icon(onPressed: null, icon: Icon(Icons.map), label: Text("select on map"))
          ],
        )
      ],
    );
  }
}
