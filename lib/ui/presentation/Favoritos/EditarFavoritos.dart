// Se importa el paquete de material design para usar los widgets de flutter
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Se define la clase Favoritos que hereda de StatelessWidget
@RoutePage()
class EditarFavoritosPage extends StatelessWidget {
  //const FavoritosPage({super.key});
  const EditarFavoritosPage({Key? key}) : super(key: key);
  // Se sobreescribe el método build que retorna un widget
  @override
  Widget build(BuildContext context) {
    // Se retorna un widget Scaffold que tiene un color de fondo blanco
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          // Se usa el icono Icons.arrow_back para mostrar una flecha apuntando a la izquierda
          icon: const Icon(Icons.arrow_back),
          // Se usa el color negro para el icono
          color: Colors.black,
          // Se define la acción que se ejecuta al presionar el botón
          onPressed: () {
            AutoRouter.of(context).navigate(const FavoritosRoute());
            // Aquí se puede usar el método Navigator.pop para volver a la pantalla anterior
          },
        ),
        // Se usa el widget Text para mostrar el título "Mis favoritos"
        title: const Text(
          'Mis favoritos',
          // Se usa el estilo TextStyle para darle formato al texto
          style: TextStyle(
            // Se usa el color negro para el texto
            color: Colors.black,
            // Se usa la propiedad fontStyle para poner el texto en cursiva
            fontStyle: FontStyle.italic,
          ),
        ),
        // Se usa el widget Center para centrar el título
        centerTitle: true,
      ),
      // Se usa el widget ListView para crear una lista de widgets
      body: ListView(
        // Se usa el widget Padding para darle un espacio de 30 alrededor de la lista
        padding: const EdgeInsets.all(30),
        // Se usa el widget Column para organizar los widgets verticalmente
        children: [
          // Se usa el widget Container para crear un rectángulo con bordes redondeados
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
                          ElevatedButton.icon(
                            onPressed: () {
                            // Lógica para compartir algo
                            },
                            icon: const Icon(
                              Icons.check_box_outline_blank, // Icono de compartir
                              size: 24.0,
                            ),
                            label: const Text(' '), // Texto al lado del icono
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Color de fondo del botón
                              foregroundColor: Colors.white, // Color de texto del botón
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0), // Forma redondeada del botón
                              ),
                            ),
                          ),
                        
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
                          ElevatedButton.icon(
                            onPressed: () {
                            // Lógica para compartir algo
                            },
                            icon: const Icon(
                              Icons.check_box_outline_blank, // Icono de compartir
                              size: 24.0,
                            ),
                            label: const Text(' '), // Texto al lado del icono
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Color de fondo del botón
                              foregroundColor: Colors.white, // Color de texto del botón
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0), // Forma redondeada del botón
                              ),
                            ),
                          ),
                        
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
                // Aquí se puede usar el método Navigator.push para ir a otra pantalla
              },
              child: const Text(
                'Eliminar Sitios',
                // Se usa el estilo TextStyle para darle formato al texto
                style: TextStyle(
                  // Se usa el color negro para el texto
                  color: Colors.black,
                  // Se usa la propiedad fontWeight para poner el texto en negritas
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