import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/buildPanel.dart';
import '../Item.dart';

class InformationQuestions extends StatefulWidget {
  const InformationQuestions({super.key});

  @override
  State<InformationQuestions> createState() => _InformationQuestionsState();
}

class _InformationQuestionsState extends State<InformationQuestions> {
  final List<Item> _data = [
    Item(expandedValue: "bla bla bla bla", headerValue: "Sobre mi cuenta"),
    Item(
        expandedValue: "bla bla bla bla",
        headerValue: "Sobre las funcionalidades del sistema"),
    Item(
        expandedValue: "bla bla bla bla",
        headerValue: "Sobre la recuperación de contraseña"),
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
