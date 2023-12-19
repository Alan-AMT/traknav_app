import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/MyProfile/modelo.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<Usuario?>? userInfo;

  Future<Usuario?> getUserInfo() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      User? user = auth.currentUser;

      if (user != null) {
        // El usuario está autenticado, puedes obtener su correo electrónico
        String uid = user.uid;
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await firestore.collection('users').doc(uid).get();

        // Verificar si el documento existe en Firestore
        if (snapshot.exists) {
          // Obtener los datos del usuario desde Firestore
          Map<String, dynamic> userData = snapshot.data()!;

          // Acceder a la información específica que necesitas
          String nombre = userData['name'];
          String ciudad = userData['city'];
          String tel = userData['phone'];

          String email = user.email!;

          Usuario userInf = Usuario(nombre, email, ciudad, tel);
          return userInf;
        }
      } else {
        // El usuario no está autenticado
        return null;
      }
    } catch (e) {
      // Manejar errores, si es necesario
      print('Error al obtener el correo electrónico: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    userInfo = getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.miCuenta),
          backgroundColor: state.isLightTheme
              ? const Color.fromRGBO(0, 71, 171, 1)
              : Colors.black,
        ),
        backgroundColor: state.isLightTheme
            ? const Color.fromRGBO(0, 71, 171, 1)
            : Colors.black,
        //------------------------body---------------------------------
        body: ListView(
          children: [
            Container(
                //padding: const EdgeInsets.only(left: 15, right: 15),
                child: Stack(
              children: [
                //este es el container más grande en el que todos se mueven
                Container(height: MediaQuery.of(context).size.height),
                //este es el container en el que sobrepone el icono
                Positioned(
                  top: 110,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color(0xffd9d9d9),
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                //Icono del usuario
                Positioned(
                    top: 50,
                    left: 20,
                    child: Container(
                      height: 140,
                      width: 140,
                      child: const CircleAvatar(
                        child: Icon(Icons.person, size: 140),
                        // backgroundImage:
                        // AssetImage('assets/MyProfile/yoyo.JPG'),
                      ),
                    )),
                //Botón de editar
                Positioned(
                  top: 165,
                  left: 180,
                  child: ElevatedButton(
                      onPressed: () {
                        AutoRouter.of(context)
                            .navigate(const EditProfileRoute());
                      },
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.editBtn,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Container(width: 5),
                          const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/MyProfile/edit.png'),
                              backgroundColor: Color.fromARGB(0, 0, 0, 0)),
                        ],
                      )),
                ),
                //Container donde se muetsra toda la info.
                Positioned(
                  top: 220,
                  left: 15,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      //height: 200,
                      width: MediaQuery.of(context).size.width - 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      // dentro de este future builder ya se puede tomar la info de la BD a través de mi clase
                      child: FutureBuilder(
                          future: userInfo,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(height: 10),
                                  Center(
                                      child: Text(
                                    snapshot.data!.nombreStr(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Container(height: 30),
                                  //Toda la info abajo del nombre
                                  Container(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .correoTxtField,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Container(width: 8),
                                            Flexible(
                                              child: Text(
                                                snapshot.data!.correoStr(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(height: 30),
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .ciudadTxtField,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(width: 8),
                                            Text(
                                              snapshot.data!.ubicacionStr(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        Container(height: 30),
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .telTxtField,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(width: 8),
                                            Text(
                                              snapshot.data!.telefonoStr(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        Container(height: 30),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return const Text("Error");
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      );
    });
  }
}
