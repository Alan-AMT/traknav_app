import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BtnContactanos extends StatelessWidget {
  const BtnContactanos({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.contactUs,
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 15,
            ),
            const Text(
              "traknavdudassugerencias@outlook.com",
              style: TextStyle(fontSize: 16),
            )
          ],
        ));
  }
}
