import 'package:flutter/material.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditButton extends StatefulWidget {
  @override
  _EditButtonState createState() => _EditButtonState();
  
}

class _EditButtonState extends State<EditButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
                //**AutoRouter.of(context).navigate(const EditarFavoritosRoute());
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
            );
  }
}