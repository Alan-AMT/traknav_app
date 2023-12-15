import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class WidgetCatalogComercio extends StatefulWidget {
  const WidgetCatalogComercio({Key? key}) : super(key: key);

  @override
  _WidgetCatalogComercioState createState() => _WidgetCatalogComercioState();
}

class _WidgetCatalogComercioState extends State<WidgetCatalogComercio> {
  List<CatalogItem> catalogItems = [];

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
    print("tamanio: ${catalogItems.length}");
    // Body de la solicitud
    Map<String, dynamic> lugares = {
      "includedTypes": [
        "vegan_restaurant",
        "restaurant",
        "mexican_restaurant",
        "ice_cream_shop",
        "coffee_shop",
      ],
      "maxResultCount": 20,
      "locationRestriction": {
        "circle": {
          "center": {"latitude": 19.50478, "longitude": -99.14631},
          "radius": 3000.0
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

    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(lugares),
        headers: headers,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);

        List<CatalogItem> newCatalogItems = [];

        for (var place in jsonData["places"]) {
          if (place["photos"] != null && place["photos"].isNotEmpty) {
            String photoReference = place["photos"][0]["name"];
            CatalogItem catalogItem = CatalogItem(
              place["displayName"]["text"],
              buildImageUrl(photoReference),
            );
            newCatalogItems.add(catalogItem);
          }
        }

        setState(() {
          catalogItems = newCatalogItems;
        });
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

class CatalogItem {
  final String name;
  final String imagePath;

  CatalogItem(this.name, this.imagePath);
}

class CatalogItemWidget extends StatelessWidget {
  final CatalogItem catalogItem;

  const CatalogItemWidget({required this.catalogItem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(catalogItem: catalogItem),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.0),
        child: Card(
          child: Stack(
            children: [
              Image.network(
                catalogItem.imagePath,
                width: double.infinity,
                height: 200.0, // Ajusta la altura según tus necesidades
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                height: 200.0, // Ajusta la altura según tus necesidades
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

class DetailScreen extends StatelessWidget {
  final CatalogItem catalogItem;

  const DetailScreen({required this.catalogItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catalogItem.name),
      ),
      body: Center(
        child: Image.network(
          catalogItem.imagePath,
        ),
      ),
    );
  }
}
