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
        expandedValue:
            "Puedes editar tu perfil de usuario accediendo a los detalles de tu cuenta a través del ícono redondo de la ezquina superior derecha de la pantalla principal. Una vez en los detalles de tu cuenta solo tienes que hacer tap en 'editar'",
        headerValue: "¿Cómo editar mi perfil de usuario?"),
    Item(
        expandedValue:
            "Reestablecer contraseña es una de las modificaciones que puedes hacer al editar tu perfil, por lo que tienes que acceder a editar perfil",
        headerValue: "¿Cómo reestablezco mi contraseña?"),
    Item(
        expandedValue:
            "No, tus planes y viajes son privados y se almacenan en tu cuenta de usuario. Los planes se pueden compartir por redes sociales, pero no es obligatorio hacerlo",
        headerValue: "¿Mis planes y viajes son públicos?"),
    Item(
        expandedValue:
            "Si no configuraste tus preferencias a la hora de crear tu cuenta o deseas cambiarlas, solo tienes que acceder al apartado de 'modificar recomendaciones' del menú de hamburguesa",
        headerValue: "¿Cómo personalizar mi cuenta?"),
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
