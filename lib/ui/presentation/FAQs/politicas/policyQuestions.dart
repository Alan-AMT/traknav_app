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
        expandedValue:
            "A través del control de acceso mediante cuentas privadas pertenecientes al usuario en cuestión. Es responsabilidad del usuario el compartir su contraseña para acceder a la aplicación",
        headerValue:
            "¿Cómo protege nuestra aplicación la privacidad de los usuarios?"),
    Item(
        expandedValue:
            "Solamente recopilamos la información proporcionada a la hora de crear la cuenta, y es para adaptar una experiencia de usuario más personalizada. Como parte de una funcionalidad del sistema, también se guardan los planes de viaje",
        headerValue: "¿Qué tipo de información se recopila?"),
    Item(
        expandedValue: "No",
        headerValue: "¿Se comparte la información recopilada a terceros?"),
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
