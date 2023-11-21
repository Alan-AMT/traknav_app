import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:traknav_app/ui/presentation/home/widgets/searchBar.dart';
import 'package:traknav_app/ui/core/data/map_search.dart' as locations;
import 'package:traknav_app/ui/presentation/map_search/cubit/map_search_cubit.dart';
import 'package:traknav_app/ui/presentation/map_search/widgets/main.dart';
import 'package:location/location.dart';

@RoutePage()
class MapSearchPage extends StatefulWidget {
  const MapSearchPage({super.key});

  @override
  State<MapSearchPage> createState() => _MapSearchPage();
}

class _MapSearchPage extends State<MapSearchPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getLocation(context, _controller));
  }

  Future<void> _getLocation(
      BuildContext context, Completer<GoogleMapController> controller) async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    LocationData locationData = await location.getLocation();
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target:
                LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
            zoom: 10)));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapSearchCubit, MapSearchState>(
        builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Buscar'),
          ),
          body: Column(children: [
            GestureDetector(
              child: const ListTile(leading: Icon(Icons.search)),
              onTap: () async {
                final String? placeId = await showMaterialModalBottomSheet(
                    context: context, builder: (context) => const SearchForm());
                print("******************");
                print(placeId);
                if (placeId == null) return;
              },
            ),
            Expanded(
                child: GoogleMap(
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(0, 0),
                zoom: 3,
              ),
              markers: _markers.values.toSet(),
            )),
          ]));
    });
  }
}
