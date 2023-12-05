import 'package:flutter/cupertino.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class EditTripPlanPage extends StatefulWidget {
  final List<Map<String, dynamic>> tripDaysData;

  const EditTripPlanPage({Key? key, required this.tripDaysData}) : super(key: key);


  @override
  _EditTripPlanPageState createState() => _EditTripPlanPageState();
}

class _EditTripPlanPageState extends State<EditTripPlanPage> {
  late List<Map<String, dynamic>> editableTripData;

  @override
  void initState() {
    super.initState();
    editableTripData = List.from(widget.tripDaysData);
  }

  void _addNewDay() {
    // Agregar lógica para añadir un nuevo día
  }

  void _removeDay(int dayIndex) {
    // Agregar lógica para remover un día
  }

  void _addPlaceToDay(int dayIndex) {
    // Agregar lógica para añadir un nuevo lugar a un día específico
  }

  void _removePlaceFromDay(int dayIndex, int placeIndex) {
    // Agregar lógica para remover un lugar de un día específico
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Trip Plan'),
      ),
      body: ListView.builder(
        itemCount: editableTripData.length,
        itemBuilder: (context, dayIndex) {
          var day = editableTripData[dayIndex];
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text('Day ${dayIndex + 1}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () => _removeDay(dayIndex),
                  ),
                ),
                ...day['places'].map<Widget>((place) {
                  int placeIndex = day['places'].indexOf(place);
                  return ListTile(
                    title: Text(place['name']),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () => _removePlaceFromDay(dayIndex, placeIndex),
                    ),
                  );
                }).toList(),
                TextButton(
                  onPressed: () => _addPlaceToDay(dayIndex),
                  child: Text('Add Place'),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewDay,
        child: Icon(Icons.add),
      ),
    );
  }
}