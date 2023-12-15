import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/buildPanel.dart';
import '../Item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InformationQuestions extends StatefulWidget {
  const InformationQuestions({super.key});

  @override
  State<InformationQuestions> createState() => _InformationQuestionsState();
}

class _InformationQuestionsState extends State<InformationQuestions> {
  @override
  Widget build(BuildContext context) {
    final List<Item> data = [
      Item(
          expandedValue: AppLocalizations.of(context)!.gnralInfoAns1,
          headerValue: AppLocalizations.of(context)!.gnralInfo1),
      Item(
          expandedValue: AppLocalizations.of(context)!.gnralInfoAns2,
          headerValue: AppLocalizations.of(context)!.gnralInfo2),
      Item(
          expandedValue: AppLocalizations.of(context)!.gnralInfoAns3,
          headerValue: AppLocalizations.of(context)!.gnralInfo3),
      Item(
          expandedValue: AppLocalizations.of(context)!.gnralInfoAns4,
          headerValue: AppLocalizations.of(context)!.gnralInfo4),
    ];
    return Container(
      padding: const EdgeInsets.all(10),
      child: BuildPanel(data: data),
    );
  }
}
