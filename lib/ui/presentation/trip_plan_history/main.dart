import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:skeletons/skeletons.dart';
import 'package:traknav_app/ui/core/data/plan_de_viaje.dart';
import 'package:traknav_app/ui/presentation/PlanDeViaje/cubit/plan_de_viaje_cubit.dart';
import 'package:traknav_app/ui/presentation/trip_plan_history/show_plan.dart';

@RoutePage()
class TripPlanHistoryPage extends StatefulWidget {
  const TripPlanHistoryPage({Key? key}) : super(key: key);

  @override
  State<TripPlanHistoryPage> createState() => _TripPlanHistoryPage();
}

class _TripPlanHistoryPage extends State<TripPlanHistoryPage> {
  @override
  void initState() {
    super.initState();
    fetchExpiredPlanes();
  }

  void fetchExpiredPlanes() async {
    await context.read<PlanDeViajeCubit>().fetchExpiredPlanes(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanDeViajeCubit, PlanDeViajeState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.tripplanhistory,
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
        body: state.isLoadinggPlanesDeViaje
            ? ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(10),
                      child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: double.infinity,
                          minHeight: MediaQuery.of(context).size.height / 8,
                          maxHeight: MediaQuery.of(context).size.height / 3,
                        ),
                      ));
                },
              )
            : state.expiredPlanes.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.mensajehist1),
                        Text(AppLocalizations.of(context)!.mensajehist2,
                            textAlign: TextAlign.center)
                      ],
                    ))
                : ListView.builder(
                    itemCount: state.expiredPlanes.length,
                    itemBuilder: (context, index) {
                      final item = state.expiredPlanes[index];
                      final DateTime start =
                          DateTime.fromMillisecondsSinceEpoch(item.startDate);
                      final DateTime end =
                          DateTime.fromMillisecondsSinceEpoch(item.endDate);
                      var format = DateFormat("EEE, d/M/y");
                      return HistoryListItem(
                        title: item.name,
                        image: item.days[1]![0]["imageUrl"],
                        startDate: format.format(start),
                        endDate: format.format(end),
                        plan: item,
                        route:
                            "Desde: ${item.days[1]![0]['name']}\nHasta: ${item.days[item.days.length]!.last['name']}",
                      );
                    },
                  ),
      );
    });
  }
}

class HistoryListItem extends StatelessWidget {
  final String title;
  final String image;
  final PlanDeViaje plan;
  final String startDate;
  final String endDate;
  final String route;

  const HistoryListItem({
    Key? key,
    required this.title,
    required this.startDate,
    required this.image,
    required this.plan,
    required this.endDate,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await showMaterialModalBottomSheet(
              context: context, builder: (context) => ShowPlan(plan: plan));
        },
        child: Card(
          margin: const EdgeInsets.all(8.0),
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  image,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8),
                Text(title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Inicio: $startDate",
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.grey)),
                      Text("Fin: $endDate",
                          overflow: TextOverflow.clip,
                          style:
                              const TextStyle(fontSize: 16, color: Colors.grey))
                    ]),
                const SizedBox(height: 8),
                Text(route,
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.clip),
                const SizedBox(height: 8),
                const Center(
                    child: Icon(Icons.check_circle, color: Colors.green)),
              ],
            ),
          ),
        ));
  }
}
