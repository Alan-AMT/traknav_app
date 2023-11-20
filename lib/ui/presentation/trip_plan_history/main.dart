import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

@RoutePage()
class TripPlanHistoryPage extends StatelessWidget {
  const TripPlanHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo para la lista de historial
    final List<Map<String, dynamic>> historyData = [
      {
        'title': 'Plan 1',
        'date': '2 nov 2023',
        'route': 'Ruta: Pino Suarez - Nezahualcoyotl',
        'completed': true,
      },
      {
        'title': 'Plan 2',
        'date': '3 nov 2023',
        'route': 'Ruta: Algun lugar - Otro lugar',
        'completed': false,
      },
      // Agrega más planes aquí
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Historial',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontStyle: FontStyle.italic,
            fontSize: 30,
            color: Colors.white,
          ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        itemCount: historyData.length,
        itemBuilder: (context, index) {
          final item = historyData[index];
          return HistoryListItem(
            title: item['title'],
            date: item['date'],
            route: item['route'],
            completed: item['completed'],
          );
        },
      ),
    );
  }
}

class HistoryListItem extends StatelessWidget {
  final String title;
  final String date;
  final String route;
  final bool completed;

  const HistoryListItem({
    Key? key,
    required this.title,
    required this.date,
    required this.route,
    required this.completed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Asumiendo que la imagen del mapa es un activo local, la incluimos aquí.
            // Reemplaza 'assets/path_to_map_image.png' con la ruta correcta de tu imagen.
            Image.asset(
              'assets/TravelPlan/rutaejem.png',
              width: double.infinity, // Ajusta la imagen a la anchura del contenedor.
              height: 150, // Altura fija para la imagen.
              fit: BoxFit.cover, // Ajusta la imagen al espacio disponible.
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(date, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 8),
            Text(route, style: const TextStyle(fontSize: 16)),
            if (completed) ...[
              const SizedBox(height: 8),
              const Icon(Icons.check_circle, color: Colors.green),
            ],
          ],
        ),
      ),
    );
  }
}