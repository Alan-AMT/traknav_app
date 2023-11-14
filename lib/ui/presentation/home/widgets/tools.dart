import 'package:flutter/material.dart';

class ToolsWidget extends StatelessWidget {
  const ToolsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 4,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listTools.length,
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
                    child: Image.asset('assets/home/Tool_${index + 1}.png'),
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
                    listTools[index].text,
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

List<StyleModelTools> listTools = [
  StyleModelTools(
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
      text: 'Tiempo'),
  StyleModelTools(
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
      text: 'Plan Viaje'),
  StyleModelTools(
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
      text: 'Favoritos'),
];

class StyleModelTools {
  final int id;
  final Color color;
  final List<BoxShadow> boxShadow;
  final String text;

  StyleModelTools(
      {required this.id,
      required this.color,
      required this.boxShadow,
      required this.text});
}
