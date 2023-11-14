import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:traknav_app/ui/presentation/home/widgets/main.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool isDisplayLanguages = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
          appBar:
              AppBar(title: Text(AppLocalizations.of(context)!.homeScaffold)),
          drawer: const SidebarMenu(),
          body: SafeArea(
              child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        AutoRouter.of(context).push(const SignInRoute());
                      },
                      child: const Text("Iniciar sesión")),
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
                              child: const Text("",
                                  style: TextStyle(fontSize: 13)))
                        ],
                      )
                    ],
                  )
                ]),
          )));
    });
  }
}
