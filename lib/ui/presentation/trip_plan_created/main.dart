import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_places_flutter/model/prediction.dart';
import '../../router/android.gr.dart';
import '../trip_plan_edit/main.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

@RoutePage()
class TripPlanCreatedPage extends StatefulWidget {
  final int days;

  TripPlanCreatedPage({required this.days});

  @override
  _TripPlanCreatedPageState createState() => _TripPlanCreatedPageState();
}

class _TripPlanCreatedPageState extends State<TripPlanCreatedPage> {
  List<Map<String, dynamic>> tripDaysData = [];

  @override
  void initState() {
    super.initState();
    for (int i = 1; i <= widget.days; i++) {
      tripDaysData.add({
        'day': i,
        'places': [],
      });
    }
  }

  void _showPlaceSearchDialog(int dayIndex) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            padding: EdgeInsets.all(20.0),
            constraints: BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Buscar Lugar',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                GooglePlaceAutoCompleteTextField(
                  textEditingController: TextEditingController(),
                  googleAPIKey: "AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s",
                  countries: ["mx"],
                  inputDecoration: InputDecoration(
                    hintText: 'Escribe el nombre del lugar...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  debounceTime: 600,
                  isLatLngRequired: true,
                  itemClick: (Prediction prediction) {
                    Navigator.pop(dialogContext);
                    _showAddPlaceConfirmationDialog(dayIndex, prediction);
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text('Cancelar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddPlaceConfirmationDialog(int dayIndex, Prediction prediction) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Agregar Lugar'),
          content: Text(
              '¿Quieres agregar "${prediction.description}" al día ${dayIndex +
                  1}?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text('Agregar'),
              onPressed: () {
                setState(() {
                  tripDaysData[dayIndex]['places'].add({
                    'name': prediction.description,
                  });
                });
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCreatePlanDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.createPlanDialogTitle),
          content: Text(AppLocalizations.of(context)!.createPlanDialogMessage),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cierra el diálogo
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.confirm),
              onPressed: () {
                Navigator.of(dialogContext)
                    .pop(); // Cierra el cuadro de diálogo
                context.router.popUntil((route) =>
                route.settings.name == TripPlanRoute
                    .name); // Regresa a la pantalla TripPlanRoute // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.tripplanappbar,
          style: const   TextStyle(
            fontFamily: 'Nunito',
            fontStyle: FontStyle.italic,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tripDaysData.length,
              itemBuilder: (context, index) {
                final dayData = tripDaysData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${AppLocalizations.of(context)!
                              .tripplanday} ${dayData['day']}',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                            onPressed: () => _showPlaceSearchDialog(index),
                            child: Text('Buscar Lugar'),
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: dayData['places'].length,
                          itemBuilder: (context, placeIndex) {
                            final place = dayData['places'][placeIndex];
                            return Card(
                              child: Column(
                                children: [
                                  // Aquí se muestra la información del lugar
                                  Text(place['name']),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final updatedTripData = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditTripPlanPage(tripDaysData: tripDaysData),
                      ),
                    );

                    if (updatedTripData != null) {
                      setState(() {
                        tripDaysData = updatedTripData;
                      });
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.edittripplan),
                ),
                ElevatedButton(
                  onPressed: _showCreatePlanDialog,
                  child: Text(AppLocalizations.of(context)!.createtripplan),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}