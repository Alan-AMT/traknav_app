import 'package:flutter/material.dart';

class ControlBtns extends StatelessWidget {
  const ControlBtns({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
              elevation: const MaterialStatePropertyAll(6)),
          onPressed: () {},
          child: const SizedBox(
              width: 100,
              child: Text(
                "Agregar cuenta nueva",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              )),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(
                  Color.fromARGB(255, 84, 168, 236)),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
              elevation: const MaterialStatePropertyAll(6)),
          onPressed: () {},
          child: const SizedBox(
              width: 100,
              child: Text(
                "Aceptar",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              )),
        ),
      ],
    );
  }
}
