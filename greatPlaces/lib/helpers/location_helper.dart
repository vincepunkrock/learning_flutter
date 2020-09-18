import 'dart:convert';
import 'package:http/http.dart' as http;
import '../internal/keys.dart' as keys;

class LocationHelper {
  static String generateLocationPreviewImage(
    double latitude, double longitude
  ) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=${keys.googleMapsKey}';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {

    //cette requête ne fonctionne pas quand on l'appelle avec un android-restricted api key
    //https://stackoverflow.com/questions/56415252/restrict-google-directions-api-key-in-flutter
    //le geocoding api accepte seulement les restrictions d'adresse IP
    //voir la liste des api et restrictions valides ici: https://developers.google.com/maps/faq#keysystem
    //Il est donc recommandé de faire l'appel à partir du backend

    
    final url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${keys.googleMapsKey}";
    print(url);
    final response = await http.get(url);
    final jsonResponse = json.decode(response.body);
    if(jsonResponse['results'][0] == null) {
      throw("Invalid response: " + jsonResponse['error_message']);
    }
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}