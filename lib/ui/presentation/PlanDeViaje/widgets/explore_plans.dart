import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/config/toasts/main.dart';
import 'package:traknav_app/ui/presentation/PlanDeViaje/cubit/plan_de_viaje_cubit.dart';
import 'package:traknav_app/ui/presentation/PlanDeViaje/widgets/popular_trip_plan_card.dart';

@RoutePage()
class ExplorePlansPage extends StatefulWidget {
  const ExplorePlansPage({Key? key}) : super(key: key);

  @override
  State<ExplorePlansPage> createState() => _ExplorePlansPage();
}

class _ExplorePlansPage extends State<ExplorePlansPage> {
  String countryValue = "";
  String cityValue = "";
  String stateCityValue = "";

  @override
  void initState() {
    super.initState();
    context.read<PlanDeViajeCubit>().refreshPopularPlanes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanDeViajeCubit, PlanDeViajeState>(
        builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.explorePlansButton,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontStyle: FontStyle.italic,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Column(
            children: [
              const SizedBox(height: 10),
              CSCPicker(
                ///Enable disable state dropdown [OPTIONAL PARAMETER]
                showStates: true,

                /// Enable disable city drop down [OPTIONAL PARAMETER]
                showCities: false,

                ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                flagState: CountryFlag.ENABLE,

                ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1)),

                ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                disabledDropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1)),

                countrySearchPlaceholder: "País",
                stateSearchPlaceholder: "Ciudad",
                citySearchPlaceholder: "Ciudad",
                countryDropdownLabel: "País",
                stateDropdownLabel: "Ciudad",
                cityDropdownLabel: "Ciudad",

                ///selected item style [OPTIONAL PARAMETER]
                selectedItemStyle: TextStyle(
                  fontSize: 14,
                ),

                ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                dropdownHeadingStyle:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.bold),

                ///DropdownDialog Item style [OPTIONAL PARAMETER]
                dropdownItemStyle: TextStyle(
                  fontSize: 14,
                ),

                ///Dialog box radius [OPTIONAL PARAMETER]
                dropdownDialogRadius: 10.0,

                ///Search bar radius [OPTIONAL PARAMETER]
                searchBarRadius: 10.0,

                ///triggers once country selected in dropdown
                onCountryChanged: (value) {
                  setState(() {
                    ///store value in country variable
                    countryValue = value;
                  });
                },

                ///triggers once state selected in dropdown
                onStateChanged: (value) {
                  setState(() {
                    ///store value in state variable
                    stateCityValue = value ?? "";
                  });
                },

                ///triggers once city selected in dropdown
                onCityChanged: (value) {
                  setState(() {
                    ///store value in city variable
                    cityValue = value ?? "";
                  });
                },

                ///Show only specific countries using country filter
                // countryFilter: ["United States", "Canada", "Mexico"],
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () async {
                          if (stateCityValue == "") {
                            ToastApp.error(AppLocalizations.of(context)!
                                .warningSelectCity);
                            return;
                          }
                          await EasyLoading.show();
                          await context
                              .read<PlanDeViajeCubit>()
                              // .fetchPopularPlans(city: "alan");
                              .fetchPopularPlans(city: stateCityValue);
                          await EasyLoading.dismiss();
                        },
                        child: Text(AppLocalizations.of(context)!.searchPlans),
                      ))
                    ],
                  )),
              Expanded(
                  child: ListView.builder(
                itemCount: state.popularPlans.length,
                itemBuilder: (context, index) {
                  final plan = state.popularPlans[index];
                  return PopularTripPlanCard(plan: plan);
                },
              ))
            ],
          ));
    });
  }
}
