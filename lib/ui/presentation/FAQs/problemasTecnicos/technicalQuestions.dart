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
        expandedValue: "bla bla bla bla",
        headerValue: "¿Por qué no puedo acceder a mi cuenta?"),
    Item(expandedValue: "bla bla bla bla", headerValue: "El mapa no carga"),
    Item(
        expandedValue: "bla bla bla bla",
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
