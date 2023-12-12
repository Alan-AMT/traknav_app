import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:traknav_app/ui/presentation/home/widgets/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@RoutePage()
class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      return Scaffold(
        appBar: AppBar(
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
          backgroundColor: state.isLightTheme
              ? const Color.fromRGBO(0, 71, 171, 1)
              : Colors.black,
        ),
        backgroundColor: state.isLightTheme
            ? const Color.fromRGBO(0, 71, 171, 1)
            : Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: height * 0.8,

              //margin: EdgeInsets.symmetric(horizontal: 0),
              child: LayoutBuilder(builder: (context, constraints) {
                double innerHeight = constraints.maxHeight;
                double innerWidth = constraints.maxWidth;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                        //RECTANGULO GRIS
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: innerHeight * 0.9,
                          width: innerWidth,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                              color: Color(0xffd9d9d9)),
                          child: Container(
                            //datos personales
                            //height: 10,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 100),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  40), // Bordes circulares
                            ),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [
                                Container(
                                  child: const Text(
                                    'Enzo Fernandez',
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontFamily: 'Nunito',
                                        color: Colors.black),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  // margin: const EdgeInsets.symmetric(horizontal: 2),
                                  child: const Text(
                                    'Correo electrónico: user@gmail.com',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Nunito',
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  child: const Text(
                                    'De: CDMX, México',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Nunito',
                                        color: Colors.black),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  child: const Text(
                                    'Teléfono: 55-1111-1111',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Nunito',
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  child: const Text(
                                    'Contraseña: *****',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Nunito',
                                        color: Colors.black),
                                  ),
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12)))),
                                    onPressed: () {
                                      AutoRouter.of(context)
                                          .navigate(const EditProfileRoute());
                                    },
                                    child: const Text("Cambiar de usuario"))
                              ],
                              //
                            ),
                          ),
                        )),
                    Positioned(
                      ///IMAGEN DE PERFIL
                      top: 0,
                      left: 0,
                      right: 90,
                      child: Center(
                        child: Container(
                          width: 150,
                          height: 150,
                          child: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/MyProfile/yoyo.JPG'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 400,
                        left: 280,
                        right: 0,
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Editar',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.black,
                                fontSize: 27,
                                fontFamily: 'Nunito',
                                color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.black,
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
