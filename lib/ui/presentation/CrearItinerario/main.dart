import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class CreateTripPlanPage extends StatelessWidget {
  const CreateTripPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Plan de viaje',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontStyle: FontStyle.italic,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        //backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 900,
            child: Stack(
              children: [
                // Rectángulo azul
                Positioned(
                  top: MediaQuery.of(context).size.width * 0.08,
                  left: MediaQuery.of(context).size.width * 0.09,
                  child: Container(
                    width: 290,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.blue, // Rectángulo azul
                      borderRadius:
                          BorderRadius.circular(20), // Bordes circulares
                    ),
                  ),
                ),

                // Espacio blanco rectangular con iconos
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.07,
                  left: MediaQuery.of(context).size.width * 0.15,
                  child: Container(
                    width: 250,
                    height: 40,
                    margin: const EdgeInsets.symmetric(vertical: 10),
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
                          onPressed: () {},
                        ),
                        const Text(
                          '¿A dónde vamos?',
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(Icons.filter_alt),
                          onPressed: () {
                            AutoRouter.of(context)
                                .navigate(const SearchPlacesRoute());
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Espacio blanco rectangular para números con borde circular
                Positioned(
                  top: MediaQuery.of(context).size.height *
                      0.155, // Ajusta la posición vertical
                  left: MediaQuery.of(context).size.width * 0.15,
                  child: Container(
                    width: 250,
                    height: 40,
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
                          border: InputBorder
                              .none, // Elimina el borde predeterminado
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          BorderRadius.circular(40), // Bordes redondos
                    ),
                    child: TextButton(
                      onPressed: () {
                        AutoRouter.of(context)
                            .navigate(const TripPlanCreatedRoute());
                      },
                      child: const Text(
                        'Siguiente',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
