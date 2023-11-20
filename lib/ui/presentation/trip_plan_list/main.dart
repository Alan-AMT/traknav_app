import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

@RoutePage()
class TripPlanListPage extends StatefulWidget {
  const TripPlanListPage({Key? key}) : super(key: key);

  @override
  _TripPlanListState createState() => _TripPlanListState();
}

class _TripPlanListState extends State<TripPlanListPage> {
  List<Map<String, dynamic>> planData = [
    {
      'title': 'Plan 1',
      'days': [
        {
          'day': 'Día 1',
          'places': [
            {'name': 'Museo de Frida Kahlo', 'completed': false},
            {'name': 'Museo de Soumaya', 'completed': false},
          ],
          'completed': false,
        },
        // ... otros días ...
      ],
    },
    // ... otros planes ...
  ];

  void _toggleDayCompletion(int planIndex, int dayIndex) {
    setState(() {
      var day = planData[planIndex]['days'][dayIndex];
      bool isCompleted = !day['completed'];
      day['completed'] = isCompleted;
      day['places'].forEach((place) => place['completed'] = isCompleted);
    });
  }

  void _togglePlaceCompletion(int planIndex, int dayIndex, int placeIndex) {
    setState(() {
      var place = planData[planIndex]['days'][dayIndex]['places'][placeIndex];
      place['completed'] = !place['completed'];

      // Verifica si todos los lugares en el día están completados
      bool allPlacesCompleted = true;
      for (var p in planData[planIndex]['days'][dayIndex]['places']) {
        if (!p['completed']) {
          allPlacesCompleted = false;
          break;
        }
      }

      planData[planIndex]['days'][dayIndex]['completed'] = allPlacesCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de planes',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontStyle: FontStyle.italic,
            fontSize: 30,
            color: Colors.white,
          ),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        itemCount: planData.length,
        itemBuilder: (context, planIndex) {
          final plan = planData[planIndex];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(plan['title'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ...plan['days'].asMap().entries.map<Widget>((dayEntry) {
                    int dayIndex = dayEntry.key;
                    var day = dayEntry.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckboxListTile(
                          title: Text('${day['day']} - ${day['completed'] ? "Finalizado" : "Pendiente"}'),
                          value: day['completed'],
                          onChanged: (_) => _toggleDayCompletion(planIndex, dayIndex),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            children: day['places'].asMap().entries.map<Widget>((placeEntry) {
                              int placeIndex = placeEntry.key;
                              var place = placeEntry.value;
                              return CheckboxListTile(
                                controlAffinity: ListTileControlAffinity.leading,
                                title: Text(place['name']),
                                value: place['completed'],
                                onChanged: (_) => _togglePlaceCompletion(planIndex, dayIndex, placeIndex),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Acción para editar el plan de viaje
                        },
                        child: const Text('Editar plan de viaje'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Acción para iniciar el plan de viaje
                        },
                        child: const Text('Iniciar plan de viaje'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}