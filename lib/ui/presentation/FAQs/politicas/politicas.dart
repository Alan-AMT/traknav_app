import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/actionArea.dart';
import 'package:traknav_app/ui/presentation/FAQs/politicas/policyQuestions.dart';
import 'package:traknav_app/ui/presentation/FAQs/topScreenBar.dart';

@RoutePage()
class PoliticasPage extends StatelessWidget {
  const PoliticasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopScreenBar(),
          Image.asset('assets/FAQs/FAQs.png'),
          const ActionArea(
              text: "POLÍTICAS DE PRIVACIDAD", content: PolicyQuestions())
        ],
      ),
    );
  }
}
