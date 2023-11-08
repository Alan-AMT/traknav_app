import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO: REMOVE
class CubitA extends Cubit<int> {
  CubitA() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

@RoutePage()
class SignUpPage extends StatefulWidget {
  final int id;
  const SignUpPage({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => CubitA(),
        child: BlocBuilder<CubitA, int>(builder: (context, count) {
          return Scaffold(
              appBar: AppBar(),
              // backgroundColor: Colors.red,
              body: SafeArea(
                  child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                                  child: Text(
                                    "$count qqa",
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  onPressed: () {})
                            ],
                          ),
                          // ElevatedButton(onPressed: () {}, child: const Text("")),
                          // // const SizedBox(height: 16),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const Text("", style: TextStyle(fontSize: 13)),
                          //     TextButton(
                          //         onPressed: () {}, //changes from signup
                          //         child:
                          //             const Text("", style: TextStyle(fontSize: 13)))
                          //   ],
                          // )
                        ],
                      )
                    ]),
              )));
        }));
  }
}
