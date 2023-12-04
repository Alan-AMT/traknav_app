import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/acercaDe/btns.dart';
import 'package:traknav_app/ui/presentation/FAQs/actionArea.dart';
import 'package:traknav_app/ui/presentation/FAQs/topScreenBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//---------WIDGET CUERPO (CONTIENE LOS WIDGETS QUE FORMAN EL WIDGET FINAL/TOTAL)------------
@RoutePage()
class CuerpoPage extends StatelessWidget {
  const CuerpoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.navBarTitle,
            style: const TextStyle(fontSize: 18)),
      ),
      body: Column(
        children: [
          // const TopScreenBar(),
          Image.asset('assets/FAQs/FAQs.png'),
          ActionArea(
              text: AppLocalizations.of(context)!.questionsAbout,
              content: Btns()),
        ],
      ),
    ));
  }
}
