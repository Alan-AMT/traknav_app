import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class SearchPlacesPage extends StatelessWidget {
  const SearchPlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            centerTitle: true,
            title: const Text(
              'Buscar Sitios',
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
                AutoRouter.of(context).navigate(const CreateTripPlanRoute());
              },
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Center(
          child: Container(
            width: 800,
            height: 800,
            child: Stack(
              children: [
                // Rectángulo azul
                Positioned(
                  top: 20, // Ajusta la posición vertical
                  left: 35, // Ajusta la posición horizontal
                  child: Container(
                    width: 290,
                    height: 550,
                    decoration: BoxDecoration(
                      color: Colors.blue, // Rectángulo azul
                      borderRadius:
                          BorderRadius.circular(20), // Bordes circulares
                    ),
                  ),
                ),

                // Espacio blanco rectangular con iconos y texto
                Positioned(
                  top: 40, // Ajusta la posición vertical
                  left: 55,
                  //left: MediaQuery.of(context).size.width / 2 - 100,
                  child: Container(
                    width: 250,
                    height: 40,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(20), // Bordes circulares
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            // Lógica al presionar el botón izquierdo
                          },
                        ),
                        const Text(
                          '¿A dónde vamos?',
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(Icons.filter_alt),
                          onPressed: () {
                            // Lógica al presionar el botón derecho
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: 100,
                  left: 55,
                  child: Container(
                    width: 250,
                    height: 350,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(10), // Bordes redondos
                    ),
                    child:
                        MyCheckboxList(), //------------------------------------------------------
                  ),
                ),

                Positioned(
                  top: 470,
                  left: MediaQuery.of(context).size.width / 2,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 113, 181, 237),
                      borderRadius:
                          BorderRadius.circular(40), // Bordes redondos
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Siguiente',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCheckboxList extends StatefulWidget {
  @override
  _MyCheckboxListState createState() => _MyCheckboxListState();
}

class _MyCheckboxListState extends State<MyCheckboxList> {
  late bool _selectAll;
  late List<bool> _isCheckedList;
  late CheckboxController _controller;

  @override
  void initState() {
    super.initState();
    _selectAll = false;
    _isCheckedList = List.generate(10, (index) => false);
    _controller = CheckboxController(onChange: onCheckboxChanged);
  }

  void onCheckboxChanged(bool? value) {
    setState(() {
      _selectAll = value ?? false;
      _isCheckedList = List.generate(10, (index) => _selectAll);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Checkbox para "Seleccionar todos" fuera del contenedor blanco
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text('Seleccionar todos'),
          value: _selectAll,
          onChanged: _controller.setChecked,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10), // Bordes redondos
            ),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(getCheckboxText(index)),
                  value: _isCheckedList[index],
                  onChanged: (value) {
                    setState(() {
                      _isCheckedList[index] = value ?? false;
                      _selectAll =
                          _isCheckedList.every((isChecked) => isChecked);
                    });
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  String getCheckboxText(int index) {
    switch (index) {
      case 0:
        return 'Museos';
      case 1:
        return 'Parques';
      case 2:
        return 'Hoteles';
      case 3:
        return 'Playas';
      case 4:
        return 'Restaurantes';
      case 5:
        return 'Lugares Populares';
      case 6:
        return 'Comercio Local';
      case 7:
        return 'Excursiones';
      case 8:
        return 'Atracciones Turísticas';
      case 9:
        return 'Patrimonio';
      default:
        return '';
    }
  }
}

class CheckboxController {
  final ValueChanged<bool?> onChange;

  CheckboxController({required this.onChange});

  void setChecked(bool? value) {
    onChange(value);
  }
}
