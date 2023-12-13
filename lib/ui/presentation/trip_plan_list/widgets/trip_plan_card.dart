import 'package:flutter/material.dart';
import 'package:traknav_app/ui/core/data/plan_de_viaje.dart';
import 'package:traknav_app/ui/presentation/trip_plan_list/widgets/trip_day_places.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TripPlanCard extends StatefulWidget {
  final PlanDeViaje plan;
  const TripPlanCard({Key? key, required this.plan}) : super(key: key);

  @override
  State<TripPlanCard> createState() => _TripPlanCard();
}

class _TripPlanCard extends State<TripPlanCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        // decoration: BoxDecoration(color: Colors.blueGrey[800]),
        margin: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.plan.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.plan.days.keys.length,
                    itemBuilder: (context, index) {
                      final day = widget.plan.days[index + 1];
                      return TripDayPlaces(day: day!, dayNumber: index + 1);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Acción para editar el plan de viaje
                        //context.router.push(EditTripPlanRoute(planData: planData[planIndex], tripDaysData: []));
                      },
                      child: Text(AppLocalizations.of(context)!.edittripplan),
                    ),
                    TextButton(
                      onPressed: () {
                        // Acción para iniciar el plan de viaje
                      },
                      child: Text(AppLocalizations.of(context)!.tripplanlists),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
