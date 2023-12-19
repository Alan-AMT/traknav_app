import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:traknav_app/ui/config/toasts/main.dart';
import 'package:traknav_app/ui/presentation/PlanDeViaje/cubit/plan_de_viaje_cubit.dart';
import '../../router/android.gr.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:traknav_app/ui/core/data/plan_de_viaje.dart';

@RoutePage()
class TripPlanCreatedPage extends StatefulWidget {
  final int days;
  final DateTime startDate;
  final String name;
  final String city;

  const TripPlanCreatedPage(
      {Key? key,
      required this.days,
      required this.startDate,
      required this.city,
      required this.name})
      : super(key: key);

  @override
  State<TripPlanCreatedPage> createState() => _TripPlanCreatedPageState();
}

class _TripPlanCreatedPageState extends State<TripPlanCreatedPage> {
  Map<String, List<Map<String, dynamic>>> tripDaysData = {};
  // Map<int, List<Map<String, dynamic>>> tripDaysData = {};

  @override
  void initState() {
    super.initState();
    for (int i = 1; i <= widget.days; i++) {
      tripDaysData[i.toString()] = [];
    }
  }

  void removeDayFromPlan(int dayNumber) {
    if (tripDaysData.length == 1) {
      ToastApp.error(AppLocalizations.of(context)!.error6tripplan);
      return;
    }
    for (int i = dayNumber; i < tripDaysData.length; i++) {
      tripDaysData[i.toString()] = tripDaysData["${i + 1}"]!;
    }
    tripDaysData.remove(tripDaysData.length.toString());
  }

  void addDayToPlan() {
    if (tripDaysData.length > 21) {
      ToastApp.error(AppLocalizations.of(context)!.error7tripplan);
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
                Text(
                  AppLocalizations.of(context)!.search2,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                GooglePlaceAutoCompleteTextField(
                  textEditingController: TextEditingController(),
                  googleAPIKey: "AIzaSyBhlra2MNyBxGTRPayBfv5BomoclZseE8s",
                  countries: const ["mx"],
                  inputDecoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.search3,
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
                  child: Text(AppLocalizations.of(context)!.cancel),
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
          title: Text(AppLocalizations.of(context)!.agregar1),
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
                      return Text(AppLocalizations.of(context)!.imageerror1);
                    } else {
                      return Column(
                        children: [
                          if (snapshot.hasData && snapshot.data != null)
                            Image.network(
                              snapshot.data!,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Text(AppLocalizations.of(context)!
                                    .imageerror2); // Texto o widget a mostrar en caso de error.
                              },
                            )
                          else
                            const SizedBox.shrink(),
                          // const Text('No hay imagen disponible'),
                          ElevatedButton(
                            child: Text(AppLocalizations.of(context)!.agregar2),
                            onPressed: () {
                              if (snapshot.hasData && snapshot.data != null) {
                                if (tripDaysData[dayIndex.toString()]!.length >
                                    8) {
                                  ToastApp.error(AppLocalizations.of(context)!
                                      .error8tripplan);
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
              child: Text(AppLocalizations.of(context)!.cancel),
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
          title: Text(AppLocalizations.of(context)!.borrardia),
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

  void _showCreatePlanDialog() {
    // Verifica si hay al menos un lugar en el plan de viaje
    bool hasPlaces = tripDaysData.isNotEmpty;
    tripDaysData.forEach(
      (key, value) {
        if (value.isEmpty) hasPlaces = false;
      },
    );

    if (!hasPlaces) {
      ToastApp.error(AppLocalizations.of(context)!.error9tripplan);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.createPlanDialogTitle),
            content:
                Text(AppLocalizations.of(context)!.createPlanDialogMessage),
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
                    await context.read<PlanDeViajeCubit>().createPlanDeViaje(
                        startDate: widget.startDate,
                        name: widget.name,
                        city: widget.city,
                        tripDaysData: tripDaysData);
                    ToastApp.success("Tu plan de viaje ha sido creado");
                  } catch (e) {
                    print(e);
                    ToastApp.error(
                        AppLocalizations.of(context)!.error10tripplan);
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
                child: Text(AppLocalizations.of(context)!.agregar3,
                    style: TextStyle(color: Colors.white)))
          ],
        ),
        body: Column(
          children: [
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
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .borrardia,
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
                              child:
                                  Text(AppLocalizations.of(context)!.agregar1),
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
              child: ElevatedButton(
                onPressed: _showCreatePlanDialog,
                child: Text(AppLocalizations.of(context)!.createtripplan),
              ),
            ),
          ],
        ),
      );
    });
  }
}
