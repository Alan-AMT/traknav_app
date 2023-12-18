import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:traknav_app/ui/presentation/PlanDeViaje/cubit/plan_de_viaje_cubit.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:traknav_app/ui/presentation/map_search/cubit/map_search_cubit.dart';
import 'package:traknav_app/ui/presentation/signin/main.dart';
import 'package:traknav_app/ui/router/android.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

class TrakNavApp extends StatefulWidget {
  const TrakNavApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TrakNavApp();
}

class _TrakNavApp extends State<TrakNavApp> {
  final androidRouter = AndroidRouter();
  void configLoading(Color color) {
    EasyLoading.instance
      // ..indicatorWidget = const CupertinoActivityIndicator(
      //   radius: 20,
      // )
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..animationStyle = EasyLoadingAnimationStyle.opacity
      ..maskType = EasyLoadingMaskType.black
      ..indicatorSize = 20.0
      ..radius = 700.0
      ..boxShadow = <BoxShadow>[]
      ..backgroundColor = Colors.transparent
      ..indicatorColor = color
      // ..maskColor = color.withOpacity(0.2)
      ..userInteractions = false
      ..textColor = Colors.black
      ..dismissOnTap = false;
  }

  @override
  void initState() {
    super.initState();
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    if (brightness == Brightness.dark) {
      configLoading(Colors.blueAccent);
      // configLoading(primaryColorDark);
    } else {
      configLoading(Colors.blueAccent);
      // configLoading(primaryColorLight);
    }
  }

  @override
  Widget build(BuildContext context) {
    //TODO: LINK USER INSTANCE???? check login and sign up myevents
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeCubit(),
        ),
        BlocProvider(
          create: (_) => MapSearchCubit(),
        ),
        BlocProvider(
          create: (_) => PlanDeViajeCubit(),
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return MaterialApp.router(
          supportedLocales: const [
            Locale("en", "US"),
            Locale("es", "ES"),
          ],
          debugShowCheckedModeBanner: false,
          locale: state.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: EasyLoading.init(),
          themeMode: state.isLightTheme ? ThemeMode.light : ThemeMode.dark,
          routerConfig: androidRouter.config(),
          //TODO: Move to separated files
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromRGBO(13, 71, 161, 1),
                iconTheme: IconThemeData(color: Colors.white),
              ),
              textTheme: const TextTheme(
                  bodyLarge: TextStyle(color: Colors.black),
                  bodyMedium: TextStyle(color: Colors.black),
                  bodySmall: TextStyle(color: Colors.black),
                  headlineLarge: TextStyle(color: Colors.black),
                  headlineMedium: TextStyle(color: Colors.white)),
              drawerTheme: const DrawerThemeData(
                  backgroundColor: Colors.white,
                  shape: ContinuousRectangleBorder(
                      side: BorderSide(
                          color: Color.fromRGBO(13, 71, 161, 1), width: 12)))),
          darkTheme: ThemeData(
              brightness: Brightness.dark,
              canvasColor: Colors.black,
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.white),
                  // color: Colors.black,
                  backgroundColor: Color.fromRGBO(13, 71, 161, 1)),
              iconTheme: const IconThemeData(color: Colors.white),
              textTheme: const TextTheme(
                  bodyLarge: TextStyle(color: Colors.white),
                  headlineMedium: TextStyle(color: Colors.white)),
              drawerTheme: const DrawerThemeData(
                  backgroundColor: Colors.black,
                  shape: ContinuousRectangleBorder(
                      side: BorderSide(
                          color: Color.fromRGBO(13, 71, 161, 1), width: 10)))),
        );
      }),
    );
  }
}
