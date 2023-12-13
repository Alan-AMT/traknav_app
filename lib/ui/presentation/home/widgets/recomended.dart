import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/presentation/home/widgets/acercaDe.dart';
import 'package:traknav_app/ui/presentation/home/widgets/catalog.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class RecomendedWidget extends StatefulWidget {
  const RecomendedWidget({Key? key}) : super(key: key);

  @override
  _RecomendedWidgetState createState() => _RecomendedWidgetState();
}

class _RecomendedWidgetState extends State<RecomendedWidget> {
  List<StyleModel> list = [];
  //creamos una lista para guardar la imagen de los lugares de la API de google

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
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
          "center": {"latitude": 19.50478, "longitude": -99.14631},
          "radius": 2000.0
        }
      }
    };

    // Las cabeceras de la solicitud
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s',
      // Reemplaza 'API_KEY' con tu clave real
      'X-Goog-FieldMask': 'places.id,places.displayName,places.photos',
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
        //print('Respuesta exitosa: ${response.body}');
        // Iterar sobre los lugares en jsonData
        for (int i = 0; i < jsonData["places"].length; i++) {
          // Asegurarse de que haya fotos disponibles
          if (jsonData["places"][i]["photos"] != null &&
              jsonData["places"][i]["photos"].isNotEmpty) {
            // Obtener la referencia de la primera foto (puedes ajustar esto según tus necesidades)
            String photoReference = jsonData["places"][i]["photos"][0]["name"];
            String imageUrl = buildImageUrl(photoReference);
            String name = jsonData["places"][i]["displayName"]["text"];
            print("Nombre: $name");
            setState(() {
              list.add(
                StyleModel(
                  id: (list.length + 1).toString(), // Generar un nuevo ID único
                  url: imageUrl,
                  name: name,
                  description: '',
                  direction: '',
                  schedule: '',
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
        builder: (context) =>
            AboutPlaces(item: list[index], imageUrl: list[index].url),
      ),
    );
  }
}

class AboutPlaces extends StatelessWidget {
  final StyleModel item;
  final String imageUrl;

  AboutPlaces({required this.item, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nombre del museo',
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          //Direccion
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: Color.fromRGBO(58, 172, 255, 1),
                borderRadius: BorderRadius.circular(30.0),
                //agregamos una sombra en la parte inferior
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(
                        168, 131, 131, 131), // Color de la sombra
                    blurRadius: 8.0, // Radio de difuminado
                    spreadRadius: 1.0, // Radio de expansión
                    offset: Offset(0, 0), // Desplazamiento en x y y
                  ),
                ],
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Dirección',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //agregamos un stack
                  Stack(
                    children: [
                      //agregamos un texto en la parte central
                      Positioned(
                        child: Container(
                          height: 98,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(153, 219, 255, 1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'loremp ipsum dolor sit amet, consectetur adipiscing elit. Donec auctor, nisl eget ultricies ultricies, nisl nisl ultr',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //Descripcion
          Positioned(
            top: 190,
            left: 15,
            right: 15,
            child: Container(
              height: 167,
              decoration: BoxDecoration(
                color: Color.fromRGBO(58, 172, 255, 1),
                borderRadius: BorderRadius.circular(30.0),
                //agregamos una sombra en la parte inferior
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(
                        168, 131, 131, 131), // Color de la sombra
                    blurRadius: 8.0, // Radio de difuminado
                    spreadRadius: 1.0, // Radio de expansión
                    offset: Offset(0, 0), // Desplazamiento en x y y
                  ),
                ],
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Descripción',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //agregamos un stack
                  Stack(
                    children: [
                      //agregamos un texto en la parte central
                      Positioned(
                        child: Container(
                          height: 125,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(153, 219, 255, 1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'loremp ipsum dolor sit amet, consectetur adipiscing elit. Donec auctor, nisl eget ultricies ultricies, nisl nisl ultr',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //Horario
          Positioned(
            bottom: 255,
            left: 15,
            right: 15,
            child: Container(
              height: 121,
              decoration: BoxDecoration(
                color: Color.fromRGBO(58, 172, 255, 1),
                borderRadius: BorderRadius.circular(30.0),
                //agregamos una sombra en la parte inferior
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(
                        168, 131, 131, 131), // Color de la sombra
                    blurRadius: 8.0, // Radio de difuminado
                    spreadRadius: 1.0, // Radio de expansión
                    offset: Offset(0, 0), // Desplazamiento en x y y
                  ),
                ],
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Horario',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //agregamos un stack
                  Stack(
                    children: [
                      //agregamos un texto en la parte central
                      Positioned(
                        child: Container(
                          height: 79,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(153, 219, 255, 1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'loremp ipsum dolor sit amet, consectetur adipiscing elit. Donec auctor, nisl eget ultricies ultricies, nisl nisl ultr',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //Galeria
          Positioned(
            bottom: 45,
            left: 15,
            right: 15,
            child: Container(
              height: 181,
              decoration: BoxDecoration(
                color: Color.fromRGBO(58, 172, 255, 1),
                borderRadius: BorderRadius.circular(30.0),
                //agregamos una sombra en la parte inferior
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(
                        168, 131, 131, 131), // Color de la sombra
                    blurRadius: 8.0, // Radio de difuminado
                    spreadRadius: 1.0, // Radio de expansión
                    offset: Offset(0, 0), // Desplazamiento en x y y
                  ),
                ],
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Galeria',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //agregamos un stack
                  Stack(
                    children: [
                      //agregamos un texto en la parte central
                      Positioned(
                        child: Container(
                          height: 144,
                          width: 390.0,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(153, 219, 255, 1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  imageUrl,
                                  height:
                                      130.0, // Usar Image.network para cargar la imagen desde la URL
                                ),
                                // Puedes agregar más detalles según sea necesario
                              ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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
