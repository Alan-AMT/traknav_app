import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:traknav_app/ui/config/toasts/main.dart';
import 'package:traknav_app/ui/presentation/PlanDeViaje/cubit/plan_de_viaje_cubit.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:traknav_app/ui/core/data/plan_de_viaje.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

@RoutePage()
class InitTripPlanPage extends StatefulWidget {
  final PlanDeViaje plan;
  const InitTripPlanPage({Key? key, required this.plan}) : super(key: key);

  @override
  State<InitTripPlanPage> createState() => _InitTripPlanPage();
}

class _InitTripPlanPage extends State<InitTripPlanPage> {
  @override
  void initState() {
    super.initState();
  }

  void showFinishPlanDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Finalizar plan de viaje"),
          content: Text(
              "¿Estas seguro de que quieres finalizar tu plan de viaje '${widget.plan.name}'? Esta acción es irreversible"),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cierra el diálogo
              },
            ),
            TextButton(
                child: Text(AppLocalizations.of(context)!.confirm),
                onPressed: () async {
                  EasyLoading.show();
                  await context
                      .read<PlanDeViajeCubit>()
                      .finishPlanDeViaje(id: widget.plan.id);
                  Navigator.of(dialogContext)
                      .pop(); // Cierra el cuadro de diálogo
                  EasyLoading.dismiss();
                  context.router.popUntil(
                      (route) => route.settings.name == TripPlanRoute.name);
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.plan.name,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontStyle: FontStyle.italic,
                fontSize: 30,
                color: Colors.white,
              ),
              overflow: TextOverflow.clip),
          actions: [
            TextButton(
                onPressed: () {
                  showFinishPlanDialog();
                },
                child: Text("Finalizar plan",
                    overflow: TextOverflow.clip,
                    style: TextStyle(color: Colors.white)))
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("hola"),
                );
              },
            ))
          ],
        ));
  }
}
