import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_places_flutter/model/prediction.dart';
import '../../router/android.gr.dart';
import '../trip_plan_edit/main.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:http/http.dart' as http;

import '../trip_plan_list/main.dart';

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
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Quieres agregar "${prediction.description}" al día ${dayIndex + 1}?'),
                SizedBox(height: 20.0),
                // El FutureBuilder ahora manejará la lógica para agregar el lugar
                FutureBuilder<String>(
                  future: _fetchPlaceImage(prediction.placeId!), // Aseguramos de que placeId no sea null
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error al cargar la imagen');
                    } else {
                      // Si tiene datos, muestra la imagen y el botón "Agregar"
                      return Column(
                        children: [
                          if (snapshot.hasData && snapshot.data!.isNotEmpty)
                            Image.network(
                              snapshot.data!,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return Text('No se pudo cargar la imagen'); // Texto o widget a mostrar en caso de error.
                              },
                            )
                          else
                            Text('No hay imagen disponible'),
                          ElevatedButton(
                            child: Text('Agregar'),
                            onPressed: () {
                              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                setState(() {
                                  tripDaysData[dayIndex]['places'].add({
                                    'name': prediction.description,
                                    'imageUrl': snapshot.data, // Guarda la URL de la imagen
                                  });
                                });
                                Navigator.of(dialogContext).pop();
                              }
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> _fetchPlaceImage(String placeId) async {
    const apiKey = "AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s";
    final url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=photo&key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['result']['photos'] != null && data['result']['photos'].length > 0) {
        // Obtener la referencia de la foto
        String photoReference = data['result']['photos'][0]['photo_reference'];
        // Construir la URL de la imagen
        return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$apiKey';
      }
    }
    return 'https://via.placeholder.com/400'; // Devolver una URL de imagen de marcador de posición si no hay imagen
  }

  void _showCreatePlanDialog() {
    // Verifica si hay al menos un lugar en el plan de viaje
    bool hasPlaces = tripDaysData.any((day) => day['places'].isNotEmpty);

    if (!hasPlaces) {
      // Si no hay lugares, muestra el diálogo de validación
      _showValidationDialog();
    } else {
      // Si hay lugares, muestra el diálogo de confirmación para crear el plan
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
                  Navigator.of(dialogContext).pop(); // Cierra el cuadro de diálogo
                  context.router.popUntil((route) =>
                  route.settings.name == TripPlanRoute.name);
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _showValidationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Error al generar el Plan de Viaje'),
          content: Text('Por favor, añade al menos un lugar antes de crear el plan.'),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToEditPage() {
    // Verifica si hay al menos un día y ese día tiene al menos un lugar
    bool canEdit = tripDaysData.isNotEmpty && tripDaysData.any((day) => day['places'].isNotEmpty);

    if (canEdit) {
      _navigateToEditTripPlanPage();
    } else {
      _showCannotEditDialog();
    }
  }

  void _navigateToEditTripPlanPage() async {
    final updatedTripData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTripPlanPage(tripDaysData: tripDaysData),
      ),
    );

    if (updatedTripData != null) {
      setState(() {
        tripDaysData = updatedTripData;
      });
    }
  }



  void _showCannotEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Error al Editar Plan de Viaje'),
          content: Text('Debe haber al menos un día con un lugar para editar el plan de viaje.'),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  void _addPlaceToDay() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return SimpleDialog(
          title: Text('Selecciona el Día'),
          children: tripDaysData.map((dayData) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(dialogContext); // Cierra el diálogo
                _showPlaceSearchDialog(dayData['day'] - 1);
              },
              child: Text('Día ${dayData['day']}'),
            );
          }).toList(),
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
                      crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto a la izquierda
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${AppLocalizations.of(context)!.tripplanday} ${dayData['day']}',
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                            onPressed: () => _showPlaceSearchDialog(index),
                            child: Text('Agregar Lugar'),
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
                                  // ClipRRect para asegurarnos de que la imagen no se desborde
                                  if (place['imageUrl'] != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0), // Agregamos un borde redondeado a la imagen
                                      child: Image.network(
                                        place['imageUrl'],
                                        height: 100, // Altura fija para la imagen, ajusta según tus necesidades
                                        width: double.infinity, // La imagen ocupa todo el ancho disponible
                                        fit: BoxFit.cover, // Cubre el espacio de la imagen sin perder la proporción
                                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                          return Text('Imagen no disponible'); // Texto a mostrar si la imagen no carga
                                        },
                                      ),
                                    ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        place['name'],
                                        overflow: TextOverflow.ellipsis, // El texto se cortará con puntos suspensivos si es demasiado largo
                                        maxLines: 2, // Máximo de líneas para el nombre del lugar
                                      ),
                                    ),
                                  ),
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
                  onPressed: _navigateToEditPage,
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