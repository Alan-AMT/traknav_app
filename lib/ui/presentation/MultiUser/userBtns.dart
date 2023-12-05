import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/MultiUser/userBtnStyle.dart';

class UsersBtns extends StatelessWidget {
  const UsersBtns({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 10,
        ),
        const UserBtnStyle(
            texto: "Juanito Bananas", icono: Icons.supervised_user_circle),
        Container(
          height: 7,
        ),
        const UserBtnStyle(
            texto: "Conejo Malo", icono: Icons.supervised_user_circle),
        Container(
          height: 10,
        )
      ],
    );
  }
}
