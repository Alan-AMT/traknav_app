import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/presentation/home/widgets/acercaDe.dart';
import 'package:traknav_app/ui/presentation/home/widgets/catalog.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import '../widgets/aboutPlaces.dart';

class RecomendedWidget extends StatefulWidget {
  const RecomendedWidget({Key? key}) : super(key: key);

  @override
  _RecomendedWidgetState createState() => _RecomendedWidgetState();
}

class _RecomendedWidgetState extends State<RecomendedWidget> {
  List<StyleModel> list = [];
  //creamos una lista para guardar la imagen de los lugares de la API de google
//-----------PARA PODER OBTENER LA POSICIÓN--------------
  Future<LocationData?> _getLocation() async {
    final bool hasPermission = await checkPermissions();
    if (!hasPermission) return null;
    Location location = Location();
    return await location.getLocation();
  }

  //------PARA VERIFICAR SI SE TIENEN PERMISOS PARA ACCEDER A LA LOCALIZACIÓN-------
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

  @override
  void initState() {
    super.initState();
    _getLocation().then((position) {
      // climaDataF = getClimaForecast(position);
      fetchData(position);
      setState(() {});
    });
  }

  Future<void> fetchData(LocationData? location) async {
    // Tu lógica para obtener datos desde la API
    String url = 'https://places.googleapis.com/v1/places:searchNearby';
    // Los datos que enviarás en el cuerpo de la solicitud POST
    print("Hola");
    print("tamanio: ${list.length}");
    // Body de la solicitud
    Map<String, dynamic> lugares = {
      "includedTypes": [
        "museum",
        "restaurant",
        "mexican_restaurant",
        "park",
      ],
      "maxResultCount": 20,
      "locationRestriction": {
        "circle": {
          "center": {
            "latitude": location?.latitude,
            "longitude": location?.longitude
          },
          "radius": 2000.0
        }
      }
    };

    // Las cabeceras de la solicitud
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s',
      // Reemplaza 'API_KEY' con tu clave real
      'X-Goog-FieldMask':
          'places.id,places.displayName,places.photos,places.regularOpeningHours,places.shortFormattedAddress,places.editorialSummary',
    };

    // Realiza la solicitud POST
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(lugares),
        headers: headers,
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        //imprimimos el json
        // print('Respuesta exitosa: ${response.body}');
        //imprimimos la hora de apertura y cerrar del primer lugar
        //imprimimos el editorialSummary del primer lugar en español
        // print('${jsonData["places"][0]["editorialSummary"]["text"]}');
        //imprimimos todos los editorialSummary de los lugares
        //print('${jsonData["places"][2]["editorialSummary"]["text"]}');

        //imprimos por adrFormatAddress
        //imprimimos el address del primer lugar
        // print('Address: ${jsonData["places"][0]["adrAddress"]}');
        // Iterar sobre los lugares en jsonData

        for (int i = 0; i < jsonData["places"].length; i++) {
          // Asegurarse de que haya fotos disponibles
          if (jsonData["places"][i]["photos"] != null &&
              jsonData["places"][i]["photos"].isNotEmpty) {
            // Obtener la referencia de la primera foto (puedes ajustar esto según tus necesidades)
            String photoReference = jsonData["places"][i]["photos"][0]["name"];
            String imageUrl = buildImageUrl(photoReference);
            String name = jsonData["places"][i]["displayName"]["text"];
            String openingHours =
                "Abierto de ${jsonData["places"][i]["regularOpeningHours"]["periods"][0]["open"]["hour"]} a ${jsonData["places"][i]["regularOpeningHours"]["periods"][0]["close"]["hour"]}";
            String address = jsonData["places"][i]["shortFormattedAddress"];
            String editorialSummary;
            if (jsonData["places"][i]["editorialSummary"] != null &&
                jsonData["places"][i]["editorialSummary"]["text"] != null) {
              // Acceder a "text" solo si está presente
              editorialSummary =
                  jsonData["places"][i]["editorialSummary"]["text"];
            } else {
              // Si "editorialSummary" no está presente, imprime un mensaje de advertencia
              editorialSummary = "No hay descripción disponible";
            }
            //Abierto de ${ place['regularOpeningHours']['periods'][0]['open']['time']} a ${ place['regularOpeningHours']['periods'][0]['close']['time']}"; // Nueva línea
            //print("Nombre: $name");
            //print("Hora de apertura: $openingHours");
            setState(() {
              list.add(
                StyleModel(
                  id: (list.length + 1).toString(), // Generar un nuevo ID único
                  url: imageUrl,
                  name: name,
                  description: editorialSummary,
                  direction: address,
                  schedule: openingHours,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(168, 131, 131, 131),
                      blurRadius: 8.0,
                      spreadRadius: 1.0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              );
            });
          }
        }
        //imprimimos la lista
        print("tamanio: ${list.length}");
      } else {
        // Hubo un error en la solicitud, puedes manejarlo aquí
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      // Maneja las excepciones que puedan ocurrir durante la solicitud
      print('Error: $e');
    }
  }

  String buildImageUrl(String photoReference) {
    // Ajusta la URL según la documentación de la API de Google Places
    const String apiKey =
        'AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s'; // Reemplaza 'TU_API_KEY' con tu clave real

    return 'https://places.googleapis.com/v1/$photoReference/media?maxHeightPx=400&maxWidthPx=400&key=$apiKey';
  }

  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                AppLocalizations.of(context)!.homeRecomendedTitle,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WidgetCatalog()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  //titulo Ver más
                  AppLocalizations.of(context)!.homeRecomendedMore,
                  style: TextStyle(
                    color: Color.fromRGBO(58, 172, 255, 1),
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 35.0,
            left: 0,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              padding: EdgeInsets.only(
                left: 25.0,
                right: 25.0,
              ),
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    _navigateToDetailPage(context, index);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 9.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          height: 137.0,
                          width: 113.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  list[index].url), // Usar NetworkImage
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(18.0),
                            boxShadow: list[index].boxShadow,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetailPage(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AboutPlaces(
          item: list[index],
          imageUrl: list[index].url,
          // Agrega valores adicionales según sea necesario
        ),
      ),
    );
  }
}

class StyleModel {
  final String id;
  final String url;
  final String name;
  final String description;
  final String direction;
  final String schedule;
  final List<BoxShadow> boxShadow;

  StyleModel({
    required this.id,
    required this.boxShadow,
    required this.url,
    required this.name,
    required this.description,
    required this.direction,
    required this.schedule,
  });
}
