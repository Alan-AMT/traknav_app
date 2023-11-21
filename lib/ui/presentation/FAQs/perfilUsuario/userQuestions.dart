import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/buildPanel.dart';
import '../Item.dart';

class UserQuestions extends StatefulWidget {
  const UserQuestions({super.key});

  @override
  State<UserQuestions> createState() => _UserQuestionsState();
}

class _UserQuestionsState extends State<UserQuestions> {
  final List<Item> _data = [
    Item(
        expandedValue: "bla bla bla bla",
        headerValue: "¿Cómo editar mi perfil de usuario?"),
    Item(
        expandedValue: "bla bla bla bla",
        headerValue: "¿Cómo reestablezco mi contraseña?"),
    Item(
        expandedValue: "bla bla bla bla",
        headerValue: "¿Cómo cambio mi foto de perfil?"),
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
