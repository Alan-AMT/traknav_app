import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/actionArea.dart';
import 'package:traknav_app/ui/presentation/FAQs/perfilUsuario/userQuestions.dart';
import 'package:traknav_app/ui/presentation/FAQs/topScreenBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class PerfilUsuarioPage extends StatelessWidget {
  const PerfilUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.navBarTitle,
              style: const TextStyle(fontSize: 18))),
      body: ListView(
        children: <Widget>[
          // const TopScreenBar(),
          Image.asset('assets/FAQs/FAQs.png'),
          ActionArea(
              text: AppLocalizations.of(context)!.usrProfile,
              content: UserQuestions())
        ],
      ),
    ));
  }
}
