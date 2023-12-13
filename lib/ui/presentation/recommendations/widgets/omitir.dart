import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

class ButtonOmitir extends StatelessWidget {
  const ButtonOmitir({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        AutoRouter.of(context).navigate(const HomeRoute());
      },
      child: const Text(
        'Omitir',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          fontSize:18,
        ),
      ),
    );
  }
}
