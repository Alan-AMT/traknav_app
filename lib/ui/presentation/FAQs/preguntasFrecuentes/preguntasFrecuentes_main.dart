import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/preguntasFrecuentes/BtnContactanos.dart';
import 'package:traknav_app/ui/presentation/FAQs/preguntasFrecuentes/BtnGeneralFAQs.dart';
import 'package:traknav_app/ui/presentation/FAQs/topScreenBar.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class FAQsPage extends StatelessWidget {
  const FAQsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopScreenBar(),
          Image.asset('assets/FAQs/FAQs.png'),
          const BtnGeneralFAQs(),
          const BtnContactanos(),
        ],
      ),
    );
  }
}
