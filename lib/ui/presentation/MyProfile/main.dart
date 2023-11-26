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
          backgroundColor: const Color.fromARGB(0, 71, 171, 1),
        ),
      ),
      backgroundColor: const Color.fromRGBO(0, 71, 171, 1),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 1000,
          child: Stack(
            children: [
              // Rectángulo
              Positioned(
                top: 100,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 800,
                  decoration: BoxDecoration(
                    color: const Color(0xffd9d9d9),
                    borderRadius:
                        BorderRadius.circular(45), // Bordes rectangulares
                  ),
                ),
              ),

              // Imagen con borde circular
              Positioned(
                top: MediaQuery.of(context).size.width * 0.08,
                left: MediaQuery.of(context).size.width * 0.1,
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
                    backgroundImage: AssetImage('assets/MyProfile/yoyo.JPG'),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.width * 0.6,
                left: MediaQuery.of(context).size.width * 0.08,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.9,
                        left: MediaQuery.of(context).size.width * 0.6,
                        child: const Text(
                          'Enzo Fernandez',
                          style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'Nunito',
                              color: Colors.black),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.6,
                        left: MediaQuery.of(context).size.width * 0.6,
                        child: const Text(
                          'Correo electrónico: user@gmail.com',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Nunito',
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.6,
                        left: MediaQuery.of(context).size.width * 0.6,
                        child: const Text(
                          'De: CDMX, México',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Nunito',
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.6,
                        left: MediaQuery.of(context).size.width * 0.6,
                        child: const Text(
                          'Teléfono: 55-1111-1111',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Nunito',
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.6,
                        left: MediaQuery.of(context).size.width * 0.6,
                        child: const Text(
                          'Contraseña: *************',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Nunito',
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.width * 0.266,
                right: MediaQuery.of(context).size.width * 0.13,
                child: const Text(
                  'Editar',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 25,
                  ),
                ),
              ),

              // IconButton
              Positioned(
                top: MediaQuery.of(context).size.width * 0.25,
                right: MediaQuery.of(context).size.width * 0.004,
                child: IconButton(
                  icon: const Icon(Icons.edit_note),
                  color: Colors.black,
                  iconSize: 40,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
