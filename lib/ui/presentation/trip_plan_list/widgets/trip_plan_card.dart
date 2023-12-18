import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:traknav_app/ui/core/data/plan_de_viaje.dart';
import 'package:traknav_app/ui/presentation/trip_plan_list/widgets/trip_day_places.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

class TripPlanCard extends StatefulWidget {
  final PlanDeViaje plan;
  const TripPlanCard({Key? key, required this.plan}) : super(key: key);

  @override
  State<TripPlanCard> createState() => _TripPlanCard();
}

class _TripPlanCard extends State<TripPlanCard> {
  final format = DateFormat('EEE, M/d/y');

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        margin: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.plan.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                Center(
                    child: Text(
                        "${format.format(DateTime.fromMillisecondsSinceEpoch(widget.plan.startDate))} - ${format.format(DateTime.fromMillisecondsSinceEpoch(widget.plan.endDate))}",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 58, 172, 255),
                        ))),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.plan.days.keys.length,
                    itemBuilder: (context, index) {
                      final date = DateTime.fromMillisecondsSinceEpoch(
                              widget.plan.startDate)
                          .add(Duration(days: index));
                      final day = widget.plan.days[index + 1];
                      return TripDayPlaces(
                          day: day!,
                          dayNumber: index + 1,
                          date: date,
                          planId: widget.plan.id);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.router
                            .push(EditTripPlanRoute(plan: widget.plan));
                      },
                      child: Text(AppLocalizations.of(context)!.edittripplan),
                    ),
                    TextButton(
                      onPressed: () {
                        context.router
                            .push(InitTripPlanRoute(plan: widget.plan));
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
