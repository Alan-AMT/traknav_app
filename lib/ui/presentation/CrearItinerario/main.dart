import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class CreateTripPlanPage extends StatefulWidget {
  CreateTripPlanPage({Key? key}) : super(key: key);

  @override
  _CreateTripPlanPageState createState() => _CreateTripPlanPageState();
}

class _CreateTripPlanPageState extends State<CreateTripPlanPage> {
  final TextEditingController _daysController = TextEditingController();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Añadir esta línea
      appBar: AppBar(
      centerTitle: true,
      title: Text(AppLocalizations.of(context)!.tripplanlist,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontStyle: FontStyle.italic,
          fontSize: 30,
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ),
      body: SingleChildScrollView( // Envolver en un SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Planifica tu viaje de manera fácil y eficiente.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // Bordes redondeados aquí
                child: Image.asset('assets/TravelPlan/im1.jpg'),
              ), // Imagen agregada
              SizedBox(height: 20),
              Text(
                'Ingresa la duración de tu estadía e inicia tu aventura.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              _numberOfDaysField(),
              SizedBox(height: 20),
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _numberOfDaysField() {
    return TextField(
      controller: _daysController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Número de Días',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        // TODO: Implementar lógica de validación de entrada
      },
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () => _onSubmit(),
      child: Text('Planificar Viaje'),
    );
  }

  void _onSubmit() {
    int numberOfDays = int.tryParse(_daysController.text) ?? 0;
    if (numberOfDays > 0) {
      //Lógica de planificación
       AutoRouter.of(context).navigate(TripPlanCreatedRoute(days: numberOfDays));
    } else {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, introduce un número válido de días.')),
      );
    }
  }

  @override
  void dispose() {
    _daysController.dispose();
    super.dispose();
  }
}


