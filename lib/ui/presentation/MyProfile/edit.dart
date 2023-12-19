import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/MyProfile/modelo.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@RoutePage()
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Future<Usuario?>? userInfo;
  TextEditingController controlName = TextEditingController();
  TextEditingController controlCorreo = TextEditingController();
  TextEditingController controlCiudad = TextEditingController();
  TextEditingController controlTel = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<Usuario?> getUserInfo() async {
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

          controlName.text = nombre;
          controlCorreo.text = email;
          controlCiudad.text = ciudad;
          controlTel.text = tel;

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
                        //     AssetImage('assets/MyProfile/yoyo.JPG'),
                      ),
                    )),

                //Container donde se muetsra toda la info.
                Positioned(
                  top: 220,
                  left: 15,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      //height: 300,
                      width: MediaQuery.of(context).size.width - 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      // dentro de este future builder ya se puede tomar la info de la BD a través de mi clase
                      child: FutureBuilder(
                          future: userInfo,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(height: 10),
                                    Center(
                                        child: Container(
                                            width: 200,
                                            //height: 50,
                                            child: TextFormField(
                                              controller: controlName, //NOMBRE
                                              decoration: InputDecoration(
                                                  errorMaxLines: 4,
                                                  border:
                                                      const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 1)),
                                                  labelText:
                                                      AppLocalizations.of(
                                                              context)!
                                                          .nameTxtField,
                                                  labelStyle: const TextStyle(
                                                      color: Colors.black)),
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              maxLines: null,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              validator: (value) {
                                                if (!RegExp(r'^[a-zA-Z ]+$')
                                                    .hasMatch(value!)) {
                                                  return AppLocalizations.of(
                                                          context)!
                                                      .nameTxtFieldErr;
                                                }
                                                return null;
                                              },
                                            ))),
                                    Container(height: 30),
                                    //--------------Toda la info abajo del nombre---------------------
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(width: 8),
                                              Flexible(
                                                child: Text(
                                                  snapshot.data!.correoStr(),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                  overflow: TextOverflow.fade,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(height: 20),
                                          Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .ciudadTxtField,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              Container(
                                                  width: 200,
                                                  //height: 50,
                                                  child: TextFormField(
                                                    controller: controlCiudad,
                                                    decoration: const InputDecoration(
                                                        errorMaxLines: 4,
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .black))),
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    validator: (value) {
                                                      if (!RegExp(
                                                              r'^[a-zA-ZÀ-ÖØ-öø-ÿ0-9\s.,-]+$')
                                                          .hasMatch(value!)) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .ciudadTxtFieldErr;
                                                      }
                                                      return null;
                                                    },
                                                  )),
                                            ],
                                          ),
                                          Container(height: 20),
                                          Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .telTxtField,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              Container(
                                                width: 200,
                                                //height: 50,
                                                child: TextFormField(
                                                  controller: controlTel,
                                                  decoration: const InputDecoration(
                                                      errorMaxLines: 8,
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black))),
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  validator: (value) {
                                                    if (!RegExp(
                                                            r'^(\+\d{1,3} )?\d{8,10}$')
                                                        .hasMatch(value!)) {
                                                      return AppLocalizations
                                                              .of(context)!
                                                          .telTxtFieldErr;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(height: 20),
                                          Center(
                                            //Si el formulario es correcto, se actualizan todos los datos en firebase y luego nos redirige a la página principal
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                if (_formKey.currentState!
                                                        .validate() ==
                                                    true) {
                                                  User? user = auth.currentUser;
                                                  if (user != null) {
                                                    String uid = user.uid;
                                                    await firestore
                                                        .collection('users')
                                                        .doc(uid)
                                                        .update({
                                                      'name': controlName.text
                                                    });
                                                    await firestore
                                                        .collection('users')
                                                        .doc(uid)
                                                        .update({
                                                      'city': controlCiudad.text
                                                    });
                                                    await firestore
                                                        .collection('users')
                                                        .doc(uid)
                                                        .update({
                                                      'phone': controlTel.text
                                                    });
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .succMsg)));
                                                  }

                                                  AutoRouter.of(context)
                                                      .navigate(
                                                          const HomeRoute());
                                                }
                                              },
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .saveBtn),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
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
