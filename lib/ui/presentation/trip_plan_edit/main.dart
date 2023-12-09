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
    setState(() {
      editableTripData.add({
        'day': editableTripData.length + 1,
        'places': [],
      });
    });
  }

  void _removeDay(int dayIndex) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Eliminar Día'),
          content: Text('¿Estás seguro de que quieres eliminar el Día ${dayIndex + 1}?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                setState(() => editableTripData.removeAt(dayIndex));
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void _removePlaceFromDay(int dayIndex, int placeIndex) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Eliminar Lugar'),
          content: Text('¿Estás seguro de que quieres eliminar este lugar?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                setState(() => editableTripData[dayIndex]['places'].removeAt(placeIndex));
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _saveChanges() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Confirmar Cambios'),
          content: Text('¿Estás seguro de que quieres guardar los cambios?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cierra el diálogo
                _confirmSaveAndExit();
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmSaveAndExit() {
    for (int i = 0; i < editableTripData.length; i++) {
      editableTripData[i]['day'] = i + 1;
    }

    // Muestra el cuadro de diálogo de confirmación
    _showSaveConfirmationDialog();

    // Vuelve a la pantalla anterior después de un breve retraso
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop(editableTripData);
    });
  }

  void _showSaveConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text("Guardando cambios..."),
                // Aquí puedes añadir más lógica de animación si lo deseas
              ],
            ),
          ),
        );
      },
    );

    // Opcional: Cierra el diálogo después de un tiempo determinado
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Cierra el diálogo
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.edittripplan,
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
              itemCount: editableTripData.length,
              itemBuilder: (context, dayIndex) {
                var day = editableTripData[dayIndex];
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Día ${dayIndex + 1}'),
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
                            onPressed: () =>
                                _removePlaceFromDay(dayIndex, placeIndex),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                );
              },

            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Guardar Cambios'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 36), // Tamaño del botón
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewDay,
        child: Icon(Icons.add),
        tooltip: 'Agregar nuevo día',
      ),
    );
  }
}
