import 'package:flutter/material.dart';

//Es el área en azul que está debajo de la mayoria de pantallas de ls FAQs, reciben su texto correspondiente y un widget, que es el bloque que va a contener
class ActionArea extends StatelessWidget {
  final String text;
  final Widget content;
  const ActionArea({super.key, required this.text, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(30)),
      width: 400,
      height: 350,
      child: Column(
        children: [
          Container(
            height: 10,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          content,
        ],
      ),
    );
  }
}
