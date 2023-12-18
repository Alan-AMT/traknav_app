import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaceDetail extends StatefulWidget {
  final String placeId;
  final String placeName;
  final String placeAdress;
  final LatLng placePosition;
  final LatLng currentPosition;
  const PlaceDetail(
      {super.key,
      required this.placeId,
      required this.placeAdress,
      required this.placePosition,
      required this.currentPosition,
      required this.placeName});

  @override
  State<PlaceDetail> createState() => _PlaceDetail();
}

class _PlaceDetail extends State<PlaceDetail> {
  TextEditingController controller = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(widget.placeName),
          subtitle: Text(widget.placeAdress),
          isThreeLine: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: TextButton(
              child: Text(AppLocalizations.of(context)!.goToPlaceButton),
              onPressed: () async {
                if (!await checkPermissions()) return;
                context.router.push(MapDirectionsRoute(
                    destinationName: widget.placeName,
                    destinyCoords: widget.placePosition,
                    sourceCoords: widget.currentPosition));
              },
            )),
          ],
        )
      ],
    );
  }
}
