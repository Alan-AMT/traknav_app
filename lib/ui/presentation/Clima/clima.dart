import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:traknav_app/ui/presentation/Clima/cuerpo.dart';
import 'package:traknav_app/ui/presentation/Clima/modelo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class ClimaPage extends StatefulWidget {
  const ClimaPage({super.key});

  @override
  State<ClimaPage> createState() => _ClimaPageState();
}

class _ClimaPageState extends State<ClimaPage> {
  Future<List<Clima>>? climaDataF;

  //-----------PARA PODER OBTENER LA POSICIÓN--------------
  Future<LocationData?> _getLocation() async {
    final bool hasPermission = await checkPermissions();
    if (!hasPermission) return null;
    Location location = Location();
    return await location.getLocation();
  }

  //------PARA VERIFICAR SI SE TIENEN PERMISOS PARA ACCEDER A LA LOCALIZACIÓN-------
  Future<bool> checkPermissions() async {
    bool serviceEnabled;
    Location location = Location();
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        false;
      }
    }
    return true;
  }

  //-------------------------PARA OBTENER EL CLIMA------------------------------
  Future<List<Clima>> getClimaForecast(LocationData? location) async {
    var url = Uri.https('api.tomorrow.io', '/v4/weather/forecast', {
      'location': '${location?.latitude},${location?.longitude}',
      'apikey': 'QoV8qXH592AYwaKiwmJH8uyFCNp4qHiC'
    });
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
    _getLocation().then((position) {
      climaDataF = getClimaForecast(position);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.weatherTitle),
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
