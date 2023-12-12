import 'package:flutter/material.dart';
import 'package:traknav_app/ui/core/data/plan_de_viaje.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/core/data/plan_de_viaje.dart';
import 'package:skeletons/skeletons.dart';

class TripDayPlaces extends StatefulWidget {
  final List<Map<String, bool>> day;
  final int dayNumber;
  const TripDayPlaces({Key? key, required this.day, required this.dayNumber})
      : super(key: key);

  @override
  State<TripDayPlaces> createState() => _TripDayPlaces();
}

class _TripDayPlaces extends State<TripDayPlaces> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Día ${widget.dayNumber}"),
      SizedBox(
          height: 70,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemCount: widget.day.length,
              itemBuilder: (context, index) {
                final placeId = widget.day[index].keys.toList()[0];
                return FutureBuilder<Map<String, String>>(
                    initialData: {},
                    future: PlanDeViajeDataSource.fetchPlaceName(placeId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.hasError) {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: SkeletonListTile(hasSubtitle: true));
                      } else {
                        return SizedBox(
                          width: (MediaQuery.of(context).size.width * 0.94),
                          child: CheckboxListTile(
                            title: Text(snapshot.data!["name"]!),
                            value: widget.day[index][placeId],
                            onChanged: (bool? newValue) {
                              // _togglePlaceCompletion(
                              //     planIndex, dayIndex, placeIndex);
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        );
                      }
                    });
              })),
    ]);
  }
}
