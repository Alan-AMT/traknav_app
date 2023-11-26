import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/buildPanel.dart';
import '../Item.dart';

class TechnicalQuestions extends StatefulWidget {
  const TechnicalQuestions({super.key});

  @override
  State<TechnicalQuestions> createState() => _TechnicalQuestionsState();
}

class _TechnicalQuestionsState extends State<TechnicalQuestions> {
  final List<Item> _data = [
    Item(
        expandedValue:
            "Asegurate de tener conexión a internet. Si no puedes visualizar el clima en la ubicación deseada, prueba moviendo la ubicación a una zona cercana",
        headerValue: "No puedo visualizar el clima"),
    Item(
        expandedValue:
            "Verifica tu conexión a internet. Si aún así no puede cargar el mapa, intenta esperar y después vuélvelo a intentar, seguramente haya problemas con la conexión al servicio de Google",
        headerValue: "El mapa no carga"),
    Item(
        expandedValue:
            "Asegurate de tener conexión a internet a la hora de gardar el plan de viaje",
        headerValue: "Mi plan de viaje no se guarda"),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: BuildPanel(data: _data),
      ),
    );
  }
}
