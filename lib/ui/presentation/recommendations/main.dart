//Descomentar todo lo que tenga **

import 'package:flutter/material.dart';
import "widgets/opcion.dart";
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';

@RoutePage()
class RecommendationsPage extends StatefulWidget {
  const RecommendationsPage({super.key});

  @override
  State<RecommendationsPage> createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
          //backgroundColor: const Color.fromARGB(255, 255, 255, 255), //rgb(58, 172, 255).
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
          
              title: 
              //const Padding(
                //padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),child: 
                Text(AppLocalizations.of(context)!.recHello, style: TextStyle(
                    //color: Colors.black, // Establece el color de texto deseado
                  ),
                ),
              
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.0),
              child: Center(
               child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      //padding: EdgeInsets.only(all: 8.0),
                      padding: EdgeInsets.fromLTRB(38.0, 0.0, 38.0, 4.0),
                      child: Text(
                        AppLocalizations.of(context)!.recDescription,
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, 
                        //color: Colors.black,
                        
                      ),
                    ),
                    ),
                  ],
                ),
            ),
          ),
          ),
          body: 
            const BotonOpcion()
        );
  });
  }
}