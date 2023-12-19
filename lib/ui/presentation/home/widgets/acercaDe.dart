import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
// ignore: camel_case_types
class acercaDe extends StatelessWidget {
  const acercaDe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.0,
        centerTitle: true, // Centra el título del AppBar
        title: Text(
          AppLocalizations.of(context)!.homeSidemenuAboutUs,
          style: TextStyle(
            fontSize: 30.0,
            // color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 20.0,
            left: 60, // Ajusta la posición de la imagen
            child: Image.asset('assets/home/logoacercadefinal.png',
                width: 300.0, height: 150.0),
            // Aquí puedes ajustar las propiedades de la imagen
          ),
          Positioned(
            top: 185.0, // Ajusta la posición del título
            left: 155.0,
            child: Text(
              'TRAKNAV',
              style: TextStyle(
                // color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 22.0,
              ),
            ),
          ),
          Positioned(
            left: 148.0,
            top: 220.0,
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                //  color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 22.0,
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 70.0,
            child: Text(
              AppLocalizations.of(context)!.acercaDerechos,
              style: TextStyle(
                // color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 18.0,
              ),
            ),
          ),
          Positioned(
            left: 195.0,
            bottom: 40.0,
            child: Text(
              '2023',
              style: TextStyle(
                //  color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
