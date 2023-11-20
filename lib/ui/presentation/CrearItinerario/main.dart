import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class CreateTripPlanPage extends StatelessWidget {
  const CreateTripPlanPage({super.key});

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

      // ---------------------------------------------------------
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  //-------------------------------------------------------
                  child: Container(
                    //BARRA DE BUSQUEDA
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 17.0, right: 17.0),
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: List.generate(
                        1,
                        (index) => BoxShadow(
                          offset: const Offset(0, 3),
                          blurRadius: 5,
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.16),
                        ),
                      ),
                    ),
                    child: const TextField(
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 35,
                        ),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Color.fromARGB(129, 35, 34, 34),
                          fontSize: 18.0,
                          fontFamily: 'NUNITO_LIGHT',
                        ),
                        hintText: '¿A dónde vamos?',
                      ),
                    ),
                  ), //--------------------------------BARRA DE BUSQUEDA
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
