import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TripDayPlaces extends StatefulWidget {
  final List<Map<String, dynamic>> day;
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
          height: 300,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemCount: widget.day.length,
              itemBuilder: (context, index) {
                final place = widget.day[index];
                return SizedBox(
                    width: (MediaQuery.of(context).size.width * 0.94),
                    child: Column(children: [
                      CheckboxListTile(
                        title: Text(place["name"],
                            maxLines: 2, overflow: TextOverflow.fade),
                        value: place["visited"] ?? false,
                        onChanged: (bool? newValue) {
                          // _togglePlaceCompletion(
                          //     planIndex, dayIndex, placeIndex);
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(place["imageUrl"]),
                                fit: BoxFit.cover)),
                      )
                    ]));
              }))
    ]);
  }
}
