import 'package:flutter/material.dart';

class Clima {
  dynamic temperatura;
  dynamic nublado;
  dynamic probLluvia;
  String? lugar;
  String? fecha;

  Clima(
      this.temperatura, this.nublado, this.probLluvia, this.lugar, this.fecha);

  String fechaStr() {
    DateTime date = DateTime.parse(fecha!);
    return "${date.day}/${date.month}/${date.year}";
  }

  String? lugarStr() {
    return "$lugar";
  }
}
