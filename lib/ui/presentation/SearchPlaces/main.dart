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
        //backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: 550,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            decoration: BoxDecoration(
              color: Colors.blue, // Rectángulo azul
              borderRadius: BorderRadius.circular(20), // Bordes circulares
            ),
            child: Column(
              children: [
                Container(
                  //barra busqueda
                  height: 40,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        onPressed: () {},
                      ),
                      const Text(
                        '¿A dónde vamos?',
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.filter_alt),
                        onPressed: () {
                          AutoRouter.of(context)
                              .navigate(const SearchPlacesRoute());
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 250,
                  height: 370,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10), // Bordes redondos
                  ),
                  child:
                      MyCheckboxList(), //------------------------------------------------------
                ),
                Container(
                  //BOTON SIGUIENTE
                  height: 40,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 85, 187, 235),
                    borderRadius:
                        BorderRadius.circular(20), // Bordes circulares
                  ),
                  child: TextButton(
                    onPressed: () {
                      AutoRouter.of(context)
                          .navigate(const CreateTripPlanRoute());
                    },
                    child: const Text(
                      'Aceptar',
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 0, 0),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
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
