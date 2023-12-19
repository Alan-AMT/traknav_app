import 'package:auto_route/auto_route.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:traknav_app/ui/config/toasts/main.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class CreateTripPlanPage extends StatefulWidget {
  const CreateTripPlanPage({Key? key}) : super(key: key);

  @override
  State<CreateTripPlanPage> createState() => _CreateTripPlanPage();
}

class _CreateTripPlanPage extends State<CreateTripPlanPage> {
  final daysKey = GlobalKey<FormBuilderState>();
  final DateTime minDate = DateTime.now();
  String countryValue = "";
  String cityValue = "";
  String stateCityValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.tripplanlist,
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
      body: SingleChildScrollView(
        // Envolver en un SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.tripplantext1,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(10.0), // Bordes redondeados aquí
                child: Image.asset('assets/TravelPlan/im1.jpg'),
              ), // Imagen agregada
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.tripplantext2,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              FormBuilder(
                  key: daysKey,
                  child: Column(children: [
                    FormBuilderTextField(
                      name: "name",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.myTripPlans15,
                        labelText: AppLocalizations.of(context)!.myTripPlans15,
                        suffixIcon: Icon(Icons.title),
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText:
                                AppLocalizations.of(context)!.error1tripplan),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: "days",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.myTripPlans2,
                        labelText: AppLocalizations.of(context)!.myTripPlans25,
                        suffixIcon: Icon(Icons.calendar_month),
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText:
                                AppLocalizations.of(context)!.error1tripplan),
                        FormBuilderValidators.integer(
                            errorText:
                                AppLocalizations.of(context)!.error2tripplan),
                        FormBuilderValidators.max(21,
                            errorText:
                                AppLocalizations.of(context)!.error3tripplan),
                        FormBuilderValidators.min(1,
                            errorText:
                                AppLocalizations.of(context)!.error4tripplan)
                      ]),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderDateTimePicker(
                        name: "date",
                        textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.myTripPlans3,
                          labelText:
                              AppLocalizations.of(context)!.myTripPlans35,
                          suffixIcon: Icon(Icons.schedule),
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText:
                                  AppLocalizations.of(context)!.error1tripplan),
                          (val) {
                            if (val == null) return null;
                            if (val.millisecondsSinceEpoch <
                                minDate.millisecondsSinceEpoch) {
                              return AppLocalizations.of(context)!
                                  .error5tripplan;
                            }
                            return null;
                          },
                        ])),
                  ])),
              const SizedBox(height: 10),
              CSCPicker(
                showStates: true,
                showCities: false,
                flagState: CountryFlag.ENABLE,
                dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1)),
                disabledDropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1)),
                countrySearchPlaceholder: "País",
                stateSearchPlaceholder: "Ciudad",
                citySearchPlaceholder: "Ciudad",
                countryDropdownLabel: "País",
                stateDropdownLabel: "Ciudad",
                cityDropdownLabel: "Ciudad",
                selectedItemStyle: TextStyle(
                  fontSize: 14,
                ),
                dropdownHeadingStyle:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                dropdownItemStyle: TextStyle(
                  fontSize: 14,
                ),
                dropdownDialogRadius: 10.0,
                searchBarRadius: 10.0,
                onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    stateCityValue = value ?? "";
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    cityValue = value ?? "";
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _onSubmit();
                },
                child: Text(AppLocalizations.of(context)!.tripplancreatebutton),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (stateCityValue == "") {
      ToastApp.error(AppLocalizations.of(context)!.warningSelectCity);
      return;
    }
    if (daysKey.currentState?.saveAndValidate() ?? false) {
      final numberOfDays =
          int.parse(daysKey.currentState!.fields["days"]!.value);
      final DateTime startDate = daysKey.currentState!.fields["date"]!.value;
      final String name = daysKey.currentState!.fields["name"]!.value;
      AutoRouter.of(context).navigate(TripPlanCreatedRoute(
          days: numberOfDays,
          startDate: startDate,
          name: name,
          city: stateCityValue));
    }
  }
}
