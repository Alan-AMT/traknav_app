import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/Clima/modelo.dart';

class ClimaHoy extends StatelessWidget {
  final List<Clima>? climaData;

  const ClimaHoy({super.key, required this.climaData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text(
                climaData![0].lugarStr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Container(
                height: 10,
              ),
              Text(
                climaData![0].fechaStr(),
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 25),
          width: 200,
          height: 200,
          child: climaData![0].nublado > 50
              ? Image.asset('assets/clima/dia-nublado.png')
              : Image.asset('assets/clima/sol.png'),
        ),
        Text(
          climaData![0].nublado > 50 ? "Nublado" : "Soleado",
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        Container(
          padding: const EdgeInsets.only(top: 25),
          child: Text(
            '${climaData![0].temperatura}°',
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset('assets/clima/clima.png'),
              ),
              Container(
                width: 20,
              ),
              Text(
                '${climaData![0].probLluvia}% de probabilidad de lluvia',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}
