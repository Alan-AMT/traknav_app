import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:traknav_app/ui/presentation/home/widgets/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

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
    FirebaseAuth.instance.userChanges().listen((User? user) async {
      if (user == null) {
        AutoRouter.of(context).pushAndPopUntil(const SignInRoute(),
            predicate: (Route<dynamic> route) => false);
      }
    });
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.homeScaffold),
            actions: [
              CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: IconButton(
                    icon: const Icon(
                      Icons.account_circle_sharp,
                    ),
                    onPressed: () {
                      AutoRouter.of(context).navigate(const ProfileRoute());
                    },
                  )),
            ],
          ),
          drawer: const SidebarMenu(),
          body: const SafeArea(
            child: Column(children: [SearchBarCustom()]),
          ));
    });
  }
}
