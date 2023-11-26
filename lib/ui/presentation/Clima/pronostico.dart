import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/Clima/modelo.dart';
import 'package:traknav_app/ui/presentation/Clima/pronosticoDia.dart';

class Pronostico extends StatelessWidget {
  final List<Clima>? climaData;
  const Pronostico({super.key, this.climaData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PronosticoDia(climaData: climaData![1]),
        const Divider(color: Colors.white),
        PronosticoDia(climaData: climaData![2]),
        const Divider(color: Colors.white),
        PronosticoDia(climaData: climaData![3]),
        const Divider(color: Colors.white),
        PronosticoDia(climaData: climaData![4]),
        const Divider(color: Colors.white),
        PronosticoDia(climaData: climaData![5]),
      ],
    );
  }
}
