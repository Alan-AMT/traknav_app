import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class TripPlanPage extends StatelessWidget {
  const TripPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            'Plan de viaje',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontStyle: FontStyle.italic,
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              AutoRouter.of(context).navigate(const HomeRoute());
            },
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'El plan de viaje te permitira seleccionar todos los lugares de interes, posteriormente te permitira trazar una ruta para visitarlos.',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
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
            color: Colors.white,
            child: Center(
              child: TextButton(
                onPressed: () {
                  AutoRouter.of(context).navigate(const CreateTripPlanRoute());
                },
                style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff0098FA),
                    shape: const StadiumBorder()),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text('Crear plan de viaje',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nunito',
                      )),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            color: Colors.white,
            child: Center(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff0098FA),
                    shape: const StadiumBorder()),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text('Mis planes de viaje',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nunito',
                      )),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            color: Colors.white,
            child: Center(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff0098FA),
                    shape: const StadiumBorder()),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 75, vertical: 15),
                  child: Text('Historial',
                      style: TextStyle(
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
  }
}
