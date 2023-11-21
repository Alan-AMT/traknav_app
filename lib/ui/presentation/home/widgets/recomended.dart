import 'package:flutter/material.dart';

class RecomendedWidget extends StatelessWidget {
  const RecomendedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              color: const Color.fromARGB(
                  255, 255, 255, 255), // Puedes ajustar el color del fondo
              child: Text(
                'Recomendados',
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                // Agregar aquí la lógica para manejar el clic en "Ver más"
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                color: const Color.fromARGB(
                    255, 255, 255, 255), // Puedes ajustar el color del fondo
                child: Text(
                  'Ver más',
                  style: TextStyle(
                    color: Color.fromRGBO(58, 172, 255, 1),
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),

          // Otros widgets que puedas tener en el fondo del Stack
          Positioned.fill(
            //lo ponemos hasta
            top: 35.0,
            left: 0,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              padding: EdgeInsets.only(
                left: 25.0,
                right: 25.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // Manejar la navegación al hacer clic en el elemento del ListView
                    _navigateToDetailPage(context, index);
                  },
                  child: Padding(
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
                          height: 137.0,
                          width: 113.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/home/R_${index + 1}.png'),
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetailPage(BuildContext context, int index) {
    // Utilizar Navigator para navegar a la página de detalle
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AboutPlaces(item: list[index]),
      ),
    );
  }
}

class AboutPlaces extends StatelessWidget {
  final StyleModel item;

  AboutPlaces({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nombre del museo',
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          //Direccion
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: Color.fromRGBO(58, 172, 255, 1),
                borderRadius: BorderRadius.circular(30.0),
                //agregamos una sombra en la parte inferior
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(
                        168, 131, 131, 131), // Color de la sombra
                    blurRadius: 8.0, // Radio de difuminado
                    spreadRadius: 1.0, // Radio de expansión
                    offset: Offset(0, 0), // Desplazamiento en x y y
                  ),
                ],
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Dirección',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //agregamos un stack
                  Stack(
                    children: [
                      //agregamos un texto en la parte central
                      Positioned(
                        child: Container(
                          height: 98,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(153, 219, 255, 1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'loremp ipsum dolor sit amet, consectetur adipiscing elit. Donec auctor, nisl eget ultricies ultricies, nisl nisl ultr',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //Descripcion
          Positioned(
            top: 190,
            left: 15,
            right: 15,
            child: Container(
              height: 167,
              decoration: BoxDecoration(
                color: Color.fromRGBO(58, 172, 255, 1),
                borderRadius: BorderRadius.circular(30.0),
                //agregamos una sombra en la parte inferior
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(
                        168, 131, 131, 131), // Color de la sombra
                    blurRadius: 8.0, // Radio de difuminado
                    spreadRadius: 1.0, // Radio de expansión
                    offset: Offset(0, 0), // Desplazamiento en x y y
                  ),
                ],
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Descripción',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //agregamos un stack
                  Stack(
                    children: [
                      //agregamos un texto en la parte central
                      Positioned(
                        child: Container(
                          height: 125,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(153, 219, 255, 1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'loremp ipsum dolor sit amet, consectetur adipiscing elit. Donec auctor, nisl eget ultricies ultricies, nisl nisl ultr',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //Horario
          Positioned(
            bottom: 255,
            left: 15,
            right: 15,
            child: Container(
              height: 121,
              decoration: BoxDecoration(
                color: Color.fromRGBO(58, 172, 255, 1),
                borderRadius: BorderRadius.circular(30.0),
                //agregamos una sombra en la parte inferior
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(
                        168, 131, 131, 131), // Color de la sombra
                    blurRadius: 8.0, // Radio de difuminado
                    spreadRadius: 1.0, // Radio de expansión
                    offset: Offset(0, 0), // Desplazamiento en x y y
                  ),
                ],
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Horario',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //agregamos un stack
                  Stack(
                    children: [
                      //agregamos un texto en la parte central
                      Positioned(
                        child: Container(
                          height: 79,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(153, 219, 255, 1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'loremp ipsum dolor sit amet, consectetur adipiscing elit. Donec auctor, nisl eget ultricies ultricies, nisl nisl ultr',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //Galeria
          Positioned(
            bottom: 45,
            left: 15,
            right: 15,
            child: Container(
              height: 181,
              decoration: BoxDecoration(
                color: Color.fromRGBO(58, 172, 255, 1),
                borderRadius: BorderRadius.circular(30.0),
                //agregamos una sombra en la parte inferior
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(
                        168, 131, 131, 131), // Color de la sombra
                    blurRadius: 8.0, // Radio de difuminado
                    spreadRadius: 1.0, // Radio de expansión
                    offset: Offset(0, 0), // Desplazamiento en x y y
                  ),
                ],
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Galeria',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //agregamos un stack
                  Stack(
                    children: [
                      //agregamos un texto en la parte central
                      Positioned(
                        child: Container(
                          height: 139,
                          width: 390.0,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(153, 219, 255, 1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/home/R_${item.id}.png',
                                height:
                                    120.0, // Ajusta la altura según sea necesario
                                width:
                                    100.0, // Ajusta el ancho según sea necesario
                              ),
                              // Puedes agregar más detalles según sea necesario
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
