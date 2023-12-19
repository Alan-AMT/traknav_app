import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:traknav_app/ui/core/data/plan_de_viaje.dart';
import 'package:traknav_app/ui/presentation/PlanDeViaje/cubit/plan_de_viaje_cubit.dart';
import 'package:traknav_app/ui/presentation/PlanDeViaje/widgets/popular_trip_day_places.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

class PopularTripPlanCard extends StatefulWidget {
  final PlanDeViaje plan;
  const PopularTripPlanCard({Key? key, required this.plan}) : super(key: key);

  @override
  State<PopularTripPlanCard> createState() => _PopularTripPlanCard();
}

class _PopularTripPlanCard extends State<PopularTripPlanCard> {
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
                    child: Text("Duración: ${widget.plan.days.length} días",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 58, 172, 255),
                        ))),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.plan.days.keys.length,
                    itemBuilder: (context, index) {
                      final day = widget.plan.days[index + 1];
                      return PopularTripDayPlaces(
                          day: day!,
                          dayNumber: index + 1,
                          planId: widget.plan.id);
                    },
                  ),
                ),
                Center(
                    child: TextButton(
                        onPressed: () async {
                          await EasyLoading.show();
                          await context
                              .read<PlanDeViajeCubit>()
                              .copyPlanDeViaje(plan: widget.plan);
                          await EasyLoading.dismiss();
                          context.router.popUntil((route) =>
                              route.settings.name == TripPlanRoute.name);
                        },
                        child: Text(AppLocalizations.of(context)!.copyPlan)))
              ],
            ),
          ),
        ));
  }
}
