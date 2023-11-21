import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:traknav_app/ui/presentation/home/widgets/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

@RoutePage()
class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            'Mi Cuenta',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontStyle: FontStyle.italic,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              AutoRouter.of(context).navigate(const HomeRoute());
            },
            color: Colors.white,
          ),
          backgroundColor: const Color.fromARGB(255, 18, 103, 173),
        ),
      ),
      backgroundColor: const Color.fromRGBO(8, 88, 153, 1),
      body: Stack(
        children: [
          // Fondo de color sólido
          Container(
            color: const Color.fromARGB(255, 18, 103, 173),
            width: double.infinity,
            height: double.infinity,
          ),

          // Rectángulo
          Positioned(
            top: 100,
            left: 0,
            child: Container(
              width: 360,
              height: 550,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 161, 156, 156),
                borderRadius: BorderRadius.circular(20), // Bordes rectangulares
              ),
            ),
          ),

          // Imagen con borde circular
          Positioned(
            top: 30,
            left: 30,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              child: const CircleAvatar(
                backgroundImage:
                    NetworkImage('https://picsum.photos/250?image=2'),
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: 20,
            child: Container(
              width: 317,
              height: 300,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Enzo Fernandez',
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Nunito',
                        color: Colors.black),
                  ),
                  Text(
                    'Correo electrónico: user@gmail.com',
                    style: TextStyle(fontFamily: 'Nunito', color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'De: CDMX, México',
                    style: TextStyle(fontFamily: 'Nunito', color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Teléfono: 55-1111-1111',
                    style: TextStyle(fontFamily: 'Nunito', color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Contraseña: *************',
                    style: TextStyle(fontFamily: 'Nunito', color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 105,
            right: 50,
            child: Text(
              'Editar',
              style: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),

          // IconButton
          Positioned(
            top: 100,
            right: -1,
            child: IconButton(
              icon: const Icon(Icons.edit_note),
              iconSize: 40,
              onPressed: () {
                // Acción a realizar cuando se presiona el IconButton
              },
            ),
          ),
        ],
      ),
    );
  }
}
