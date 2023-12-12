import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'plan_de_viaje.g.dart';

@JsonSerializable()
class PlanDeViaje {
  PlanDeViaje({
    required this.completed,
    required this.endDate,
    required this.startDate,
    required this.name,
    required this.days,
  });

  factory PlanDeViaje.fromJson(Map<String, dynamic> json) =>
      _$PlanDeViajeFromJson(json);
  Map<String, dynamic> toJson() => _$PlanDeViajeToJson(this);

  final bool completed;
  final int endDate;
  final int startDate;
  final String name;
  final Map<int, List<Map<String, bool>>> days;
}

class PlanDeViajeDataSource {
  static Future<QuerySnapshot<Map<String, dynamic>>>
      fetchCurrentPlanes() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final tripPlans = await usersCollection
        .doc(uid)
        .collection("PlanDeViaje")
        .where("completed", isEqualTo: false)
        .get();
    return tripPlans;
  }

  static Future<String> fetchPlaceImage(String placeId) async {
    const apiKey = "AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s";
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=photo&key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['result']['photos'] != null &&
          data['result']['photos'].length > 0) {
        // Obtener la referencia de la foto
        String photoReference = data['result']['photos'][0]['photo_reference'];
        // Construir la URL de la imagen
        return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$apiKey';
      }
    }
    return 'https://via.placeholder.com/400'; // Devolver una URL de imagen de marcador de posición si no hay imagen
  }

  static Future<Map<String, String>> fetchPlaceName(String placeId) async {
    const apiKey = "AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s";
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=name,photo&key=$apiKey');
    final response = await http.get(url);
    String name = "";

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      name = data['result']['name'];
    }
    return {"name": name};
  }
}
