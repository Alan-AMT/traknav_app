import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/Clima/modelo.dart';
import 'package:traknav_app/ui/presentation/Clima/climaHoy.dart';
import 'package:traknav_app/ui/presentation/Clima/pronostico.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Cuerpo extends StatelessWidget {
  final List<Clima>? climaData;

  const Cuerpo({super.key, this.climaData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
              color: Color(0xFF3AACFF),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          child: ClimaHoy(climaData: climaData),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 20, top: 25, bottom: 5),
          child: Text(AppLocalizations.of(context)!.weekTitle,
              style: const TextStyle(fontSize: 18)),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
              color: Color(0XFF99DBFF),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Pronostico(climaData: climaData),
        ),
      ],
    );
  }
}
