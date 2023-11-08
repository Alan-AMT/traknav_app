import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/app.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
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
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("TrakNav"),
          ),
          // drawerScrimColor: Colors.transparent,
          drawer: Drawer(
            child: Column(children: [
              SizedBox(
                height: 150,
                child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(13, 71, 161, 1),
                    ),
                    child: Center(
                      child: Text(
                        'Menú',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    )),
              ),
              Expanded(
                child: ListView(padding: EdgeInsets.zero, children: [
                  const ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Inicio'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Mi cuenta'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Mis Favoritos'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.flight),
                    title: Text('Plan de viaje'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.cloud),
                    title: Text('Clima'),
                  ),
                  const Divider(height: 25, thickness: 3),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Personalización")),
                  const ListTile(
                    leading: Icon(Icons.list),
                    title: Text(
                      'Modificar recomendaciones',
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text(
                      'Modificar idioma',
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
                        ? const Column(
                            children: [
                              ListTile(
                                title: Text(
                                  'Español',
                                  maxLines: 3,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  'Inglés',
                                  maxLines: 3,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          )
                        : null,
                  ),
                  ListTile(
                    leading: state.isLightTheme
                        ? const Icon(Icons.dark_mode)
                        : const Icon(Icons.light_mode),
                    // leading: Icon(Icons.dark_mode),
                    title: Text(
                      'Modo ${state.isLightTheme ? "oscuro" : "claro"}',
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                    ),
                    onTap: () {
                      context.read<HomeCubit>().changeThemeMode();
                    },
                  ),
                  const Divider(height: 25, thickness: 3),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Ayuda y soporte")),
                  const ListTile(
                      leading: Icon(Icons.help),
                      title: Text(
                        'Preguntas frecuentes',
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      )),
                  const Divider(height: 25, thickness: 3),
                  const ListTile(
                      leading: Icon(Icons.book),
                      title: Text(
                        'Manual de usuario',
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      )),
                  const ListTile(
                      leading: Icon(Icons.info),
                      title: Text(
                        'Acerca de',
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      )),
                  const ListTile(
                      leading: Icon(Icons.login_outlined),
                      title: Text(
                        'Cerrar sesión',
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      )),
                ]),
              )
            ]),
          ),
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
