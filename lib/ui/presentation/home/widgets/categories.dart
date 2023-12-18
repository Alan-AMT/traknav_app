import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/presentation/home/widgets/catalogComercio.dart';
import 'package:traknav_app/ui/presentation/home/widgets/catalogRecomendados.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:traknav_app/ui/presentation/home/widgets/catalogComercio.dart';
import 'package:traknav_app/ui/presentation/home/widgets/catalogMuseos.dart';
import 'package:traknav_app/ui/presentation/home/widgets/catalogHospedaje.dart';
import 'package:traknav_app/ui/presentation/home/widgets/catalogParque.dart';
import 'package:traknav_app/ui/presentation/home/widgets/catalogRestaurantes.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      AppLocalizations.of(context)!.homeCategoriesComercioLocal,
      AppLocalizations.of(context)!.homeCategoriesMuseos,
      AppLocalizations.of(context)!.homeCategoriesHospedaje,
      AppLocalizations.of(context)!.homeCategoriesParques,
      AppLocalizations.of(context)!.homeCategoriesRestaurantes,
      AppLocalizations.of(context)!.homeCategoriesPersonalizadas,
    ];
    return Expanded(
      flex: 5,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                AppLocalizations.of(context)!.homeCategoriesTitle,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 25.0,
            left: 0,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              padding: EdgeInsets.only(
                left: 25.0,
                right: 25.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    switch (categories[index]) {
                      case 'Comercio Local':
                        // context.router.push(TripPlanRoute());
                        //mandamos a catalogComercio.dart
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WidgetCatalogComercio(),
                          ),
                        );
                        break;
                      case 'Local trade':
                        // context.router.push(TripPlanRoute());
                        //mandamos a catalogComercio.dart
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WidgetCatalogComercio(),
                          ),
                        );
                        break;
                      case 'Museos':
                        // AutoRouter.of(context).navigate(const ClimaRoute());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WidgetCatalogMuseos(),
                          ),
                        );
                        break;
                      case 'Museums':
                        // AutoRouter.of(context).navigate(const ClimaRoute());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WidgetCatalogMuseos(),
                          ),
                        );
                        break;
                      case 'Hospedaje':
                        // context.router.push(FavoritesRoute());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WidgetCatalogHospedaje(),
                          ),
                        );
                        break;
                      case 'Lodging':
                        // context.router.push(FavoritesRoute());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WidgetCatalogHospedaje(),
                          ),
                        );
                        break;
                      case 'Parques':
                        // context.router.push(FavoritesRoute());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WidgetCatalogParque(),
                          ),
                        );
                        break;
                      case 'Parks':
                        // context.router.push(FavoritesRoute());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WidgetCatalogParque(),
                          ),
                        );
                        break;
                      case 'Restaurantes':
                        // context.router.push(FavoritesRoute());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WidgetCatalogRestaurante(),
                          ),
                        );

                        break;
                      case 'Restaurants':
                        // context.router.push(FavoritesRoute());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WidgetCatalogRestaurante(),
                          ),
                        );
                        break;
                      case 'Personalizadas':
                        // context.router.push(FavoritesRoute());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WidgetCatalogRecomendados(),
                          ),
                        );
                        break;
                      case 'Personalized':
                        // context.router.push(FavoritesRoute());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WidgetCatalogRecomendados(),
                          ),
                        );
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
                              Image.asset('assets/home/Cat_${index + 1}.png'),
                          decoration: BoxDecoration(
                            color: categorieslist[index].color,
                            borderRadius: BorderRadius.circular(18.0),
                            boxShadow: categorieslist[index].boxShadow,
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

List<StyleModelCategories> categorieslist = [
  //creamos una variable
  StyleModelCategories(
    id: 1,
    color: Colors.blue,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(168, 131, 131, 131), // Color de la sombra
        blurRadius: 10.0, // Radio de difuminado
        spreadRadius: 1.0, // Radio de expansión
        offset: Offset(0, 0),
      ),
    ],
  ),
  StyleModelCategories(
    id: 2,
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(168, 131, 131, 131), // Color de la sombra
        blurRadius: 10.0, // Radio de difuminado
        spreadRadius: 1.0, // Radio de expansión
        offset: Offset(0, 0), // Desplazamiento en x y y
      ),
    ],
  ),
  StyleModelCategories(
    id: 3,
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(168, 131, 131, 131), // Color de la sombra
        blurRadius: 10.0, // Radio de difuminado
        spreadRadius: 1.0, // Radio de expansión
        offset: Offset(0, 0), // Desplazamiento en x y y
      ),
    ],
  ),
  StyleModelCategories(
    id: 4,
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(168, 131, 131, 131), // Color de la sombra
        blurRadius: 10.0, // Radio de difuminado
        spreadRadius: 1.0, // Radio de expansión
        offset: Offset(0, 0), // Desplazamiento en x y y
      ),
    ],
  ),
  StyleModelCategories(
    id: 5,
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(168, 131, 131, 131), // Color de la sombra
        blurRadius: 10.0, // Radio de difuminado
        spreadRadius: 1.0, // Radio de expansión
        offset: Offset(0, 0), // Desplazamiento en x y y
      ),
    ],
  ),
  StyleModelCategories(
    id: 6,
    color: const Color.fromARGB(255, 255, 255, 255),
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(168, 131, 131, 131), // Color de la sombra
        blurRadius: 10.0, // Radio de difuminado
        spreadRadius: 1.0, // Radio de expansión
        offset: Offset(0, 0), // Desplazamiento en x y y
      ),
    ],
  ),
];

class StyleModelCategories {
  final int id;
  final Color color;
  final List<BoxShadow> boxShadow;

  StyleModelCategories({
    required this.id,
    required this.color,
    required this.boxShadow,
  });
}
