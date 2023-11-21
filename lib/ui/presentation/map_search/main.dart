import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:traknav_app/ui/presentation/home/widgets/searchBar.dart';
import 'package:traknav_app/ui/core/data/map_search.dart' as dataSource;
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
  // Future<void> _onMapCreated(GoogleMapController controller) async {
  //   final googleOffices = await dataSource.getGoogleOffices();
  //   setState(() {
  //     _markers.clear();
  //     for (final office in googleOffices.offices) {
  //       final marker = Marker(
  //         markerId: MarkerId(office.name),
  //         position: LatLng(office.lat, office.lng),
  //         infoWindow: InfoWindow(
  //           title: office.name,
  //           snippet: office.address,
  //         ),
  //       );
  //       _markers[office.name] = marker;
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getLocation(_controller));
  }

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

  Future<void> _getLocation(Completer<GoogleMapController> controller) async {
    final bool hasPermission = await checkPermissions();
    if (!hasPermission) return;
    Location location = Location();
    LocationData locationData = await location.getLocation();
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target:
                LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
            zoom: 15)));
  }

  Future<void> moveToPlace(Completer<GoogleMapController> controller,
      LatLng locationData, String mainName, String address) async {
    final bool hasPermission = await checkPermissions();
    if (!hasPermission) return;
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(locationData.latitude, locationData.longitude),
            zoom: 15)));
    final marker = Marker(
      markerId: MarkerId(mainName),
      position: LatLng(locationData.latitude, locationData.longitude),
      infoWindow: InfoWindow(
        title: mainName,
        snippet:
            address.substring(0, address.length > 20 ? 20 : address.length),
      ),
    );
    setState(() {
      _markers["destiny"] = marker;
    });
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
                final <Object?>[placeId, mainText, secText, ...rest] =
                    await showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => const SearchForm());
                if (placeId == null) return;
                final details = await dataSource.getPlaceDetails(
                    placeId: placeId.toString());
                await moveToPlace(
                    _controller,
                    LatLng(
                        details.location.latitude, details.location.longitude),
                    mainText.toString(),
                    secText.toString());
                // ignore: use_build_context_synchronously
                await showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) => PlaceDetail(
                        placeId: placeId.toString(),
                        placeAdress: secText.toString(),
                        placeName: mainText.toString()));
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
