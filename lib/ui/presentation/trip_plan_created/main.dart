import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../router/android.gr.dart';
import '../trip_plan_edit/main.dart';

@RoutePage()
class TripPlanCreatedPage extends StatefulWidget {
  const TripPlanCreatedPage({Key? key}) : super(key: key);

  @override
  _TripPlanCreatedPageState createState() => _TripPlanCreatedPageState();
}

class _TripPlanCreatedPageState extends State<TripPlanCreatedPage> {
  List<Map<String, dynamic>> tripDaysData;
  _TripPlanCreatedPageState() : tripDaysData = [
    // Inicializa con tus datos iniciales aquí...
    {
      'day': 1,
      'places': [
        {
          'name': 'Museo de Frida Kahlo',
          'image': 'assets/TravelPlan/museoF.png'
        },
        {'name': 'Museo Soumaya', 'image': 'assets/TravelPlan/museoS.png'},
      ],
    },
    {
      'day': 2,
      'places': [
        {
          'name': 'Museo de Antropología',
          'image': 'assets/TravelPlan/museoA.png'
        },
        {
          'name': 'Museo de la Ciudad de Mexico',
          'image': 'assets/TravelPlan/museoC.png'
        },
      ],
    },
  ];
  @override
  Widget build(BuildContext context) {

    void _showCreatePlanDialog() {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.createPlanDialogTitle),
            content: Text(
                AppLocalizations.of(context)!.createPlanDialogMessage),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  Navigator.of(dialogContext)
                      .pop(); // Cierra el cuadro de diálogo
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.confirm),
                onPressed: () {
                  Navigator.of(dialogContext)
                      .pop(); // Cierra el cuadro de diálogo
                  context.router.popUntil((route) =>
                  route.settings.name == TripPlanRoute
                      .name); // Regresa a la pantalla TripPlanRoute
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.tripplanappbar,
          style: const TextStyle(
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
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          // Deshabilita el scroll de GridView
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
                                  Image.asset(
                                      place['image'], fit: BoxFit.cover),
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
                    // Navega a la pantalla de edición y espera los datos modificados
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
                  // Llama al método cuando se presiona el botón
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
