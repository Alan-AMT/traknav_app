import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/InformacionGeneral/informationQuestions.dart';
import 'package:traknav_app/ui/presentation/FAQs/actionArea.dart';
import 'package:traknav_app/ui/presentation/FAQs/topScreenBar.dart';

@RoutePage()
class InformacionGeneralPage extends StatelessWidget {
  const InformacionGeneralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopScreenBar(),
          Image.asset('assets/FAQs/FAQs.png'),
          const ActionArea(
              text: "INFORMACIÓN GENERAL", content: InformationQuestions())
        ],
      ),
    );
  }
}
