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
    Item(
        expandedValue:
            "Puedes personalizar tu cuenta a través de la configuración de tus preferencias a la hora de crearla, o bien, haciendo tap en la opción 'modificar recomendaciones' ubicada en el menú de hambrguesa ",
        headerValue: "Sobre la personalización de mi cuenta"),
    Item(
        expandedValue:
            "Algunas de las funcionalidades más destacadas de TrakNav son: crear y editar planes de viaje, guardar planes de viaje, visualizar clima actual y su pronóstico en los 5 días siguientes, modificar el idioma, ¡y muchas más!",
        headerValue:
            "Sobre las funcionalidades más importantes de la aplicación"),
    Item(
        expandedValue:
            "Los usuarios de TrakNav pueden crear planes de viaje y modificarlos, estos planes pueden ser de hasta 3 días. Una vez concluido el plan, este se guarda para que el usuario pueda recordar a los lugares que fue y el orden en que lo hizo. Además, se puede compartir el plan de viaje por redes sociales",
        headerValue: "Sobre los itinerarios de viaje"),
    Item(
        expandedValue:
            "El manual de usuario es una guía para que el usuario conozca a detalle todas las funcionalidades disponibles en el sistema. Este manual se encuentra en las últimas opciones del menú de hamburguesa",
        headerValue: "Sobre el manual de usuario"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: BuildPanel(data: _data),
    );
  }
}
