import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:traknav_app/ui/presentation/Clima/cuerpo.dart';
import 'package:traknav_app/ui/presentation/Clima/modelo.dart';

@RoutePage()
class ClimaPage extends StatefulWidget {
  const ClimaPage({super.key});

  @override
  State<ClimaPage> createState() => _ClimaPageState();
}

class _ClimaPageState extends State<ClimaPage> {
  Future<List<Clima>>? climaDataF;

  Future<List<Clima>> getClimaForecast() async {
    var url = Uri.https('api.tomorrow.io', '/v4/weather/forecast',
        {'location': 'mexico', 'apikey': 'QoV8qXH592AYwaKiwmJH8uyFCNp4qHiC'});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      List<Clima> forecast = [];

      final lugar = jsonData["location"]["name"];
      for (var item in jsonData["timelines"]["daily"]) {
        final temperatura = item["values"]["temperatureAvg"];
        final nublado = item["values"]["cloudCoverAvg"];
        final probLluvia = item["values"]["precipitationProbabilityAvg"];
        final String fecha = item["time"];
        forecast.add(Clima(temperatura, nublado, probLluvia, lugar, fecha));
      }
      return forecast;
    } else {
      throw Exception("Error al conectar con tomorrow.io API");
    }
  }

  @override
  void initState() {
    super.initState();
    climaDataF = getClimaForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CLIMA"),
      ),
      body: FutureBuilder(
        future: climaDataF,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(children: [
              Cuerpo(climaData: snapshot.data),
            ]);
          } else if (snapshot.hasError) {
            return const Text("Error");
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
