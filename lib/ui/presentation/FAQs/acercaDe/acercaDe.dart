import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/acercaDe/btns.dart';
import 'package:traknav_app/ui/presentation/FAQs/actionArea.dart';
import 'package:traknav_app/ui/presentation/FAQs/topScreenBar.dart';

//---------WIDGET CUERPO (CONTIENE LOS WIDGETS QUE FORMAN EL WIDGET FINAL/TOTAL)------------
@RoutePage()
class CuerpoPage extends StatelessWidget {
  const CuerpoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopScreenBar(),
          Image.asset('assets/FAQs/FAQs.png'),
          const ActionArea(text: "PREGUNTAS ACERCA DE:", content: Btns()),
        ],
      ),
    );
  }
}
