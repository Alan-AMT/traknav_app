import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/MultiUser/content.dart';

@RoutePage()
class MultiUserPage extends StatelessWidget {
  const MultiUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/MultiUser/bg1.png"),
                fit: BoxFit.fill,
                opacity: 0.7)),
        child: Column(
          children: [
            Container(
              height: 10,
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/MultiUser/logo.png"),
                      fit: BoxFit.fill)),
            ),
            Container(
              height: 60,
            ),
            const Content(),
          ],
        ),
      ),
    );
  }
}
