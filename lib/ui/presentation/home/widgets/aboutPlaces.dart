import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/presentation/home/widgets/acercaDe.dart';
import 'package:traknav_app/ui/presentation/home/widgets/catalog.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import '../widgets/recomended.dart';
import '../widgets/catalogComercio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AboutPlaces extends StatefulWidget {
  final StyleModel item;
  final String imageUrl;

  AboutPlaces({required this.item, required this.imageUrl});

  @override
  _AboutPlacesState createState() => _AboutPlacesState();
}

class Favoritos {
  List<String> favoritosJaladas;
  Favoritos({required this.favoritosJaladas});
}

class _AboutPlacesState extends State<AboutPlaces> {
  List<String> favoritosJaladas = [];
  Favoritos fav = Favoritos(favoritosJaladas: []);
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getRecommendations(String uid) async {
    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(uid).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      List<String> recommendations = List<String>.from(data['favourites']);
      setState(() {
        favoritosJaladas = recommendations;
        //imprimimos favoritosjalaas
        // print("Lista de favoritos: $recommendations");
        //print(data.toString());
      });
      // print("Lista de favoritos: $recommendations");
    } else {
      print('El documento no existe');
    }
  }

  void imprimirLista() {
    // print(preferenciasJaladas);
    //imprimimos la lista de favoritos
    print("Lista de favoritos: $favoritosJaladas");
  }

  //el nombre del lugar debe ser igual al de la base de datos
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    getCurrentUID().then((uid) async {
      await getRecommendations(uid);
      setState(() {
        isFavorite = favoritosJaladas.contains(widget.item.name);
      });
    });
  }

  Future<String> getCurrentUID() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String uid = user!.uid;
    return uid;
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    imprimirLista();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item.name,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
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
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(168, 131, 131, 131),
                    blurRadius: 8.0,
                    spreadRadius: 1.0,
                    offset: Offset(0, 0),
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
                  Stack(
                    children: [
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
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.item.direction,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17.0,
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
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.item.description,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17.0,
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
            bottom: 275,
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
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.item.schedule,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19.0,
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
            bottom: 75,
            left: 15,
            right: 15,
            child: Container(
              height: 173,
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
                          height: 134,
                          width: 390.0,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(153, 219, 255, 1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  widget.imageUrl,
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
          // Botón de favoritos (corazón)
          Positioned(
            right: 5,
            child: FloatingActionButton(
              onPressed: () async {
                setState(() {
                  isFavorite = !isFavorite;
                });

                User? user = auth.currentUser;
                if (user != null) {
                  String uid = user.uid;
                  if (isFavorite) {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .update({
                      'favourites': FieldValue.arrayUnion([widget.item.name])
                    });
                  } else {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .update({
                      'favourites': FieldValue.arrayRemove([widget.item.name])
                    });
                  }
                }
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
                color: Color.fromRGBO(58, 172, 255, 1),
              ),
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
