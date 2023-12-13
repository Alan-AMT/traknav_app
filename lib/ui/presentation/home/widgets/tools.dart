import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ToolsWidget extends StatefulWidget {
  const ToolsWidget({Key? key}) : super(key: key);

  @override
  _ToolsWidgetState createState() => _ToolsWidgetState();
}

class _ToolsWidgetState extends State<ToolsWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      AppLocalizations.of(context)!.homeCategoriesTiempo,
      AppLocalizations.of(context)!.homeCategoriesPlanViaje,
      AppLocalizations.of(context)!.homeCategoriesFavoritos,
    ];
    return Expanded(
      flex: 6,
      child: Stack(
        children: [
          Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                AppLocalizations.of(context)!.homeCategoriesHerramientas,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 25.0,
            left: 50,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: listTools.length,
              padding: EdgeInsets.only(
                left: 25.0,
                right: 25.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    switch (categories[index]) {
                      case 'Plan Viaje':
                        context.router.push(TripPlanRoute());
                        break;
                      case 'Trip plan':
                        context.router.push(TripPlanRoute());
                        break;
                      case 'Tiempo':
                        AutoRouter.of(context).navigate(const ClimaRoute());
                        break;
                      case 'Climate':
                        AutoRouter.of(context).navigate(const ClimaRoute());
                        break;
                      case 'Favoritos':
                        // context.router.push(FavoritesRoute());
                        break;
                      case 'Favorites':
                        // context.router.push(FavoritesRoute());
                        break;
                      default:
                        break;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 13.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          height: 65.0,
                          width: 65.0,
                          child:
                              Image.asset('assets/home/Tool_${index + 1}.png'),
                          decoration: BoxDecoration(
                            color: listTools[index].color,
                            borderRadius: BorderRadius.circular(18.0),
                            boxShadow: listTools[index].boxShadow,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          categories[index],
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StyleModelTools {
  final int id;
  final Color color;
  final List<BoxShadow> boxShadow;

  StyleModelTools({
    required this.id,
    required this.color,
    required this.boxShadow,
  });
}

List<StyleModelTools> listTools = [
  StyleModelTools(
    id: 1,
    color: Colors.blue,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(168, 131, 131, 131),
        blurRadius: 10.0,
        spreadRadius: 1.0,
        offset: Offset(0, 0),
      ),
    ],
  ),
  StyleModelTools(
    id: 2,
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(168, 131, 131, 131),
        blurRadius: 10.0,
        spreadRadius: 1.0,
        offset: Offset(0, 0),
      ),
    ],
  ),
  StyleModelTools(
    id: 3,
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(168, 131, 131, 131),
        blurRadius: 10.0,
        spreadRadius: 1.0,
        offset: Offset(0, 0),
      ),
    ],
  ),
];
