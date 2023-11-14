import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Categoria {
  int id;
  String nombre;
  String foto;

  Categoria(this.id, this.nombre, this.foto);
}

@RoutePage()
class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final opciones = [
      Categoria(
          1, AppLocalizations.of(context)!.recPopular, "Sitios_populares.png"),
      Categoria(2, AppLocalizations.of(context)!.recMuseum, "Museos.png"),
      Categoria(
          3, AppLocalizations.of(context)!.recRestaurants, "Restaurantes.png"),
      Categoria(4, AppLocalizations.of(context)!.recLocalCommerce,
          "Comercio_local.png"),
      Categoria(5, AppLocalizations.of(context)!.recHistorical,
          "Patrimonio_historico.png"),
      Categoria(6, AppLocalizations.of(context)!.recLodgment, "Hospedaje.png"),
      Categoria(7, AppLocalizations.of(context)!.recParks, "Parques.png"),
      Categoria(
          8, AppLocalizations.of(context)!.recGuided, "Visitas_guiadas.png"),
    ];
    return Scaffold(
        backgroundColor:
            const Color.fromARGB(255, 58, 172, 255), //rgb(58, 172, 255).
        body: Column(children: [
          Expanded(
              child: GridView.builder(
                  itemCount: opciones.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: ((context, index) {
                    return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(
                                255, 0, 187, 164), //rgb(0, 187, 164).
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/${opciones[index].foto}",
                                width: 100),
                            Text(opciones[index].nombre)
                          ],
                        ));
                  }))),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).navigate(const HomeRoute());
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                child: Text(AppLocalizations.of(context)!.buttonSave,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 58, 172, 255),
                        fontSize:
                            Theme.of(context).textTheme.titleLarge!.fontSize)),
              ))
            ],
          )
        ]));
  }
}
