import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/map_search/cubit/map_search_cubit.dart';
import 'package:location/location.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:intl/intl.dart';

@RoutePage()
class MapDirectionsPage extends StatefulWidget {
  final LatLng sourceCoords;
  final LatLng destinyCoords;
  final String destinationName;
  const MapDirectionsPage(
      {super.key,
      required this.destinyCoords,
      required this.sourceCoords,
      required this.destinationName});

  @override
  State<MapDirectionsPage> createState() => _MapDirectionsPage();
}

class _MapDirectionsPage extends State<MapDirectionsPage> {
  String distanceLeft = "0";
  String timeLeft = "0";
  String arrivalTime = "0";
  final mapsWidgetController = GlobalKey<GoogleMapsWidgetState>();

  Future<LocationData?> _getLocation() async {
    Location location = Location();
    return await location.getLocation();
  }


  void _selectTransportMode() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Selecciona un Medio de Transporte"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("Caminando"),
                onTap: () {
                  Navigator.of(context).pop();
                  _updateRoute(TransportMode.walking);
                },
              ),
              ListTile(
                title: Text("Auto"),
                onTap: () {
                  Navigator.of(context).pop();
                  _updateRoute(TransportMode.driving);
                },
              ),
              ListTile(
                title: Text("Transporte Público"),
                onTap: () {
                  Navigator.of(context).pop();
                  _updateRoute(TransportMode.transit);
                },
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapSearchCubit, MapSearchState>(
        builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: Text(widget.destinationName),
          )
          body: Column(
            children: [
              Expanded(
                child: GoogleMapsWidget(
                  key: mapKey,
                  defaultCameraZoom: 15,
                  apiKey: "AIzaSyDrlBOulG7pFmv031_ki6AIBdB31trUvzI",
                  sourceLatLng: widget.sourceCoords,
                  destinationLatLng: widget.destinyCoords,
                  polylines: Set<Polyline>.of(myPolylines),
                  routeWidth: 3,
                  routeColor: Colors.transparent,
                  defaultCameraLocation: widget.sourceCoords,
                  sourceMarkerIconInfo: const MarkerIconInfo(isVisible: false),
                  driverMarkerIconInfo: const MarkerIconInfo(
                    icon: Icon(
                      Icons.toys,
                      color: Colors.green,
                    ),
                  ),
                  destinationMarkerIconInfo: MarkerIconInfo(
                    infoWindowTitle: widget.destinationName,
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                  ),
                  updatePolylinesOnDriverLocUpdate: true,
                  driverCoordinatesStream: Stream.periodic(
                    const Duration(milliseconds: 5000),
                        (i) {
                      return _getLocation();
                    },
                  ).asyncMap((event) async {
                    final location = await event;
                    return LatLng(location?.latitude ?? 0, location?.longitude ?? 0);
                  }),
                  totalDistanceCallback: (newDistance) => setState(() {
                    distanceLeft = newDistance ?? "0";
                  }),
                  totalTimeCallback: (newTime) => setState(() {
                    if (newTime == null) {
                      timeLeft = "...";
                      return;
                    }
                    String hoursToAdd = "0";
                    final DateTime now = DateTime.now();
                    final List<String> reversed = newTime.toString().split(" ").reversed.toList();
                    final minutesToAdd = reversed[1];
                    if (reversed.length > 2) {
                      hoursToAdd = reversed[3];
                    }
                    final newArrivalTime = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        now.hour + int.parse(hoursToAdd),
                        now.minute + int.parse(minutesToAdd));
                    //arrivalTime = DateFormat.Hm().format(newArrivalTime);
                    //timeLeft = newTime;
                  }),
                  onPolylineUpdate: (Polyline polyline) {
                    print("Polyline updated");
                  },

            ListTile(
                subtitle: Text("$distanceLeft  \u2022  $arrivalTime",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20)),
                title: Text(timeLeft,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 25))),
          ]),
              floatingActionButton: FloatingActionButton(
            onPressed: _selectTransportMode,
            child: Icon(Icons.directions),
            tooltip: 'Seleccionar Medio de Transporte',
          ),);
    });
  }
}
