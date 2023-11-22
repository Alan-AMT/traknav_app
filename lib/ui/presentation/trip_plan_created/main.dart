import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class TripPlanCreatedPage extends StatelessWidget {
  const TripPlanCreatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Los datos reales deberían venir de tu estado o base de datos
    final List<Map<String, dynamic>> tripDaysData = [
      {
        'day': 'Día 1',
        'places': [
          {'name': 'Museo de Frida Kahlo', 'image': 'assets/TravelPlan/museoF.png'},
          {'name': 'Museo Soumaya', 'image': 'assets/TravelPlan/museoS.png'},
        ],
      },
      {
        'day': 'Día 2',
        'places': [
          {'name': 'Museo de Antropología', 'image': 'assets/TravelPlan/museoA.png'},
          {'name': 'Museo de la Ciudad de Mexico', 'image': 'assets/TravelPlan/museoC.png'},
        ],
      },
      // ...otros días...
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Plan de Viaje',
          style: TextStyle(
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(tripDaysData[index]['day'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: tripDaysData[index]['places'].length,
                          itemBuilder: (context, placeIndex) {
                            final place = tripDaysData[index]['places'][placeIndex];
                            return Card(
                              child: Column(
                                children: [
                                  Image.asset(place['image'], fit: BoxFit.cover),
                                  Text(place['name']),
                                  // ... any other place details here ...
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
                  onPressed: () {
                    // Logic to edit plan
                  },
                  child:  const Text('Editar plan'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Logic to create plan
                  },
                  child: const Text('Crear plan'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

