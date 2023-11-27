import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

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
              //color: const Color.fromARGB(255, 255, 255, 255), // Puedes ajustar el color del fondo
              child: Text(
                AppLocalizations.of(context)!.homeCategoriesTitle,
                style: TextStyle(
                  //color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20.0,
                ),
              ),
            ),
          ),

          // Otros widgets que puedas tener en el fondo del Stack
          Positioned.fill(
            //lo ponemos hasta
            top: 30.0,
            left: 0,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categorieslist.length,
              padding: EdgeInsets.only(
                left: 25.0,
                right: 25.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    top: 13.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.0),
                        height: 65.0,
                        width: 65.0,
                        child: Image.asset('assets/home/Cat_${index + 1}.png'),
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
                        //categorieslist[index].text,
                        categories[index],
                        style: TextStyle(
                          //color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
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
