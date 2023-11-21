import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class PlaceDetail extends StatefulWidget {
  final String placeId;
  final String placeName;
  final String placeAdress;
  const PlaceDetail(
      {super.key,
      required this.placeId,
      required this.placeAdress,
      required this.placeName});

  @override
  State<PlaceDetail> createState() => _PlaceDetail();
}

class _PlaceDetail extends State<PlaceDetail> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(widget.placeName),
          subtitle: Text(widget.placeAdress),
          isThreeLine: true,
        ),
        Row(
          children: [
            Expanded(
                child: TextButton(
              child: Text("Ir a"),
              onPressed: () {},
            )),
            Expanded(
                child: TextButton(
              child: Text("Detalles"),
              onPressed: () {},
            ))
          ],
        )
      ],
    );
    // Scaffold(
    //     appBar: AppBar(
    //       title: Text(widget.placeId),
    //     ),
    //     body: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [Text(widget.placeId)]));
  }
}
