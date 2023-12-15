import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';

class ButtonOmitir extends StatefulWidget {
  const ButtonOmitir({super.key});

  @override
  State<ButtonOmitir> createState() => _ButtonOmitirState();
}

class _ButtonOmitirState extends State<ButtonOmitir> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return TextButton(
        onPressed: () {
          AutoRouter.of(context).navigate(const HomeRoute());
        },
        child: Text(
          AppLocalizations.of(context)!.recSkipButton,
          style: TextStyle(
             //color: Colors.black,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            fontSize:18,
          ),
        ),
      );
    }
    );
  }
}
