import 'package:flutter/material.dart';

class BtnContactanos extends StatelessWidget {
  const BtnContactanos({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            const Text(
              "CONTÁCTANOS:",
              style: TextStyle(fontSize: 18),
            ),
            Container(
              height: 15,
            ),
            const Text(
              "traknavdudassugerencias@outlook.com",
              style: TextStyle(fontSize: 15),
            )
          ],
        ));
  }
}
