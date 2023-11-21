import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

//WIDGET QUE CORRESPONDE A LA BARRA SUPERIOR DE TITULO Y BOTÓN DE REGRESAR
class TopScreenBar extends StatelessWidget {
  final VoidCallback? onPressed; //al final ya no se utilizó...

  const TopScreenBar({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: () {
            AutoRouter.of(context).back();
          },
          child: Image.asset(
            'assets/FAQs/regresar.png',
            width: 50,
            height: 30,
            fit: BoxFit.cover,
            alignment: Alignment.centerLeft,
          ),
        ),
        const Text(
          "PREGUNTAS FRECUENTES",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
