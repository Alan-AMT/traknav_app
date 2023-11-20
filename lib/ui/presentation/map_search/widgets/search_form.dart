import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:traknav_app/ui/presentation/home/widgets/searchBar.dart';
import 'package:traknav_app/ui/core/data/map_search.dart' as locations;

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  State<SearchForm> createState() => _SearchForm();
}

class _SearchForm extends State<SearchForm> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          GooglePlaceAutoCompleteTextField(
            showError: true,
            textEditingController: controller,
            googleAPIKey: "AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s",
            inputDecoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.search,
                color: Colors.white,
                size: 35,
              ),
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              hintText: 'Hola, ¿A dónde vamos?',
            ),
            debounceTime: 600,
            isLatLngRequired: true,
            getPlaceDetailWithLatLng: (Prediction prediction) {
              print("*****************************");
              // print("placeDetails" + prediction.lat.toString());
              print("*****************************");
              controller.text = prediction.description ?? "";
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: prediction.description?.length ?? 0));
            },
            itemClick: (Prediction prediction) {
              // controller.text = prediction.description ?? "";
              // controller.selection = TextSelection.fromPosition(
              //     TextPosition(offset: prediction.description?.length ?? 0));
            },
            seperatedBuilder: const Divider(thickness: 2),
            itemBuilder: (context, index, Prediction prediction) {
              final info = prediction.structuredFormatting;
              // print("${prediction.toJson()}");
              return ListTile(
                  title: Text("${info?.mainText}"),
                  subtitle: Text("${info?.secondaryText}"),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.pop(context, prediction.placeId);
                  },
                  leading: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.location_on)),
                  trailing: const CircleAvatar(child: Icon(Icons.north_west)),
                  style: ListTileStyle.list);
            },
            isCrossBtnShown: false,
          ),
        ]));
  }
}
