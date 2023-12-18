import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:traknav_app/ui/core/data/plan_de_viaje.dart';
import 'package:traknav_app/ui/presentation/PlanDeViaje/cubit/plan_de_viaje_cubit.dart';

class ShowPlan extends StatefulWidget {
  final PlanDeViaje plan;
  const ShowPlan({Key? key, required this.plan}) : super(key: key);

  @override
  State<ShowPlan> createState() => _ShowPlan();
}

class _ShowPlan extends State<ShowPlan> {
  final format = DateFormat("EEE, d/M/y");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanDeViajeCubit, PlanDeViajeState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.plan.name,
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
        body: ListView.builder(
          itemCount: widget.plan.days.length,
          itemBuilder: (context, index) {
            final day = widget.plan.days[index + 1];
            final date =
                DateTime.fromMillisecondsSinceEpoch(widget.plan.startDate)
                    .add(Duration(days: index));
            return Column(children: [
              const SizedBox(height: 10),
              Text("Día ${index + 1} - ${format.format(date)}"),
              Column(
                  children: day!
                      .map((item) => ListTile(
                          title: Text(item["name"]),
                          trailing: item["visited"]
                              ? const Icon(Icons.check_box_rounded)
                              : const Icon(
                                  Icons.check_box_outline_blank_sharp)))
                      .toList()),
              const Divider(thickness: 2)
            ]);
          },
        ),
      );
    });
  }
}
