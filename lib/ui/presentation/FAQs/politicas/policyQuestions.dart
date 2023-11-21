import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/buildPanel.dart';
import '../Item.dart';

class PolicyQuestions extends StatefulWidget {
  const PolicyQuestions({super.key});

  @override
  State<PolicyQuestions> createState() => _PolicyQuestionsState();
}

class _PolicyQuestionsState extends State<PolicyQuestions> {
  final List<Item> _data = [
    Item(
        expandedValue: "bla bla bla bla",
        headerValue: "¿Qupe es lo que puedo compartir?"),
    Item(
        expandedValue: "bla bla bla bla",
        headerValue: "¿Puedo ser baneado de la aplicación?"),
    Item(
        expandedValue: "bla bla bla bla",
        headerValue: "¿Puedo mostrar mis planes de viaje a terceros?"),
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
