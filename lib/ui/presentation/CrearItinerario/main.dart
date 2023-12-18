import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
              const Text(
                'Planifica tu viaje de manera fácil y eficiente.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(10.0), // Bordes redondeados aquí
                child: Image.asset('assets/TravelPlan/im1.jpg'),
              ), // Imagen agregada
              const SizedBox(height: 20),
              const Text(
                'Ingresa la duración de tu estadía e inicia tu aventura.',
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
                      decoration: const InputDecoration(
                        hintText: 'Nombre del plan',
                        labelText: 'Nombre del plan',
                        suffixIcon: Icon(Icons.title),
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "El campo es requerido"),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: "days",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Número de Días',
                        labelText: 'Número de Días',
                        suffixIcon: Icon(Icons.calendar_month),
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "El campo es requerido"),
                        FormBuilderValidators.integer(
                            errorText: "Debe ser un número válido de días"),
                        FormBuilderValidators.max(21,
                            errorText: "Solo se pueden máximo 21 días"),
                        FormBuilderValidators.min(1, errorText: "Mínimo 1 día")
                      ]),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderDateTimePicker(
                        name: "date",
                        textInputAction: TextInputAction.send,
                        decoration: const InputDecoration(
                          hintText: 'Fecha de inicio',
                          labelText: 'Fecha de inicio',
                          suffixIcon: Icon(Icons.schedule),
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "El campo es requerido"),
                          (val) {
                            if (val == null) return null;
                            if (val.millisecondsSinceEpoch <
                                minDate.millisecondsSinceEpoch) {
                              return 'No puedes usar una fecha anterior a la actual';
                            }
                            return null;
                          },
                        ])),
                  ])),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _onSubmit();
                },
                child: const Text('Planificar Viaje'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (daysKey.currentState?.saveAndValidate() ?? false) {
      final numberOfDays =
          int.parse(daysKey.currentState!.fields["days"]!.value);
      final DateTime startDate = daysKey.currentState!.fields["date"]!.value;
      final String name = daysKey.currentState!.fields["name"]!.value;
      AutoRouter.of(context).navigate(TripPlanCreatedRoute(
          days: numberOfDays, startDate: startDate, name: name));
    }
  }
}
