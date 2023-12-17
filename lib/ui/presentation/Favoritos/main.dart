// Se importa el paquete de material design para usar los widgets de flutter
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'modelo.dart';
import 'widgets/botonCompartir.dart';

// Se define la clase Favoritos que hereda de StatelessWidget
@RoutePage()
class FavoritosPage extends StatefulWidget {
  const FavoritosPage({Key? key}) : super(key: key);

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            AutoRouter.of(context).navigate(const HomeRoute());
          },
        ),
        title: const Text(
          'Mis favoritos',
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          Container(
            decoration: BoxDecoration(
              // Se usa el widget BorderRadius.circular para darle un radio de 15 a los bordes
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 58, 172, 255),
            ),
            // Se usa el widget Padding para darle un espacio de 20 por la izquierda y derecha al contenido del rectángulo
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: 
                    Expanded(
                      child:
                        Column( 
                          mainAxisAlignment: MainAxisAlignment.center, 
                          children: [ 
                            InkWell( onTap: () { 
                              // Aquí se define la acción que se ejecuta al presionar el botón 
                            }, 
                            child: 
                              Image.asset('assets/signin/bg1.png', 
                              width: MediaQuery.of(context).size.width * 1,), 
                            ), 
                        
                          Container(
                            //width: MediaQuery.of(context).size.width * 1,
                            //height: MediaQuery.of(context).size.height * 0.83,
                            decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 58, 172, 255),
            
                            borderRadius: BorderRadius.circular(20),
                            ),
                          
                            child: 
                              const Center( 
                                child: 
                                Column( 
                                  children: [
                                    Text("Hotel la Ruta", style: 
                                      TextStyle(color: Colors.white,
                                      fontSize:17,
                                      fontWeight: FontWeight.bold,
                                      ), 
                                    ),
                                  ]
                                ),
                              ),
                          ),
                          MyButton(),
                        
                          ], 
                        ),
                    
                    ),
        
          ),

          const SizedBox(
            height: 20,
            //width: 100,
          ),

          Container(
            // Se usa el widget BoxDecoration para darle estilo al rectángulo
            decoration: BoxDecoration(
              // Se usa el widget BorderRadius.circular para darle un radio de 15 a los bordes
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 58, 172, 255),
            ),
            // Se usa el widget Padding para darle un espacio de 20 por la izquierda y derecha al contenido del rectángulo
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: 
                    Expanded(
                      child:
                        Column( 
                          mainAxisAlignment: MainAxisAlignment.center, 
                          children: [ 
                            InkWell( onTap: () { 
                              // Aquí se define la acción que se ejecuta al presionar el botón 
                            }, 
                            child: 
                              Image.asset('assets/signin/bg1.png', 
                              width: MediaQuery.of(context).size.width * 1,), 
                            ), 
                        
                          Container(
                            //width: MediaQuery.of(context).size.width * 1,
                            //height: MediaQuery.of(context).size.height * 0.83,
                            decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 58, 172, 255),
            
                            borderRadius: BorderRadius.circular(20),
                            ),
                          
                            child: 
                              const Center( 
                                child: 
                                Column( 
                                  children: [
                                    Text("Hotel la Ruta", style: 
                                      TextStyle(color: Colors.white,
                                      fontSize:17,
                                      fontWeight: FontWeight.bold,
                                      ), 
                                    ),
                                  ]
                                ),
                              ),
                          ),
                          
                          MyButton(),
                          ], 
                        ),
                    
                    ),
        
          ),
          // Se usa el widget SizedBox para darle un espacio de 20 entre el rectángulo y el botón
          const SizedBox(
            height: 20,
            //width: 100,
          ),
          // Se usa el widget Center para centrar el botón
          Center(
            // Se usa el widget ElevatedButton para crear el botón llamado "Editar sitios"
            child: ElevatedButton(
              style: ButtonStyle(
                // Se usa el color azul claro para el fondo del botón
                backgroundColor: MaterialStateProperty.all(Colors.blue[100]),
                // Se usa el widget RoundedRectangleBorder para darle bordes redondeados al botón
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    // Se usa el widget BorderRadius.circular para darle un radio de 15 a los bordes
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              // Se define la acción que se ejecuta al presionar el botón
              onPressed: () {
                AutoRouter.of(context).navigate(const EditarFavoritosRoute());
                // Aquí se puede usar el método Navigator.push para ir a otra pantalla
              },
              child: const Text(
                'Editar sitios',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


