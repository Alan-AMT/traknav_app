import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/buildPanel.dart';
import '../Item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserQuestions extends StatefulWidget {
  const UserQuestions({super.key});

  @override
  State<UserQuestions> createState() => _UserQuestionsState();
}

class _UserQuestionsState extends State<UserQuestions> {
  @override
  Widget build(BuildContext context) {
    final List<Item> data = [
      Item(
          expandedValue: AppLocalizations.of(context)!.hwEditProfileAns,
          headerValue: AppLocalizations.of(context)!.hwEditProfile),
      Item(
          expandedValue: AppLocalizations.of(context)!.hwResetPassAns,
          headerValue: AppLocalizations.of(context)!.hwResetPass),
      Item(
          expandedValue: AppLocalizations.of(context)!.plansAndTripsAns,
          headerValue: AppLocalizations.of(context)!.plansAndTrips),
      Item(
          expandedValue: AppLocalizations.of(context)!.hwCustomAccAns,
          headerValue: AppLocalizations.of(context)!.hwCustomAcc),
    ];
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: BuildPanel(data: data),
      ),
    );
  }
}
