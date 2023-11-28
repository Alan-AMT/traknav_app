import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/MultiUser/controlBtns.dart';
import 'package:traknav_app/ui/presentation/MultiUser/userBtns.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (10 / 11),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(22))),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(height: 12),
            const Text(
              "¿Quién viajará hoy?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const UsersBtns(),
            Container(height: 40),
            const ControlBtns(),
            Container(height: 20),
          ],
        ),
      ),
    );
  }
}
