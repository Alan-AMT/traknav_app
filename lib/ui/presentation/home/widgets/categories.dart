import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categorieslist.length,
          padding: EdgeInsets.only(
            left: 25.0,
            right: 25.0,
          ),
          itemBuilder: (BuildContext contextm, int index) {
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
                    categorieslist[index].text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

List<StyleModelCategories> categorieslist = [
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
      text: 'Comercio Local'),
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
      text: 'Museos'),
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
      text: 'Hospedaje'),
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
      text: 'Parques'),
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
      text: 'Restaurantes'),
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
      text: 'Personalizadas'),
];

class StyleModelCategories {
  final int id;
  final Color color;
  final List<BoxShadow> boxShadow;
  final String text;

  StyleModelCategories(
      {required this.id,
      required this.color,
      required this.boxShadow,
      required this.text});
}
