import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:permission_handler/permission_handler.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SidebarMenu();
}

class _SidebarMenu extends State<SidebarMenu> {
  bool isDisplayLanguages = false;
  void _close() {
    Navigator.pop(context);
  }

  Future<void> _allowLocation() async {
    try {
      Permission permission;
      permission = Permission.location;
      await permission.request();
      final status = await permission.status;
      if (status.isDenied || status.isPermanentlyDenied) {
        await openAppSettings();
      } else if (status.isRestricted) {
        print("mamo");
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Drawer(
        child: Column(children: [
          SizedBox(
            height: 150,
            child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(13, 71, 161, 1),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.homeSidemenuTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )),
          ),
          Expanded(
            child: ListView(padding: EdgeInsets.zero, children: [
              ListTile(
                leading: const Icon(Icons.home),
                title: Text(AppLocalizations.of(context)!.homeSidemenuHome),
                onTap: () {
                  //al presionar Home manda a la pantalla de incio
                  AutoRouter.of(context).navigate(const HomeRoute());
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(AppLocalizations.of(context)!.homeSidemenuProfile),
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: Text(AppLocalizations.of(context)!.homeSidemenuMap),
                onTap: () async {
                  await _allowLocation();
                  _close();
                  AutoRouter.of(context).navigate(const MapSearchRoute());
                },
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: Text(AppLocalizations.of(context)!.homeSidemenuFavs),
                onTap: () {
                  AutoRouter.of(context).navigate(const FavoritosRoute());
                },
              ),
              ListTile(
                leading: const Icon(Icons.flight),
                title: Text(AppLocalizations.of(context)!.homeSidemenuPlan),
                onTap: () {
                  AutoRouter.of(context).navigate(const TripPlanRoute());
                },
              ),
              ListTile(
                leading: const Icon(Icons.cloud),
                title: Text(AppLocalizations.of(context)!.homeSidemenuWeather),
                onTap: () {
                  AutoRouter.of(context).navigate(const ClimaRoute());
                },
              ),
              const Divider(height: 25, thickness: 3),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child:
                      Text(AppLocalizations.of(context)!.homeSidemenuCustom)),
              ListTile(
                leading: const Icon(Icons.list),
                title: Text(
                  AppLocalizations.of(context)!.homeSidemenuRecommendations,
                  maxLines: 3,
                  overflow: TextOverflow.fade,
                ),
                onTap: () {
                  AutoRouter.of(context).navigate(const RecommendationsRoute());
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(
                  AppLocalizations.of(context)!.homeSidemenuLang,
                  maxLines: 3,
                  overflow: TextOverflow.fade,
                ),
                trailing: isDisplayLanguages
                    ? const Icon(Icons.arrow_drop_up_sharp)
                    : const Icon(Icons.arrow_drop_down_sharp),
                onTap: () {
                  setState(() {
                    isDisplayLanguages = !isDisplayLanguages;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: isDisplayLanguages
                    ? Column(
                        children: [
                          ListTile(
                            title: Text(
                              AppLocalizations.of(context)!.homeSidemenuLangEs,
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                            ),
                            leading: const CircleAvatar(
                                maxRadius: 18,
                                backgroundImage: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Flag_of_Mexico.svg/980px-Flag_of_Mexico.svg.png")),
                            onTap: () {
                              context
                                  .read<HomeCubit>()
                                  .changeLanguage(lang: "es");
                            },
                          ),
                          ListTile(
                            title: Text(
                              AppLocalizations.of(context)!.homeSidemenuLangEn,
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                            ),
                            leading: const CircleAvatar(
                                maxRadius: 18,
                                backgroundImage: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Flag_of_the_United_States_%281845%E2%80%931846%29.svg/1280px-Flag_of_the_United_States_%281845%E2%80%931846%29.svg.png")),
                            onTap: () {
                              context
                                  .read<HomeCubit>()
                                  .changeLanguage(lang: "en");
                            },
                          ),
                        ],
                      )
                    : null,
              ),
              ListTile(
                leading: state.isLightTheme
                    ? const Icon(Icons.dark_mode)
                    : const Icon(Icons.light_mode),
                title: Text(
                  state.locale == const Locale("es")
                      ? AppLocalizations.of(context)!.homeSidemenuTheme(
                          state.isLightTheme ? "oscuro" : "claro")
                      : AppLocalizations.of(context)!.homeSidemenuTheme(
                          state.isLightTheme ? "Dark" : "Light"),
                  maxLines: 3,
                  overflow: TextOverflow.fade,
                ),
                onTap: () {
                  context.read<HomeCubit>().changeThemeMode();
                },
              ),
              const Divider(height: 25, thickness: 3),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child:
                      Text(AppLocalizations.of(context)!.homeSidemenuSupport)),
              ListTile(
                leading: const Icon(Icons.help),
                title: Text(
                  AppLocalizations.of(context)!.homeSidemenuQuestions,
                  maxLines: 3,
                  overflow: TextOverflow.fade,
                ),
                onTap: () {
                  AutoRouter.of(context).navigate(const FAQsRoute());
                },
              ),
              const Divider(height: 25, thickness: 3),
              ListTile(
                  leading: const Icon(Icons.book),
                  title: Text(
                    AppLocalizations.of(context)!.homeSidemenuGuide,
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                  )),
              ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(
                    AppLocalizations.of(context)!.homeSidemenuAboutUs,
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                  ),
                  onTap: () {
                    AutoRouter.of(context).navigate(const AcercaDe());
                  }),
              ListTile(
                leading: const Icon(Icons.login_outlined),
                title: Text(
                  AppLocalizations.of(context)!.homeSidemenuSignOut,
                  maxLines: 3,
                  overflow: TextOverflow.fade,
                ),
                onTap: () {
                  _close();
                  FirebaseAuth.instance.signOut();
                },
              ),
            ]),
          )
        ]),
      );
    });
  }
}
