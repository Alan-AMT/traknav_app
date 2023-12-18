// Se importa el paquete de material design para usar los widgets de flutter
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'modelo.dart';
import 'widgets/botonCompartir.dart';
import 'widgets/diseñoSitio.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_webservice/places.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';

FirebaseAuth auth = FirebaseAuth.instance;
User? user = auth.currentUser;
String uid = user!.uid;

FirebaseFirestore firestore = FirebaseFirestore.instance;
DocumentReference docRef = firestore.collection('users').doc(uid);

Future<List<String>> obtenerFavourites() async {
  // Obtiene el documento y comprueba si existe
  DocumentSnapshot docSnap = await docRef.get();
  if (docSnap.exists) {
    // Obtiene el campo favourites como una lista de enteros
    List<String> favourites = List<String>.from(docSnap.get('favourites'));
    // Devuelve la lista de favourites
    return favourites;
  } else {
    // Muestra un mensaje de error al usuario
    print('El documento del usuario no existe');
    // Devuelve una lista vacía
    return [];
  }
}

// Se define la clase Favoritos que hereda de StatelessWidget
@RoutePage()
class FavoritosPage extends StatefulWidget {
  const FavoritosPage({Key? key}) : super(key: key);

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {

  List<String> listaFea = [];

  // Define una función que se ejecuta cuando se inicializa el estado del widget
  @override
  void initState() {
    super.initState();
    // Llama a la función obtenerFavourites y actualiza el estado con los datos obtenidos
    obtenerFavourites().then((value) {
      setState(() {
        listaFea = value;
      });
    });
  }
/*
  List<String> listaFea = [
      'Chapultepec',
      'Bellas Artes',
      'ESCOM',
    ];*/
  
  
  @override
  Widget build(BuildContext context) {
    void eliminarSitio(String sitio) {
    setState(() async{
      setState(() {
     listaFea.remove(sitio);
    });
      //listaFea.remove(sitio);
      await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .update({
                      'favourites': FieldValue.arrayRemove([sitio])});
    });
  }
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
        //backgroundColor: Colors.white,
        appBar: AppBar(
          //backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            //color: Colors.black,
            onPressed: () {
              AutoRouter.of(context).navigate(const HomeRoute());
            },
          ),
          title: Text(
            AppLocalizations.of(context)!.myFavorites,
            style: TextStyle(
              //color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
        ),
        body: 
          ListView.builder(
            padding: const EdgeInsets.all(30),
            itemCount: listaFea.length, // El número de elementos de la listaFea
            itemBuilder: (context, index) {
              String sitio = listaFea[index];
                return Column(
                  children:[
                    SitioFavorito(
                      //id: 1,
                      //foto: 'assets/favoritos/whatsapp.png',
                      nombre: sitio
                    ),
                    ElevatedButton(
                      onPressed: () {// Llamar a la función eliminarSitio con el valor del elemento de la listaFea
                        eliminarSitio(sitio);
                      },
                      child: Text(AppLocalizations.of(context)!.deleteSite), // El texto del botón
                    ),
                  ]
                );
            },
          ),
      );
    }
    );
  }
}
          /*Center(
            // Se usa el widget ElevatedButton para crear el botón llamado "Editar sitios"
            child: EditButton()
          ),*/