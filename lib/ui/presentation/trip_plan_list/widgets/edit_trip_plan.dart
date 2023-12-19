import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:traknav_app/ui/config/toasts/main.dart';
import 'package:traknav_app/ui/presentation/PlanDeViaje/cubit/plan_de_viaje_cubit.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:traknav_app/ui/core/data/plan_de_viaje.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

@RoutePage()
class EditTripPlanPage extends StatefulWidget {
  final PlanDeViaje plan;

  const EditTripPlanPage({Key? key, required this.plan}) : super(key: key);

  @override
  State<EditTripPlanPage> createState() => _EditTripPlanPage();
}

class _EditTripPlanPage extends State<EditTripPlanPage> {
  Map<String, List<Map<String, dynamic>>> tripDaysData = {};
  final planKey = GlobalKey<FormBuilderState>();
  String countryValue = "";
  String cityValue = "";
  String stateCityValue = "";

  @override
  void initState() {
    super.initState();
    for (int i = 1; i <= widget.plan.days.length; i++) {
      tripDaysData[i.toString()] = widget.plan.days[i]!;
    }
  }

  void removeDayFromPlan(int dayNumber) {
    if (tripDaysData.length == 1) {
      ToastApp.error("Tu plan de viaje debe tener al menos 1 día");
      return;
    }
    for (int i = dayNumber; i < tripDaysData.length; i++) {
      tripDaysData[i.toString()] = tripDaysData["${i + 1}"]!;
    }
    tripDaysData.remove(tripDaysData.length.toString());
  }

  void addDayToPlan() {
    if (tripDaysData.length > 21) {
      ToastApp.error("Tu plande viaje puede tener un máximo de 21 días");
      return;
    }
    tripDaysData["${tripDaysData.length + 1}"] = [];
  }

  void _showPlaceSearchDialog(int dayIndex) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Buscar Lugar',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                GooglePlaceAutoCompleteTextField(
                  textEditingController: TextEditingController(),
                  googleAPIKey: "AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s",
                  countries: const ["mx"],
                  inputDecoration: const InputDecoration(
                    hintText: 'Escribe el nombre del lugar...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  debounceTime: 600,
                  isLatLngRequired: true,
                  itemClick: (Prediction prediction) {
                    Navigator.pop(dialogContext);
                    _showAddPlaceConfirmationDialog(dayIndex, prediction);
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddPlaceConfirmationDialog(int dayIndex, Prediction prediction) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Agregar Lugar'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    '¿Quieres agregar "${prediction.description}" al día ${dayIndex + 1}?'),
                const SizedBox(height: 20.0),
                FutureBuilder<String>(
                  future: PlanDeViajeDataSource.fetchPlaceImage(prediction
                      .placeId!), // Aseguramos de que placeId no sea null
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Text('Error al cargar la imagen');
                    } else {
                      return Column(
                        children: [
                          if (snapshot.hasData && snapshot.data != null)
                            Image.network(
                              snapshot.data!,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return const Text(
                                    'No se pudo cargar la imagen'); // Texto o widget a mostrar en caso de error.
                              },
                            )
                          else
                            const SizedBox.shrink(),
                          // const Text('No hay imagen disponible'),
                          ElevatedButton(
                            child: const Text('Agregar'),
                            onPressed: () {
                              if (snapshot.hasData && snapshot.data != null) {
                                if (tripDaysData[dayIndex.toString()]!.length >
                                    8) {
                                  ToastApp.error(
                                      "Solo puede haber máximo 8 lugares por día. Agrega este lugar a otro día");
                                  return;
                                }
                                setState(() {
                                  tripDaysData[dayIndex.toString()]!.add({
                                    "id": "${prediction.placeId}",
                                    "imageUrl": snapshot.data,
                                    "name": prediction
                                            .structuredFormatting?.mainText ??
                                        "",
                                    "visited": false
                                  });
                                });
                                Navigator.of(dialogContext).pop();
                              }
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showRemoveDayDialog(int dayNumber) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Eliminar día"),
          content: Text(
              "¿Estas seguro de que quieres eliminar el día $dayNumber de tu plan de viaje? Si lo eliminas todos los lugares del día se perderán"),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cierra el diálogo
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.confirm),
              onPressed: () {
                setState(() {
                  removeDayFromPlan(dayNumber);
                  Navigator.of(dialogContext)
                      .pop(); // Cierra el cuadro de diálogo
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _showUpdatePlanDialog() {
    // Verifica si hay al menos un lugar en el plan de viaje
    bool hasPlaces = tripDaysData.isNotEmpty;
    tripDaysData.forEach(
      (key, value) {
        if (value.isEmpty) hasPlaces = false;
      },
    );

    if (!hasPlaces) {
      ToastApp.error("Todos los días de tu plan deben tener lugares asignados");
      return;
    }
    if (stateCityValue == "") {
      ToastApp.error("Por favor selecciona una ciudad");
      return;
    }
    if (planKey.currentState?.saveAndValidate() ?? false) {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.edittripplan),
            content: Text("Los datos de tu plan serán actualizados"),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.confirm),
                onPressed: () async {
                  try {
                    await EasyLoading.show();
                    Navigator.of(dialogContext).pop();
                    await context.read<PlanDeViajeCubit>().updatePlanDeViaje(
                        startDate:
                            planKey.currentState!.fields["startDate"]!.value,
                        name: planKey.currentState!.fields["name"]!.value,
                        city: stateCityValue,
                        id: widget.plan.id,
                        tripDaysData: tripDaysData);
                    ToastApp.success("Tu plan de viaje ha sido actualizado");
                  } catch (e) {
                    print(e);
                    ToastApp.error(
                        "No pudimos actualizar tu plan de viaje. Intenta de nuevo");
                  } finally {
                    await EasyLoading.dismiss();
                    context.router.popUntil(
                        (route) => route.settings.name == TripPlanRoute.name);
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _showDeletePlanDialog() {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text("Eliminar plan de viaje"),
            content: Text(
                "¿Estas seguro de que deseas eliminar el plan de viaje '${widget.plan.name}'? Esta acción es irreversible"),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.confirm),
                onPressed: () async {
                  try {
                    await EasyLoading.show();
                    Navigator.of(dialogContext).pop();
                    await context
                        .read<PlanDeViajeCubit>()
                        .deletePlanDeViaje(id: widget.plan.id);
                  } catch (e) {
                    print(e);
                    ToastApp.error(
                        "No pudimos crear tu plan de viaje. Intenta de nuevo");
                  } finally {
                    await EasyLoading.dismiss();
                    context.router.popUntil(
                        (route) => route.settings.name == TripPlanRoute.name);
                  }
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanDeViajeCubit, PlanDeViajeState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.tripplanappbar,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontStyle: FontStyle.italic,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    addDayToPlan();
                  });
                },
                child:
                    Text("Agregar día", style: TextStyle(color: Colors.white)))
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            FormBuilder(
                key: planKey,
                child: Column(children: [
                  FormBuilderTextField(
                    name: "name",
                    initialValue: widget.plan.name,
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
                  SizedBox(height: 10),
                  FormBuilderDateTimePicker(
                      name: "startDate",
                      initialValue: DateTime.fromMillisecondsSinceEpoch(
                          widget.plan.startDate),
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
                          if (widget.plan.startDate <
                              DateTime.now().millisecondsSinceEpoch) {
                            if (val.millisecondsSinceEpoch <
                                widget.plan.startDate) {
                              return 'No puedes usar una fecha anterior a la original';
                            }
                          } else {
                            if (val.millisecondsSinceEpoch <
                                DateTime.now().millisecondsSinceEpoch) {
                              return 'No puedes usar una fecha anterior a la actual';
                            }
                          }
                          return null;
                        },
                      ])),
                  SizedBox(height: 10)
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
            Expanded(
              child: ListView.builder(
                itemCount: tripDaysData.length,
                itemBuilder: (context, index) {
                  final dayData = tripDaysData["${index + 1}"];
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${AppLocalizations.of(context)!.tripplanday} ${index + 1}',
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    TextButton(
                                        onPressed: () {
                                          showRemoveDayDialog(index + 1);
                                        },
                                        child: const Text("Eliminar día",
                                            style:
                                                TextStyle(color: Colors.red)))
                                  ])),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: dayData!.length,
                            itemBuilder: (context, placeIndex) {
                              final place = dayData[placeIndex];
                              return Card(
                                child: Column(
                                  children: [
                                    // ClipRRect para asegurarnos de que la imagen no se desborde
                                    if (place['imageUrl'] != null)
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              8.0), // Agregamos un borde redondeado a la imagen
                                          child: Stack(children: [
                                            Image.network(
                                              place['imageUrl'],
                                              height:
                                                  100, // Altura fija para la imagen, ajusta según tus necesidades
                                              width: double
                                                  .infinity, // La imagen ocupa todo el ancho disponible
                                              fit: BoxFit
                                                  .cover, // Cubre el espacio de la imagen sin perder la proporción
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return const Text(
                                                    'Imagen no disponible'); // Texto a mostrar si la imagen no carga
                                              },
                                            ),
                                            Positioned(
                                                right: 0,
                                                child: IconButton(
                                                    alignment:
                                                        Alignment.topRight,
                                                    onPressed: () {
                                                      setState(() {
                                                        tripDaysData[
                                                                "${index + 1}"]!
                                                            .removeAt(
                                                                placeIndex);
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.close))),
                                          ])),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          place['name'] ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Center(
                                child: ElevatedButton(
                              onPressed: () =>
                                  _showPlaceSearchDialog(index + 1),
                              child: const Text('Agregar Lugar'),
                            )),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: _showUpdatePlanDialog,
                    child: Text("Actualizar plan de viaje"),
                  )),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: _showDeletePlanDialog,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text("Eliminar plan de viaje"),
                  ))
                ])),
          ],
        ),
      );
    });
  }
}
