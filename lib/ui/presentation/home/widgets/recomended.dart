import 'package:flutter/material.dart';

class RecomendedWidget extends StatelessWidget {
  const RecomendedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 4,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          padding: EdgeInsets.only(
            left: 25.0,
            right: 25.0,
          ),
          itemBuilder: (BuildContext contextm, int index) {
            return Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 9.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    height: 157.0,
                    width: 113.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/home/R_${index + 1}.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(18.0),
                      boxShadow: list[index].boxShadow,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            );
          },
        ));
  }
}

List<StyleModel> list = [
  StyleModel(
    id: 1,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(168, 131, 131, 131), // Color de la sombra
        blurRadius: 8.0, // Radio de difuminado
        spreadRadius: 1.0, // Radio de expansión
        offset: Offset(0, 0),
      ),
    ],
  ),
  StyleModel(
    id: 2,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(168, 131, 131, 131), // Color de la sombra
        blurRadius: 8.0, // Radio de difuminado
        spreadRadius: 1.0, // Radio de expansión
        offset: Offset(0, 0), // Desplazamiento en x y y
      ),
    ],
  ),
  StyleModel(
    id: 3,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(168, 131, 131, 131), // Color de la sombra
        blurRadius: 8.0, // Radio de difuminado
        spreadRadius: 1.0, // Radio de expansión
        offset: Offset(0, 0), // Desplazamiento en x y y
      ),
    ],
  ),
  StyleModel(
    id: 4,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(168, 131, 131, 131), // Color de la sombra
        blurRadius: 8.0, // Radio de difuminado
        spreadRadius: 1.0, // Radio de expansión
        offset: Offset(0, 0), // Desplazamiento en x y y
      ),
    ],
  ),
  StyleModel(
    id: 5,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(168, 131, 131, 131), // Color de la sombra
        blurRadius: 8.0, // Radio de difuminado
        spreadRadius: 1.0, // Radio de expansión
        offset: Offset(0, 0), // Desplazamiento en x y y
      ),
    ],
  ),
  StyleModel(
    id: 6,
    boxShadow: [
      BoxShadow(
        color: Color.fromARGB(168, 131, 131, 131), // Color de la sombra
        blurRadius: 8.0, // Radio de difuminado
        spreadRadius: 1.0, // Radio de expansión
        offset: Offset(0, 0), // Desplazamiento en x y y
      ),
    ],
  ),
];

class StyleModel {
  final int id;
  final List<BoxShadow> boxShadow;

  StyleModel({
    required this.id,
    required this.boxShadow,
  });
}
