import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class CreateTripPlanPage extends StatelessWidget {
  const CreateTripPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Plan de viaje',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontStyle: FontStyle.italic,
              fontSize: 30,
              //color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
            color: Colors.black,
          ),
          backgroundColor: state.isLightTheme
              ? Colors.white
              : const Color.fromRGBO(13, 71, 161, 1),
        ),
        //backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        //
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            decoration: BoxDecoration(
              color: Colors.blue, // Rectángulo azul
              borderRadius: BorderRadius.circular(20), // Bordes circulares
            ),
            child: Column(
              children: [
                Container(
                  //barra busqueda
                  height: 40,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(20), // Bordes circulares
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        color: Colors.black,
                        onPressed: () {},
                      ),
                      const Text(
                        '¿A dónde vamos?',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      IconButton(
                        icon: const Icon(Icons.filter_alt),
                        color: Colors.black,
                        onPressed: () {
                          AutoRouter.of(context)
                              .navigate(const SearchPlacesRoute());
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(20), // Bordes circulares
                  ),
                  child: const Center(
                    child: TextField(
                      keyboardType: TextInputType.number, // Teclado numérico
                      decoration: InputDecoration(
                        hintText: '¿Por cuántos días?',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        border:
                            InputBorder.none, // Elimina el borde predeterminado
                        contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            //BOTON SIGUIENTE
            height: 40,
            width: 200,
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xff99DBFF),
              borderRadius: BorderRadius.circular(20), // Bordes circulares
            ),
            child: TextButton(
              onPressed: () {
                AutoRouter.of(context).navigate(const TripPlanCreatedRoute());
              },
              child: const Text(
                'Siguiente',
                style: TextStyle(
                  color: Color.fromARGB(255, 2, 0, 0),
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ]),
      );
    });
  }
}
