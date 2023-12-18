import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'map_search.g.dart';

@JsonSerializable()
class LatLng {
  LatLng({
    required this.latitude,
    required this.longitude,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double latitude;
  final double longitude;
}

// @JsonSerializable()
// class Region {
//   Region({
//     required this.coords,
//     required this.id,
//     required this.name,
//     required this.zoom,
//   });

//   factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
//   Map<String, dynamic> toJson() => _$RegionToJson(this);

//   final LatLng coords;
//   final String id;
//   final String name;
//   final double zoom;
// }

// @JsonSerializable()
// class Office {
//   Office({
//     required this.address,
//     required this.id,
//     required this.image,
//     required this.lat,
//     required this.lng,
//     required this.name,
//     required this.phone,
//     required this.region,
//   });

//   factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
//   Map<String, dynamic> toJson() => _$OfficeToJson(this);

//   final String address;
//   final String id;
//   final String image;
//   final double lat;
//   final double lng;
//   final String name;
//   final String phone;
//   final String region;
// }

// @JsonSerializable()
// class Locations {
//   Locations({
//     required this.offices,
//     required this.regions,
//   });

//   factory Locations.fromJson(Map<String, dynamic> json) =>
//       _$LocationsFromJson(json);
//   Map<String, dynamic> toJson() => _$LocationsToJson(this);

//   final List<Office> offices;
//   final List<Region> regions;
// }

// Future<Locations> getGoogleOffices() async {
//   const googleLocationsURL = 'https://about.google/static/data/locations.json';

//   try {
//     final response = await http.get(Uri.parse(googleLocationsURL));
//     if (response.statusCode == 200) {
//       return Locations.fromJson(json.decode(response.body));
//     }
//   } catch (e) {
//     print(e);
//   }

//   // Fallback for when the above HTTP request fails.
//   return Locations.fromJson(json.decode("{'mamaste':'fallo'}")
//       // json.decode(
//       //   await rootBundle.loadString('assets/locations.json'),
//       // ),
//       );
// }

@JsonSerializable()
class PlaceDetails {
  final LatLng location;
  PlaceDetails({
    required this.location,
  });

  factory PlaceDetails.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceDetailsToJson(this);
}

Future<PlaceDetails> getPlaceDetails({required String placeId}) async {
  final getPlaceDetailsURL =
      'https://places.googleapis.com/v1/places/$placeId?fields=location&key=AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s';

  try {
    final response = await http.get(Uri.parse(getPlaceDetailsURL));
    if (response.statusCode == 200) {
      return PlaceDetails.fromJson(json.decode(response.body));
    }
  } catch (e) {
    print(e);
  }

  // Fallback for when the above HTTP request fails.
  return PlaceDetails.fromJson(
      json.decode("{'location': {'latitude': 0, 'longitude': 0}}"));
}
