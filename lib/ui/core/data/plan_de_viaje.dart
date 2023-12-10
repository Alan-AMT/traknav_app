import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

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
  final Map<int, List<String>> days;
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
}
//   // Fallback for when the above HTTP request fails.
//   return PlaceDetails.fromJson(
//       json.decode("{'location': {'latitude': 0, 'longitude': 0}}"));
// }
