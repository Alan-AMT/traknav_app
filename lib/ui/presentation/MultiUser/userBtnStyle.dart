import 'package:flutter/material.dart';

class UserBtnStyle extends StatelessWidget {
  final String texto;
  final IconData icono;
  final VoidCallback? onPressed;

  const UserBtnStyle(
      {super.key, required this.texto, required this.icono, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(3),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)))),
          onPressed: onPressed,
          child: Row(
            children: [
              Icon(icono),
              Container(width: 15),
              Text(
                texto,
                style: const TextStyle(fontSize: 20),
              )
            ],
          )),
    );
  }
}
