import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class TripPlanPage extends StatelessWidget {
  const TripPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
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
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Text(
                    AppLocalizations.of(context)!.tripPlanMaintext,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      //color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Image(
                image: AssetImage('assets/TravelPlan/señoraxd.png'),
                width: 242.0,
                height: 260.0,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                  color: state.isLightTheme ? Colors.white : Colors.black),
              child: Row(children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      AutoRouter.of(context).navigate(CreateTripPlanRoute());
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff0098FA),
                        shape: const StadiumBorder()),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(AppLocalizations.of(context)!.createtripplan,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Nunito',
                          )),
                    ),
                  ),
                )
              ]),
            ),
            const SizedBox(height: 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                  color: state.isLightTheme ? Colors.white : Colors.black),
              child: Row(children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      AutoRouter.of(context)
                          .navigate(TripPlanListRoute(tripDaysData: []));
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff0098FA),
                        shape: const StadiumBorder()),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(AppLocalizations.of(context)!.tripplanlist,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Nunito',
                          )),
                    ),
                  ),
                )
              ]),
            ),
            const SizedBox(height: 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                  color: state.isLightTheme ? Colors.white : Colors.black),
              child: Row(children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      AutoRouter.of(context)
                          .navigate(const TripPlanHistoryRoute());
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff0098FA),
                        shape: const StadiumBorder()),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(AppLocalizations.of(context)!.tripplanhistory,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Nunito',
                          )),
                    ),
                  ),
                )
              ]),
            ),
            const SizedBox(height: 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                  color: state.isLightTheme ? Colors.white : Colors.black),
              child: Row(children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      // final <Object?>[placeId, mainText, secText, ..._] =
                      //     await showMaterialModalBottomSheet(
                      //   context: context,
                      //   expand: false,
                      //   elevation: 10,
                      //   isDismissible: true,
                      //   builder: (context) => const MenuSelectCity(),
                      // );
                      AutoRouter.of(context)
                          .navigate(const ExplorePlansRoute());
                      // print(await PlanDeViajeDataSource.fetchPopularPlanes());
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff0098FA),
                        shape: const StadiumBorder()),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child:
                          Text(AppLocalizations.of(context)!.explorePlansButton,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'Nunito',
                              )),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      );
    });
  }
}
