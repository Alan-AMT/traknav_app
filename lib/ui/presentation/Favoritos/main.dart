// Se importa el paquete de material design para usar los widgets de flutter
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Se define la clase Favoritos que hereda de StatelessWidget
@RoutePage()
class FavoritosPage extends StatelessWidget {
  //const FavoritosPage({super.key});
  const FavoritosPage({Key? key}) : super(key: key);
  // Se sobreescribe el método build que retorna un widget
  @override
  Widget build(BuildContext context) {
    // Se retorna un widget Scaffold que tiene un color de fondo blanco
    return Scaffold(
      backgroundColor: Colors.white,
      // Se usa el widget AppBar para mostrar el botón de navegación y el título
      appBar: AppBar(
        // Se usa el color blanco para el fondo del AppBar
        backgroundColor: Colors.white,
        // Se usa el widget IconButton para crear el botón de navegación con forma de flecha
        leading: IconButton(
          // Se usa el icono Icons.arrow_back para mostrar una flecha apuntando a la izquierda
          icon: const Icon(Icons.arrow_back),
          // Se usa el color negro para el icono
          color: Colors.black,
          // Se define la acción que se ejecuta al presionar el botón
          onPressed: () {
            AutoRouter.of(context).navigate(const HomeRoute());
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
              borderRadius: BorderRadius.circular(15),
            ),
            // Se usa el widget Padding para darle un espacio de 20 por la izquierda y derecha al contenido del rectángulo
            padding: const EdgeInsets.symmetric(horizontal: 20),
            // Se usa el widget Stack para crear una pila de widgets
            child: Stack(
              // Se usa el widget Image.asset para mostrar una imagen
              children: [
                Image.asset(
                  // Se usa el nombre del archivo de la imagen que se quiere mostrar
                  'assets/Hospedaje.jpg',
                  // Se usa el widget BoxFit.cover para que la imagen cubra todo el espacio disponible
                  fit: BoxFit.cover,
                ),
                // Se usa el widget Align para alinear el texto en la parte inferior de la imagen
                Align(
                  // Se usa el widget Alignment.bottomCenter para centrar el texto en la parte inferior
                  alignment: Alignment.bottomCenter,
                  // Se usa el widget Container para crear un fondo de color azul fuerte para el texto
                  child: Container(
                    // Se usa el widget BoxDecoration para darle estilo al fondo
                    decoration: BoxDecoration(
                      // Se usa el color azul fuerte para el fondo
                      color: Colors.blue[900],
                    ),
                    // Se usa el widget Padding para darle un espacio de 10 al texto
                    padding: const EdgeInsets.all(10),
                    // Se usa el widget Text para mostrar el texto
                    child: const Text(
                      // Se usa el texto que se quiere mostrar
                      'Este es el texto',
                      // Se usa el estilo TextStyle para darle formato al texto
                      style: TextStyle(
                        // Se usa el color blanco para el texto
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Se usa el widget SizedBox para darle un espacio de 20 entre el rectángulo y el botón
          const SizedBox(height: 20),
          // Se usa el widget Center para centrar el botón
          Center(
            // Se usa el widget ElevatedButton para crear el botón llamado "Editar sitios"
            child: ElevatedButton(
              // Se usa el widget Text para mostrar el texto del botón
              
              // Se usa el widget ButtonStyle para darle estilo al botón
              style: ButtonStyle(
                // Se usa el color azul claro para el fondo del botón
                backgroundColor: MaterialStateProperty.all(Colors.blue[100]),
                // Se usa el widget RoundedRectangleBorder para darle bordes redondeados al botón
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    // Se usa el widget BorderRadius.circular para darle un radio de 15 a los bordes
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              // Se define la acción que se ejecuta al presionar el botón
              onPressed: () {
                // Aquí se puede usar el método Navigator.push para ir a otra pantalla
              },
              child: const Text(
                'Editar sitios',
                // Se usa el estilo TextStyle para darle formato al texto
                style: TextStyle(
                  // Se usa el color negro para el texto
                  color: Colors.black,
                  // Se usa la propiedad fontWeight para poner el texto en negritas
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
