import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BtnGeneralFAQs extends StatelessWidget {
  const BtnGeneralFAQs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Color(0xFF237BBB)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
            elevation: const MaterialStatePropertyAll(10)),
        onPressed: () {
          AutoRouter.of(context).navigate(const CuerpoRoute());
        },
        child: Column(
          children: [
            Container(
              height: 25,
            ),
            Text(
              AppLocalizations.of(context)!.mainBtnTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.mainBtnText,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Container(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
