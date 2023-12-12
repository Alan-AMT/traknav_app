import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/buildPanel.dart';
import '../Item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PolicyQuestions extends StatefulWidget {
  const PolicyQuestions({super.key});

  @override
  State<PolicyQuestions> createState() => _PolicyQuestionsState();
}

class _PolicyQuestionsState extends State<PolicyQuestions> {
  @override
  Widget build(BuildContext context) {
    final List<Item> data = [
      Item(
          expandedValue: AppLocalizations.of(context)!.privPoliciesAns1,
          headerValue: AppLocalizations.of(context)!.privPolicies1),
      Item(
          expandedValue: AppLocalizations.of(context)!.privPoliciesAns2,
          headerValue: AppLocalizations.of(context)!.privPolicies2),
      Item(
          expandedValue: AppLocalizations.of(context)!.privPoliciesAns3,
          headerValue: AppLocalizations.of(context)!.privPolicies3),
    ];
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: BuildPanel(data: data),
      ),
    );
  }
}
