import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

Future<String> showGoogleAutoPlaces (BuildContext context , GoogleMapController controller)async{

  const kGoogleApiKey = "AIzaSyA9wNAXLazX_MoD_JB44RxZw-RwwWSE8DY";

  Prediction place = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      mode: Mode.overlay,
      types: [],
      strictbounds: false,// Mode.fullscreen
      region: "us",
      language: "en",
      components: [new Component(Component.country, "fr")]);
  if(place != null){
    //form google_maps_webservice package
    final plist = GoogleMapsPlaces(apiKey:kGoogleApiKey,
      //from google_api_headers package
    );
    String placeid = place.placeId ?? "0";
    final detail = await plist.getDetailsByPlaceId(placeid);
    final geometry = detail.result.geometry;
    final lat = geometry.location.lat;
    final lang = geometry.location.lng;
    var newlatlang = LatLng(lat, lang);
    //move map camera to selected place with animation
    controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
    return place.description ;
  }
}
