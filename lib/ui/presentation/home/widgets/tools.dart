import 'package:flutter/material.dart';

class ToolsWidget extends StatelessWidget {
  const ToolsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              color: const Color.fromARGB(
                  255, 255, 255, 255), // Puedes ajustar el color del fondo
              child: Text(
                'Herramientas',
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          // Otros widgets que puedas tener en el fondo del Stack
          Positioned.fill(
            //lo ponemos hasta
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
