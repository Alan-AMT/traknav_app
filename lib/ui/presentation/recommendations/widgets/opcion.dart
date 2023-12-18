import 'package:flutter/material.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import "../widgets/omitir.dart";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:traknav_app/ui/config/toasts/main.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Preferencias {
  List<int> preferenciasSeleccionadas = [];
}

class Categoria {
  int id;
  String nombre;
  String foto;
  bool? estaSeleccionado = false;
  Categoria(this.id, this.nombre, this.foto, this.estaSeleccionado);
}

class BotonOpcion extends StatefulWidget {
  const BotonOpcion({super.key});

  @override
  State<BotonOpcion> createState() => _BotonOpcionState();
}

class _BotonOpcionState extends State<BotonOpcion> {
  @override
  FirebaseAuth auth = FirebaseAuth.instance;
  final opciones = [
    //**Volver a coloca AppLocalizations...
    Categoria(
        //AppLocalizations.of(context)!.recPopular
          1, "recPopular", "Sitios_populares.png",false),
      Categoria(2, "recMuseum", "Museos.png",false),
      Categoria(
          3, "recRestaurants", "Restaurantes.png",false),
      Categoria(4, "recLocalCommerce",
          "Comercio_local.png",false),
      Categoria(5, "recHistorical",
          "Patrimonio_historico.png",false),
      Categoria(6, "recLodgment", "Hospedaje.png",false),
      Categoria(7, "recParks", "Parques.png",false),
      Categoria(
          8, "recGuided", "Visitas_guiadas.png",false),
    ];

  Preferencias prefs = Preferencias();

  void agregarPreferencias() {
    if (prefs.preferenciasSeleccionadas.isEmpty == false) {
      prefs.preferenciasSeleccionadas.clear();
    }
    for (var opcion in opciones) {
      if (opcion.estaSeleccionado == true) {
        prefs.preferenciasSeleccionadas.add(opcion.id);
      }
    }
  }

  void mostrarPreferencias() {
    debugPrint(prefs.preferenciasSeleccionadas.toString());
  }

  int countSelected() {
    int count = 0;
    for (var opcion in opciones) {
      if (opcion.estaSeleccionado == true) {
        count++;
      }
    }
    return count;
  }

  void toggleCategoria(int index) {
    setState(() {
      if (opciones[index].estaSeleccionado!) {
        opciones[index].estaSeleccionado = false;
      } else {
        if (countSelected() < 3) {
          opciones[index].estaSeleccionado = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final nombres = [
      //**Volver a coloca AppLocalizations...
      AppLocalizations.of(context)!.recPopular,
      AppLocalizations.of(context)!.recMuseum,
      AppLocalizations.of(context)!.recRestaurants,
      AppLocalizations.of(context)!.recLocalCommerce,
      AppLocalizations.of(context)!.recHistorical,
      AppLocalizations.of(context)!.recLodgment,
      AppLocalizations.of(context)!.recParks,
      AppLocalizations.of(context)!.recGuided,
    ];
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Column(children: [
        Center(
          child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.79,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 58, 172, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(children: [
                Expanded(
                    child: GridView.builder(
                        itemCount: opciones.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Cambiar el estado al opuesto cada vez que se toca el Container
                              setState(() {
                                toggleCategoria(index);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: opciones[index].estaSeleccionado!
                                      ? Colors.blue[700]
                                      : const Color.fromARGB(
                                          180, 230, 230, 230),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/${opciones[index].foto}',
                                      width: 100),
                                  Text(
                                    nombres[index],
                                    style: TextStyle(
                                      color: opciones[index].estaSeleccionado!
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }))),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                          countSelected().toString() +
                              '/3 ' +
                              AppLocalizations.of(context)!.recSelected,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize)),

                      //Expanded(child:
                    ),
                    Expanded(
                        flex: 4,
                        child: ElevatedButton(
                          /*onPressed: () async {
                    agregarPreferencias();
                    mostrarPreferencias();
                      await onFormSent(context);
                    },
                    */
                          onPressed: () async {
                            agregarPreferencias();
                            mostrarPreferencias();

                            User? user = auth.currentUser;
                            if (user != null) {
                              String uid = user.uid;
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .update({
                                'recommendations':
                                    prefs.preferenciasSeleccionadas
                              });
                            }
                            AutoRouter.of(context).navigate(const HomeRoute());
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          child: Text(
                              AppLocalizations.of(context)!.recNextButton,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .fontSize)),
                        )),

                    //)
                  ],
                ),
              ])),
        ),
        const ButtonOmitir(),
      ]);
    });
  }
}
