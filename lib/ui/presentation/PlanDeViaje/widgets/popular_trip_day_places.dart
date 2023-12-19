import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PopularTripDayPlaces extends StatefulWidget {
  final List<Map<String, dynamic>> day;
  final int dayNumber;
  final String planId;
  const PopularTripDayPlaces({
    Key? key,
    required this.day,
    required this.planId,
    required this.dayNumber,
  }) : super(key: key);

  @override
  State<PopularTripDayPlaces> createState() => _PopularTripDayPlaces();
}

class _PopularTripDayPlaces extends State<PopularTripDayPlaces> {
  final format = DateFormat('EEE, M/d/y');

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
                      ListTile(
                        title: Text(place["name"],
                            maxLines: 2, overflow: TextOverflow.fade),
                      ),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(place["imageUrl"]),
                                fit: BoxFit.cover)),
                      ),
                    ]));
              }))
    ]);
  }
}
