import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

@RoutePage()
class TripPlanPage extends StatelessWidget {
  const TripPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Plan de viaje',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontStyle: FontStyle.italic,
              fontSize: 30,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              AutoRouter.of(context).navigate(const HomeRoute());
            },
            color: Colors.black,
          ),
          backgroundColor: state.isLightTheme
              ? Colors.white
              : const Color.fromRGBO(13, 71, 161, 1),
        ),
        // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                  child: const Text(
                    'El plan de viaje te permitira seleccionar todos los lugares de interes, posteriormente te permitira trazar una ruta para visitarlos.',
                    style: TextStyle(
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

            //
            Container(
              //color: Colors.white,
              decoration: BoxDecoration(
                  color: state.isLightTheme ? Colors.white : Colors.black),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    AutoRouter.of(context)
                        .navigate( CreateTripPlanRoute());
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff0098FA),
                      shape: const StadiumBorder()),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    child: Text('Crear plan de viaje',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'Nunito',
                        )),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              //color: Colors.white,
              child: Center(
                child: TextButton(
                  onPressed: () {
                    AutoRouter.of(context).navigate(const TripPlanListRoute());
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff0098FA),
                      shape: const StadiumBorder()),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    child: Text('Mis planes de viaje',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'Nunito',
                        )),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              //color: Colors.white,
              child: Center(
                child: TextButton(
                  onPressed: () {
                    AutoRouter.of(context)
                        .navigate(const TripPlanHistoryRoute());
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff0098FA),
                      shape: const StadiumBorder()),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 85, vertical: 15),
                    child: Text('Historial',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'Nunito',
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
