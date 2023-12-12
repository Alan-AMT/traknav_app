import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/Clima/modelo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PronosticoDia extends StatelessWidget {
  final Clima? climaData;

  const PronosticoDia({super.key, this.climaData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text(climaData!.fechaStr(),
                style: const TextStyle(color: Colors.black))),
        Row(
          children: [
            Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.only(top: 10),
                child: climaData!.nublado > 50
                    ? Image.asset('assets/clima/dia-nublado.png')
                    : Image.asset('assets/clima/sol.png')),
            Text(
                "${AppLocalizations.of(context)!.temperaturaDia} ${climaData!.temperatura}",
                style: const TextStyle(color: Colors.black)),
            Container(width: 20),
            Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset('assets/clima/clima.png')),
            Text(
                "${AppLocalizations.of(context)!.chanceRainDia} ${climaData!.probLluvia}",
                style: const TextStyle(color: Colors.black)),
          ],
        ),
        Container(height: 10),
      ],
    );
  }
}
