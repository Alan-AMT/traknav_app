import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

class BtnGeneralFAQs extends StatelessWidget {
  const BtnGeneralFAQs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 3, left: 5, right: 5),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(
                Color.fromARGB(255, 80, 166, 236)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
            elevation: const MaterialStatePropertyAll(10)),
        onPressed: () {
          AutoRouter.of(context).navigate(const CuerpoRoute());
        },
        child: Column(
          children: [
            Container(
              height: 50,
            ),
            const Text(
              "PREGUNTAS GENERALES",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: 35,
            ),
            const Text(
              "Resuelve tus dudas con esta recopilación de dudas más frecuentes",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Container(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
