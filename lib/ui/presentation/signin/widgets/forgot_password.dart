import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _submitted = false;

  String? _validateEmail(String value) {
    if (_submitted) {
      if (value.isEmpty) {
        return 'El correo electrónico es obligatorio.';
      } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
          .hasMatch(value)) {
        return 'Introduce un correo electrónico válido.';
      }
    }
    return null;
  }

  Future<void> _resetPassword(BuildContext context) async {
    setState(() {
      _submitted = true;
    });

    if (_validateEmail(_emailController.text) != null) {
      return;
    }

    try {
      // Verificar si el correo electrónico está registrado
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _emailController.text)
          .get();

      if (userSnapshot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('El correo electrónico no está registrado.'),
          ),
        );
        return;
      }

      // Restablecer la contraseña a través de Firebase
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);

      // Navegar a la pantalla de inicio de sesión después de restablecer
      AutoRouter.of(context).navigate(const SignInRoute());

      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Se ha enviado un correo para restablecer la contraseña.'),
        ),
      );
    } catch (e) {
      // Manejar errores
      print('Error al restablecer la contraseña: $e');

      // Mostrar mensaje de error al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Hubo un error al restablecer la contraseña. Intenta de nuevo.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/signin/olvidastecontra.JPG',
                    width: 260.0,
                    height: 260.0,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Center(
                    child: Container(
                      child: const Text('Recupera tu cuenta',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            fontSize: 27.0,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    width: 340.0,
                    child: const Text(
                      'Proporciona tu correo electrónico y se te enviará un correo con una contraseña provisional que podrás editar en la información de tu perfil.',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  TextField(
                    controller: _emailController,
                    enableInteractiveSelection: false,
                    decoration: InputDecoration(
                      hintText: 'Correo Electrónico *',
                      labelText: 'Correo Electrónico ',
                      suffixIcon: const Icon(Icons.alternate_email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      errorText: _validateEmail(_emailController.text),
                    ),
                  ),
                  const SizedBox(height: 60.0),
                  ElevatedButton(
                    onPressed: () => _resetPassword(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 15, 106, 180),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      fixedSize: const Size(400.0, 50.0),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      'Restablecer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}