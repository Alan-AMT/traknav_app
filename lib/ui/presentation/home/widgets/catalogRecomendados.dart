import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:traknav_app/ui/presentation/home/widgets/aboutPlaces.dart';
import 'package:traknav_app/ui/presentation/home/widgets/recomended.dart';

class WidgetCatalogRecomendados extends StatefulWidget {
  const WidgetCatalogRecomendados({Key? key}) : super(key: key);

  @override
  _WidgetCatalogRecomendadosState createState() =>
      _WidgetCatalogRecomendadosState();
}

class Preferencias {
  List<int> preferenciasJaladas;
  Preferencias({required this.preferenciasJaladas});
}

class _WidgetCatalogRecomendadosState extends State<WidgetCatalogRecomendados> {
  List<StyleModel> catalogItems = [];
  List<int> preferenciasJaladas = [];
  Map<int, List<String>> tablaHash = {
    1: ['park', 'restaurant', 'hotel'],
    2: ['performing_arts_theater', 'art_gallery'],
    3: ['mexican_restaurant', 'fast_food_restaurant'],
    4: ['mexican_restaurant', 'ice_cream_shop'],
    5: ['church', 'museum'],
    6: ['lodging', 'resort_hotel'],
    7: ['dog_park', 'zoo'],
    8: ['national_park', 'historical_landmark'],
  };

  Preferencias preferencias = Preferencias(preferenciasJaladas: []);
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getRecommendations(String uid) async {
    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(uid).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      List<int> recommendations = data['recommendations'].cast<int>();
      setState(() {
        preferenciasJaladas = [...recommendations];
        // print(recommendations);
        //print(data.toString());
      });
    } else {
      print('El documento no existe');
    }
  }

  void imprimirLista() {
    print(preferenciasJaladas);
  }

  Future<LocationData?> _getLocation() async {
    final bool hasPermission = await checkPermissions();
    if (!hasPermission) return null;
    Location location = Location();
    return await location.getLocation();
  }

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
    _getLocation().then((position) async {
      await fetchData(position);
      getCurrentUID().then((uid) async {
        await getRecommendations(uid);
      });
    });
  }

  Future<String> getCurrentUID() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String uid = user!.uid;
    return uid;
  }

  Future<void> fetchData(LocationData? location) async {
    // Obtener los tipos de lugares correspondientes a las preferenciasJaladas
    List<String> tiposDeLugares = [];
    preferenciasJaladas.forEach((id) {
      if (tablaHash.containsKey(id)) {
        tiposDeLugares.addAll(tablaHash[id]!);
      }
    });
    String url = 'https://places.googleapis.com/v1/places:searchNearby';
    Map<String, dynamic> lugares = {
      "includedTypes": tiposDeLugares, // Usar la lista de tipos obtenida
      "maxResultCount": 20,
      "locationRestriction": {
        "circle": {
          "center": {
            "latitude": location?.latitude,
            "longitude": location?.longitude
          },
          "radius": 3000.0
        }
      }
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s',
      'X-Goog-FieldMask':
          'places.id,places.displayName,places.photos,places.regularOpeningHours,places.shortFormattedAddress,places.editorialSummary',
    };
    print("Hola estas en catalogRecomendados.dart");
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(lugares),
        headers: headers,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        print('Datos obtenidos correctamente: $jsonData');
        // Iterar sobre los lugares en jsonData
        for (int i = 0; i < jsonData["places"].length; i++) {
          // Asegurarse de que haya fotos disponibles
          if (jsonData["places"][i]["photos"] != null &&
              jsonData["places"][i]["photos"].isNotEmpty) {
            // Obtener la referencia de la primera foto (puedes ajustar esto según tus necesidades)
            String photoReference = jsonData["places"][i]["photos"][0]["name"];
            String imageUrl = buildImageUrl(photoReference);

            // Verifica si "displayName" es de tipo String antes de asignarlo a name
            String name = jsonData["places"][i]["displayName"]?["text"] ??
                "Nombre no disponible";

            String openingHours;

            if (jsonData["places"][i]["regularOpeningHours"] != null &&
                jsonData["places"][i]["regularOpeningHours"]["periods"] !=
                    null &&
                jsonData["places"][i]["regularOpeningHours"]["periods"]
                    .isNotEmpty &&
                jsonData["places"][i]["regularOpeningHours"]["periods"][0]
                        ["open"] !=
                    null &&
                jsonData["places"][i]["regularOpeningHours"]["periods"][0]
                        ["close"] !=
                    null) {
              openingHours =
                  "Abierto de ${jsonData["places"][i]["regularOpeningHours"]["periods"][0]["open"]["hour"]} a ${jsonData["places"][i]["regularOpeningHours"]["periods"][0]["close"]["hour"]}";
            } else {
              openingHours = "No hay horario disponible";
            }
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
              catalogItems.add(
                StyleModel(
                  id: (catalogItems.length + 1)
                      .toString(), // Generar un nuevo ID único
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
              //imprimimos el tamaño de la lista
              print("tamanio: ${catalogItems.length}");
            });
          }
        }
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String buildImageUrl(String photoReference) {
    const String apiKey = 'AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s';
    return 'https://places.googleapis.com/v1/$photoReference/media?maxHeightPx=400&maxWidthPx=400&key=$apiKey';
  }

  @override
  Widget build(BuildContext context) {
    imprimirLista();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.homeRecomendedTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 18.0,
          ),
          itemCount: catalogItems.length,
          itemBuilder: (context, index) {
            return CatalogItemWidget(catalogItem: catalogItems[index]);
          },
        ),
      ),
    );
  }
}

class CatalogItemWidget extends StatelessWidget {
  final StyleModel catalogItem;

  const CatalogItemWidget({required this.catalogItem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _navigateToDetailPage(context, catalogItem);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.0),
        child: Card(
          child: Stack(
            children: [
              Image.network(
                catalogItem.url,
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 2),
                  child: Container(
                    color: Color.fromARGB(68, 0, 0, 0),
                  ),
                ),
              ),
              Positioned(
                left: 10.0,
                bottom: 30,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    catalogItem.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _navigateToDetailPage(BuildContext context, StyleModel catalogItem) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AboutPlaces(
        item: catalogItem,
        imageUrl: catalogItem.url,
        // Agrega valores adicionales según sea necesario
      ),
    ),
  );
}
