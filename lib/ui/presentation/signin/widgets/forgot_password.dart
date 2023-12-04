import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

class ForgotPasswordPage extends StatelessWidget {
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
                    height: 20.0,
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
                    height: 20.0,
                  ),
                  Container(
                    width: 340.0,
                    child: const Text(
                      'Proporciona tu correo y responde la pregunta de seguridad, se te enviará un correo con una contraseña provisional que podrás editar en la información de tu perfil.',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  TextField(
                    enableInteractiveSelection: false,
                    decoration: InputDecoration(
                      hintText: 'Correo Electrónico *',
                      labelText: 'Correo Electrónico ',
                      suffixIcon: const Icon(Icons.alternate_email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  TextField(
                    enableInteractiveSelection: false,
                    decoration: InputDecoration(
                      hintText: '¿A qué primaria fuiste? *',
                      labelText: '¿A qué primaria fuiste? ',
                      suffixIcon: const Icon(Icons.help),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35.0),
                  ElevatedButton(
                    onPressed: () {
                      // Back para enviar el correo de restablecimiento de contraseña
                      AutoRouter.of(context).navigate(const SignInRoute());
                    },
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
