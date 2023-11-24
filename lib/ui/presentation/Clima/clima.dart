import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ClimaPage extends StatefulWidget {
  const ClimaPage({super.key});

  @override
  State<ClimaPage> createState() => _ClimaPageState();
}

class _ClimaPageState extends State<ClimaPage> {
  @override
  void initState() {
    super.initState();
    getClima();
  }

  Future<void> getClima() async {
    final response = await Dio().get(
        'https://api.tomorrow.io/v4/weather/forecast?location=new%20york&timesteps=&apikey=QoV8qXH592AYwaKiwmJH8uyFCNp4qHiC');
    response; //PONER BREAKPOINT Y PROBAR
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
