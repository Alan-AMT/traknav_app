import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:traknav_app/ui/config/toasts/main.dart';
import 'package:traknav_app/ui/presentation/PlanDeViaje/cubit/plan_de_viaje_cubit.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:traknav_app/ui/core/data/map_search.dart' as dataSource;

class TripDayPlaces extends StatefulWidget {
  final List<Map<String, dynamic>> day;
  final int dayNumber;
  final String planId;
  final DateTime date;
  const TripDayPlaces(
      {Key? key,
      required this.day,
      required this.planId,
      required this.dayNumber,
      required this.date})
      : super(key: key);

  @override
  State<TripDayPlaces> createState() => _TripDayPlaces();
}

class _TripDayPlaces extends State<TripDayPlaces> {
  final format = DateFormat('EEE, M/d/y');
  Future<bool> checkPermissions() async {
    bool serviceEnabled;
    Location location = Location();
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        false;
      }
    }
    return true;
  }

  Future<LocationData?> _getLocation() async {
    final bool hasPermission = await checkPermissions();
    if (!hasPermission) return null;
    Location location = Location();
    return await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Día ${widget.dayNumber} - ${format.format(widget.date)}"),
      SizedBox(
          height: 300,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemCount: widget.day.length,
              itemBuilder: (context, index) {
                final place = widget.day[index];
                return SizedBox(
                    width: (MediaQuery.of(context).size.width * 0.94),
                    child: Column(children: [
                      CheckboxListTile(
                        title: Text(place["name"],
                            maxLines: 2, overflow: TextOverflow.fade),
                        value: place["visited"] ?? false,
                        onChanged: (bool? newValue) async {
                          try {
                            await context
                                .read<PlanDeViajeCubit>()
                                .updatePlaceVisitedStatus(
                                    dayNumber: widget.dayNumber,
                                    placeIndex: index,
                                    oldInfo: widget.day,
                                    docId: widget.planId,
                                    status: newValue ?? false);
                            setState(() {
                              place["visited"] = newValue ?? false;
                            });
                          } catch (e) {
                            print(e);
                            ToastApp.error(
                                "No pudimos actualizar el estado del lugar. Intenta de nuevo");
                          }
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await EasyLoading.show();
                          final details = await dataSource.getPlaceDetails(
                              placeId: place["id"]);
                          final targetPosition = LatLng(
                              details.location.latitude,
                              details.location.longitude);
                          final LocationData? currentLocation =
                              await _getLocation();
                          // ignore: use_build_context_synchronously
                          await EasyLoading.dismiss();
                          context.router.push(MapDirectionsRoute(
                              destinyCoords: targetPosition,
                              sourceCoords: LatLng(
                                  currentLocation?.latitude ?? 0,
                                  currentLocation?.longitude ?? 0),
                              destinationName: place["name"]));
                        },
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(place["imageUrl"]),
                                  fit: BoxFit.cover)),
                        ),
                      )
                    ]));
              }))
    ]);
  }
}
