//Descomentar todo lo que tenga **

import 'package:flutter/material.dart';
import "widgets/opcion.dart";
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:auto_route/auto_route.dart';


@RoutePage()
class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            const Color.fromARGB(255, 255, 255, 255), //rgb(58, 172, 255).
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
        
            title: 
            //const Padding(
              //padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),child: 
              const Text('¡Hola!', style: TextStyle(
                  color: Colors.black, // Establece el color de texto deseado
                ),
              ),
            
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: Center(
             child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    //padding: EdgeInsets.only(all: 8.0),
                    padding: EdgeInsets.fromLTRB(38.0, 0.0, 38.0, 4.0),
                    child: Text(
                      'Para personalizar tus recomendaciones de manera óptima, ¡cuéntanos un poco sobre tus gustos e intereses en viajes!',
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black,
                      
                    ),
                  ),
                  ),
                ],
              ),
          ),
        ),
        ),
        body: 
          const BotonOpcion()
      );
  }
}