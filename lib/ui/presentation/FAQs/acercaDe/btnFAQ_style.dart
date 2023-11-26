import 'package:flutter/material.dart';

//WIDGET PARA CONSTRUIR LOS BOTONES DE LAS FAQs, reciben la image y el texto debajo ella
class BtnFAQ extends StatelessWidget {
  final String imgUrl;
  final String descripcion;
  final VoidCallback? onPressed;

  const BtnFAQ(
      {super.key,
      required this.imgUrl,
      required this.descripcion,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (2 / 5),
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF237BBB),
            elevation: 7,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: onPressed,
        child: Column(
          children: [
            Image.asset(imgUrl, width: 50, height: 50, fit: BoxFit.cover),
            Text(
              descripcion,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
