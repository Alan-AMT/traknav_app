import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skeletons/skeletons.dart';
import 'package:traknav_app/ui/presentation/PlanDeViaje/cubit/plan_de_viaje_cubit.dart';
import 'package:traknav_app/ui/presentation/trip_plan_list/widgets/trip_plan_card.dart';

@RoutePage()
class TripPlanListPage extends StatefulWidget {
  const TripPlanListPage(
      {Key? key, required List<Map<String, dynamic>> tripDaysData})
      : super(key: key);

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
    await context.read<PlanDeViajeCubit>().fetchCurrentPlanes(context: context);
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
          body: state.isLoadinggPlanesDeViaje
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: SkeletonItem(
                          child: Column(
                        children: [
                          const SizedBox(height: 12),
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              width: double.infinity,
                              minHeight: MediaQuery.of(context).size.height / 8,
                              maxHeight: MediaQuery.of(context).size.height / 3,
                            ),
                          ),
                          SkeletonParagraph(
                              style: SkeletonParagraphStyle(
                                  lines: 1,
                                  spacing: 6,
                                  lineStyle: SkeletonLineStyle(
                                    randomLength: true,
                                    height: 10,
                                    borderRadius: BorderRadius.circular(8),
                                    minLength:
                                        MediaQuery.of(context).size.width / 2,
                                  ))),
                        ],
                      )),
                    ),
                  ),
                )
              : state.planes.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: Text(
                                  AppLocalizations.of(context)!.mensajelist1)),
                          Center(
                              child: Text(
                                  AppLocalizations.of(context)!.mensajelist2))
                        ],
                      ))
                  : ListView.builder(
                      itemCount: state.planes.length,
                      itemBuilder: (context, planIndex) {
                        final plan = state.planes[planIndex];
                        return TripPlanCard(plan: plan);
                      },
                    ));
    });
  }
}
