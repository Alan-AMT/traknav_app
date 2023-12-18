import 'package:flutter/material.dart';
import 'botonCompartir.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';

class SitioFavorito extends StatefulWidget {
  @override
  final String nombre;
  
  SitioFavorito({
    Key? key,
    required this.nombre
  }) : super(key: key);
  _SitioFavoritoState createState() => _SitioFavoritoState();
}
class _SitioFavoritoState extends State<SitioFavorito> {
  Future<PlacesSearchResult> obtenerDatos() async {
    GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: 'AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s');
    PlacesSearchResponse response = await places.searchByText(widget.nombre);
    PlacesSearchResult result = response.results.first;
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PlacesSearchResult>(
      future: obtenerDatos(),
      builder: (context, snapshot) {
      // Si los datos aún no están listos, muestra un indicador de carga
      if (!snapshot.hasData) {
        return Center(child: CircularProgressIndicator());
      }
      PlacesSearchResult? result;
      result = snapshot.data;
      String idPlace = result!.placeId;
      String nombrePlace = result!.name;
      String? direccion = result!.formattedAddress;
      num? rating = result!.rating;
      bool? estaAbierto = result!.openingHours?.openNow;
      Photo photo= result!.photos.first;
      String photoReference = photo.photoReference;
      String photoUrl =  'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s';
      return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return Column(
        children:[ 
          Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 58, 172, 255),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: 
                        Expanded(
                          child:
                            Column( 
                              mainAxisAlignment: MainAxisAlignment.center, 
                              children: [ 
                              Container(
                                decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 58, 172, 255),
                                borderRadius: BorderRadius.circular(20),
                                ),
                                child: 
                                  Column( 
                                    children: [
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Image.network(
                                        photoUrl, 
                                        height: MediaQuery.of(context).size.width * 0.55),
                                      Text(nombrePlace, style: 
                                        TextStyle(color: Colors.white,
                                        fontSize:20,
                                        fontWeight: FontWeight.bold,
                                        ), 
                                      ),
                                      Text(direccion!, style: 
                                        TextStyle(color: Colors.white,
                                        fontSize:17,
                                        fontWeight: FontWeight.bold,
                                        ), 
                                      ),
                                      Row(
                                        children: [
                                          Text(rating.toString(), style: 
                                            TextStyle(color: Colors.white,
                                            fontSize:17,
                                            fontWeight: FontWeight.bold,
                                            ), 
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 24.0,
                                          ),
                                        ],
                                      ),
                                      Text(
                                       estaAbierto == null ? AppLocalizations.of(context)!.unknown : estaAbierto ? AppLocalizations.of(context)!.opened : AppLocalizations.of(context)!.closed,
                                        style: 
                                        TextStyle(
                                          //color: Colors.white,
                                        fontSize:17,
                                        fontWeight: FontWeight.bold,
                                        ), 
                                      ),
                                    ]
                                  ),
                              ),
                              MyButton(nombre: nombrePlace),
                              ], 
                            ),
                        ),),
              const SizedBox(
              height: 5,
            ),
            ]
            );}
      );
      }
      );
      }
      }
