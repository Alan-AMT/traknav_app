import 'dart:async';
import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/map_search/cubit/map_search_cubit.dart';
import 'package:location/location.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

enum TransportMode { walking, driving, transit }

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
  late TransportMode _selectedMode; // Definición de la variable
  String distanceLeft = "0";
  String timeLeft = "0";
  String arrivalTime = "0";
  List<Polyline> myPolylines = [];
  final mapsWidgetController = GlobalKey<GoogleMapsWidgetState>();
  ValueKey<int> mapKey = ValueKey(DateTime.now().millisecondsSinceEpoch);

  Future<void> _getRoute(TransportMode mode) async {
    String modeValue = _getModeValue(mode);
    String baseUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${widget.sourceCoords.latitude},${widget.sourceCoords.longitude}&destination=${widget.destinyCoords.latitude},${widget.destinyCoords.longitude}&mode=$modeValue&key=AIzaSyDrlBOulG7pFmv031_ki6AIBdB31trUvzI";

    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var routes = jsonData['routes'];

        if (routes.isNotEmpty) {
          var encodedPolyline = routes[0]['overview_polyline']['points'];
          var polylinePoints = _decodePolyline(encodedPolyline);
          var leg = routes[0]['legs'][0];
          var distance = leg['distance']['text'];
          var duration = leg['duration']['text'];
          var durationValue = leg['duration']['value'];
          var arrivalDateTime =
              DateTime.now().add(Duration(seconds: durationValue));
          var formattedArrivalTime = DateFormat.Hm().format(arrivalDateTime);

          setState(() {
            myPolylines = [
              Polyline(
                polylineId: PolylineId('new_route'),
                color: Colors.blue,
                points: polylinePoints,
                width: 5,
              )
            ];
            // Actualiza la información de distancia, tiempo y hora de llegada
            distanceLeft = distance;
            timeLeft = duration;
            arrivalTime = formattedArrivalTime;
          });
        }
      } else {
        setState(() {
          distanceLeft = "Error";
          timeLeft = "Error";
          arrivalTime = "Error";
          myPolylines = [];
        });
        print("Error al obtener la ruta: ${response.statusCode}");
      }
    } catch (e) {
      // Manejo de errores en la solicitud HTTP.
      setState(() {
        distanceLeft = "Error";
        timeLeft = "Error";
        arrivalTime = "Error";
        myPolylines = [];
      });
      print("Error al conectar con la API: $e");
    }
  }

  String _getModeValue(TransportMode mode) {
    switch (mode) {
      case TransportMode.walking:
        return "walking";
      case TransportMode.driving:
        return "driving";
      case TransportMode.transit:
        return "transit";
      default:
        return "driving";
    }
  }

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
  void initState() {
    super.initState();
    _selectedMode =
        TransportMode.driving; // Solo se establece aquí inicialmente
    _getRoute(_selectedMode); // Solicita la ruta inicial
  }

  // Este método se llama cuando el usuario selecciona un nuevo modo de transporte
  void onTransportModeSelected(TransportMode mode) {
    if (_selectedMode != mode) {
      setState(() {
        _selectedMode = mode;
      });
      _getRoute(_selectedMode); // Solicita la nueva ruta
    }
  }

  void _updateRoute(TransportMode mode) {
    setState(() {
      _selectedMode = mode;
      distanceLeft = "0";
      timeLeft = "0";
      arrivalTime = "0";
    });
    _getRoute(mode);
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      LatLng p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      points.add(p);
    }

    return points;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapSearchCubit, MapSearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.destinationName),
          ),
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
                    return LatLng(
                        location?.latitude ?? 0, location?.longitude ?? 0);
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
                    final List<String> reversed =
                        newTime.toString().split(" ").reversed.toList();
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
                ),
              ),
              ListTile(
                subtitle: Text(
                  "$distanceLeft  \u2022  $arrivalTime",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
                title: Text(
                  timeLeft,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _selectTransportMode,
            child: Icon(Icons.directions),
            tooltip: 'Seleccionar Medio de Transporte',
          ),
        );
      },
    );
  }
}
