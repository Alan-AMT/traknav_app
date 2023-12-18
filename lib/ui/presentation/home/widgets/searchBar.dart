import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:location/location.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:traknav_app/ui/presentation/map_search/widgets/search_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/core/data/map_search.dart' as dataSource;
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  String? homeSearchBarText;

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
    homeSearchBarText = AppLocalizations.of(context)!.homeSearchBar;

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 17.0, right: 17.0),
      height: 50.0,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: List.generate(
          1,
          (index) => BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 5,
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.16),
          ),
        ),
      ),
      child: TextField(
        onTap: () async {
          final <Object?>[placeId, mainText, secText, ..._] =
              await showMaterialModalBottomSheet(
            context: context,
            builder: (context) => const SearchForm(),
          );
          if (placeId == null) return;
          await EasyLoading.show();
          final details =
              await dataSource.getPlaceDetails(placeId: placeId.toString());
          final targetPosition =
              LatLng(details.location.latitude, details.location.longitude);
          final LocationData? currentLocation = await _getLocation();
          await EasyLoading.dismiss();
          // ignore: use_build_context_synchronously
          context.router.push(MapDirectionsRoute(
              destinyCoords: targetPosition,
              sourceCoords: LatLng(currentLocation?.latitude ?? 0,
                  currentLocation?.longitude ?? 0),
              destinationName: mainText.toString()));
        },
        cursorColor: Colors.white,
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 35,
          ),
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Color.fromARGB(129, 35, 34, 34),
            fontSize: 18.0,
            fontFamily: 'NUNITO_LIGHT',
          ),
          hintText: homeSearchBarText.toString(),
        ),
      ),
    );
  }
}
