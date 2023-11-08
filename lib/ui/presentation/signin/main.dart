import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
            child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      AutoRouter.of(context).push(SignUpRoute(id: 1));
                    },
                    child: const Text("Sign up")),
                // CircleAvatar(
                //   backgroundColor: Theme.of(context).primaryColorDark,
                //   child: Image.asset("assets/images/signin_logo.png"),
                //   maxRadius: 100,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                            child: const Text(
                              "hola",
                              style: TextStyle(fontSize: 13),
                            ),
                            onPressed: () {})
                      ],
                    ),
                    ElevatedButton(onPressed: () {}, child: const Text("")),
                    // const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("", style: TextStyle(fontSize: 13)),
                        TextButton(
                            onPressed: () {}, //changes from signup
                            child:
                                const Text("", style: TextStyle(fontSize: 13)))
                      ],
                    )
                  ],
                )
              ]),
        )));
  }
}
