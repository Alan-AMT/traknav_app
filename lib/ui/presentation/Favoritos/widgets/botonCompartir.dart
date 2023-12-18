import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Importa el paquete google_maps_webservice
import 'package:google_maps_webservice/places.dart';

// Define una función que recibe el id del lugar y devuelve el link de Google Maps
Future<String> obtenerLinkGoogleMaps(String placeId) async {
  // Crea una instancia de GoogleMapsPlaces con tu clave de API
  GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: 'AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s');

  // Busca el lugar por su id y obtén el resultado
  /*PlacesDetailsResponse response = await places.getDetailsByPlaceId(placeId);
  PlacesDetailsResult result = response.result;*/
  PlacesSearchResponse response = await places.searchByText(placeId);
  PlacesSearchResult result = response.results.first;
  // Obtiene el nombre y las coordenadas del lugar
  String name = result.name;
  double lat = result.geometry!.location.lat;
  double lng = result.geometry!.location.lng;

  // Codifica el nombre para usarlo en la URL
  String nameEncoded = Uri.encodeComponent(name);

  // Construye el link de Google Maps usando el esquema de URL
  // Puedes consultar la documentación para más opciones
  // [Documentación de Google Maps URL](https://codelabs.developers.google.com/codelabs/google-maps-in-flutter/)
  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$nameEncoded&query_place_id=$placeId';

  // Devuelve el link
  return googleUrl;
}


class MyButton extends StatefulWidget {
  final String nombre;
  MyButton({
    Key? key,
    //required this.id, 
    //required this.foto,
    required this.nombre
  }) : super(key: key);
  @override
  _MyButtonState createState() => _MyButtonState();
  
}

class _MyButtonState extends State<MyButton> {
  
  bool _showMenu = false;

  void _toggleMenu() {
    setState(() {
      _showMenu = !_showMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
           // _toggleMenu;
            String placeId = widget.nombre;//'ChIJN1t_tDeuEmsRUsoyG83frY4'
            // Llama a la función obtenerLinkGoogleMaps y guarda el resultado
            String googleUrl = await obtenerLinkGoogleMaps(placeId);
            // Copia el resultado al portapapeles usando Clipboard.setData
            Clipboard.setData(ClipboardData(text: googleUrl)).then((_) {
              // Muestra un mensaje al usuario usando ScaffoldMessenger.of(context).showSnackBar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.copiedToClipboard),
                ),
              );
            });
          },
          label:Text(AppLocalizations.of(context)!.shareButton), 
          icon: const Icon(
                              Icons.share, // Icono de compartir
                              size: 24.0,
                            ),
          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Color de fondo del botón
                              foregroundColor: Colors.white, // Color de texto del botón
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0), // Forma redondeada del botón
                              ),
                            ),
          //child: const Text('Compartir'),
        ),
        
        /*AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _showMenu ? MediaQuery.of(context).size.height / 6 : 0,
          child: _showMenu
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.link),
                    Image.asset('assets/favoritos/facebook.jpg', 
                      width: MediaQuery.of(context).size.width * 0.1,),
                    Image.asset('assets/favoritos/whatsapp.png', 
                      width: MediaQuery.of(context).size.width * 0.1,),
                    Image.asset('assets/favoritos/instagram.png', 
                      width: MediaQuery.of(context).size.width * 0.1,),
                  ],
                )
              : null,
        ),*/
      ],
    );
  }
}