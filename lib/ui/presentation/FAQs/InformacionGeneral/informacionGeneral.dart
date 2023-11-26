import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/InformacionGeneral/informationQuestions.dart';
import 'package:traknav_app/ui/presentation/FAQs/actionArea.dart';
import 'package:traknav_app/ui/presentation/FAQs/topScreenBar.dart';

@RoutePage()
class InformacionGeneralPage extends StatelessWidget {
  const InformacionGeneralPage({super.key});

  /* @override
  Widget buildy(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("PREGUNTAS FRECUENTES")),
      body: ListView(
        children: <Widget>[
          //const TopScreenBar(),
          Image.asset('assets/FAQs/FAQs.png'),
          const ActionArea(
              text: "INFORMACIÓN GENERAL", content: InformationQuestions())
        ],
      ),
    ));
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PREGUNTAS FRECUENTES")),
      body: SafeArea(
          child: ListView(
        children: [
          Image.asset('assets/FAQs/FAQs.png'),
          const ActionArea(
              text: "INFORMACIÓN GENERAL", content: InformationQuestions())
        ],
      )),
    );
  }
}
