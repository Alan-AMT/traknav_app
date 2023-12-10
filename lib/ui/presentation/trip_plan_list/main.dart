import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/presentation/PlanDeViaje/cubit/plan_de_viaje_cubit.dart';

@RoutePage()
class TripPlanListPage extends StatefulWidget {
  const TripPlanListPage({Key? key}) : super(key: key);

  @override
  State<TripPlanListPage> createState() => _TripPlanListPage();
}

class _TripPlanListPage extends State<TripPlanListPage> {
  @override
  void initState() {
    super.initState();
    fetchCurrentPlanes();
  }

  void fetchCurrentPlanes() async {
    await context.read<PlanDeViajeCubit>().fetchCurrentPlanes();
  }

  List<Map<String, dynamic>> planData = [
    {
      'title': 'Plan 1',
      'days': [
        {
          'places': [
            {'name': 'Museo de Frida Kahlo', 'completed': false},
            {'name': 'Museo de Soumaya', 'completed': false},
          ],
          'completed': false,
        },
        // ... otros días ...
      ],
    },
    // ... otros planes ...
  ];

  void _toggleDayCompletion(int planIndex, int dayIndex) {
    setState(() {
      var day = planData[planIndex]['days'][dayIndex];
      day['completed'] = !day['completed'];
      day['places'].forEach((place) => place['completed'] = day['completed']);
    });
  }

  void _togglePlaceCompletion(int planIndex, int dayIndex, int placeIndex) {
    setState(() {
      var day = planData[planIndex]['days'][dayIndex];
      var place = day['places'][placeIndex];

      // Cambiar el estado de 'completed' del lugar
      place['completed'] = !place['completed'];

      // Verificar si todos los lugares del día están completados
      day['completed'] = day['places'].every((p) => p['completed'] as bool);
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
        body: ListView.builder(
          itemCount: state.planes.length,
          itemBuilder: (context, planIndex) {
            final plan = planData[planIndex];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(plan['title'],
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    ...plan['days'].asMap().entries.map<Widget>((dayEntry) {
                      int dayIndex = dayEntry.key;
                      var day = dayEntry.value;

                      String dayNumber = (dayIndex + 1).toString();
                      String dayStatus = day['completed']
                          ? AppLocalizations.of(context)!.tripplanlistf
                          : AppLocalizations.of(context)!.tripplanlistu;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxListTile(
                            title: Text(
                                '${AppLocalizations.of(context)!.tripplanday} $dayNumber - $dayStatus'),
                            value: day['completed'],
                            onChanged: (_) =>
                                _toggleDayCompletion(planIndex, dayIndex),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          ...day['places']
                              .asMap()
                              .entries
                              .map<Widget>((placeEntry) {
                            int placeIndex = placeEntry.key;
                            var place = placeEntry.value;

                            // CheckboxListTile para cada lugar
                            return CheckboxListTile(
                              title: Text(place['name']),
                              value: place['completed'],
                              onChanged: (bool? newValue) {
                                _togglePlaceCompletion(
                                    planIndex, dayIndex, placeIndex);
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            );
                          }).toList(),
                        ],
                      );
                    }).toList(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Acción para editar el plan de viaje
                            //context.router.push(EditTripPlanRoute(planData: planData[planIndex], tripDaysData: []));
                          },
                          child:
                              Text(AppLocalizations.of(context)!.edittripplan),
                        ),
                        TextButton(
                          onPressed: () {
                            // Acción para iniciar el plan de viaje
                          },
                          child:
                              Text(AppLocalizations.of(context)!.tripplanlists),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
