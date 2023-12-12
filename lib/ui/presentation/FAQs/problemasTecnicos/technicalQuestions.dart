import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/buildPanel.dart';
import '../Item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TechnicalQuestions extends StatefulWidget {
  const TechnicalQuestions({super.key});

  @override
  State<TechnicalQuestions> createState() => _TechnicalQuestionsState();
}

class _TechnicalQuestionsState extends State<TechnicalQuestions> {
  @override
  Widget build(BuildContext context) {
    final List<Item> data = [
      Item(
          expandedValue: AppLocalizations.of(context)!.technicalProbAns1,
          headerValue: AppLocalizations.of(context)!.technicalProb1),
      Item(
          expandedValue: AppLocalizations.of(context)!.technicalProbAns2,
          headerValue: AppLocalizations.of(context)!.technicalProb2),
      Item(
          expandedValue: AppLocalizations.of(context)!.technicalProbAns3,
          headerValue: AppLocalizations.of(context)!.technicalProb3),
    ];
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: BuildPanel(data: data),
      ),
    );
  }
}
