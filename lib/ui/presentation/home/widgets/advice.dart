import 'package:flutter/material.dart';

class AdviceWidget extends StatelessWidget {
  const AdviceWidget({super.key});
  final double listPadding = 30.0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 30.0),
            height: 137.0,
            width: 333.0,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 73, 173, 255),
              borderRadius: BorderRadius.circular(13.0),
            ),
            //ponemos imagen de fondo centrada
            child: Center(
              child: Image.asset(
                'assets/home/advice.png',
                height: 200.0,
                width: 420.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  infCard() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 135.0,
          width: 370.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10.0,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ModelAdvice {
  final String discover = 'Encuentra más lugares';
  final String button = 'Descubrir ahora';
}
