import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:country_icons/country_icons.dart';




  class LoginForm extends StatelessWidget {
    final Function(String) onEmailSubmitted;
    final Function(String) onPasswordSubmitted;

    const LoginForm({
      Key? key,
      required this.onEmailSubmitted,
      required this.onPasswordSubmitted,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Column(
        children: <Widget>[
          TextField(
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              hintText: 'Correo Electrónico',
              labelText: 'Correo Electrónico',
              suffixIcon: Icon(Icons.alternate_email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onSubmitted: onEmailSubmitted,
          ),
          SizedBox(
            height: 30.0,
          ),
          TextField(
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              hintText: 'Contraseña',
              labelText: 'Contraseña',
              suffixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onSubmitted: onPasswordSubmitted,
          ),
        ],
      );
    }
  }

  class RegisterForm extends StatelessWidget {
    final Function(String) onEmailSubmitted;
    final Function(String) onNameSubmitted;
    final Function(String) onTelefonoSubmitted;
    final Function(String) onPassword1Submitted;
    final Function(String) onPrimariaSubmitted;
    final Function(String) onCiudadSubmitted;

    const RegisterForm({
      Key? key,
      required this.onEmailSubmitted,
      required this.onNameSubmitted,
      required this.onTelefonoSubmitted,
      required this.onPassword1Submitted,
      required this.onPrimariaSubmitted,
      required this.onCiudadSubmitted,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Column(
        children: <Widget>[
          TextField(
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              hintText: 'Correo Electrónico',
              labelText: 'Correo Electrónico',
              suffixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onSubmitted: onEmailSubmitted,
          ),
          SizedBox(
            height: 30.0,
          ),
          TextField(
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              hintText: 'Nombre de Usuario',
              labelText: 'Nombre de Usuario',
              suffixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onSubmitted: onNameSubmitted,
          ),
          SizedBox(
            height: 30.0,
          ),
          TextField(
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              hintText: 'Telefóno',
              labelText: 'Telefóno',
              suffixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onSubmitted: onTelefonoSubmitted,
          ),
          SizedBox(
            height: 30.0,
          ),
          TextField(
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              hintText: 'Contraseña',
              labelText: 'Contraseña',
              suffixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onSubmitted: onPassword1Submitted,
          ),
          SizedBox(
            height: 30.0,
          ),
          TextField(
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              hintText: '¿A qué primaria fuiste?',
              labelText: '¿A qué primaria fuiste?',
              suffixIcon: Icon(Icons.help),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onSubmitted: onPrimariaSubmitted,
          ),
          SizedBox(
            height: 30.0,
          ),
          TextField(
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              hintText: '¿En qué ciudad vives?',
              labelText: '¿En qué ciudad vives?',
              suffixIcon: Icon(Icons.help),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onSubmitted: onCiudadSubmitted,
          ),
        ],
      );
    }
  }

  class ForgotPasswordPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
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
                SizedBox(
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
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 340.0,
                  child: const Text(
                    'Proporciona tu correo y responde la pregunta de seguridad, se te enviará un correo con una contraseña provicional que podrás editar en la información de tu perfil.',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                TextField(
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    hintText: 'Correo Electrónico *',
                    labelText: 'Correo Electrónico ',
                    suffixIcon: Icon(Icons.alternate_email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                TextField(
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                    hintText: '¿A qué primaria fuiste? *',
                    labelText: '¿A qué primaria fuiste? ',
                    suffixIcon: Icon(Icons.help),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 35.0),
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
                    fixedSize: Size(400.0, 50.0),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
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
      );
    }
  }
@RoutePage()
  class SignInPage extends StatefulWidget {
    const SignInPage({Key? key}) : super(key: key);

    @override
    State<SignInPage> createState() => _SignInPage();
  }

  class _SignInPage extends State<SignInPage> {
    String _email = '';
    String _password = '';
    String _email1 = '';
    String _name = '';
    String _telefono = '';
    String _password1 = '';
    String _primaria = '';
    String _ciudad = '';
    String _selectedLanguage = 'MX';
    bool _isLogin = true;

    List<String> listaIdioma = ['MX', 'USA'];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/signin/fondo.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(
              vertical: 60.0,
            ),
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    Image.asset('assets/signin/finallogo11.png'),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 21.0),
                child: IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showLanguageMenu(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          fixedSize: Size(80.0, 45.0),
                          padding: EdgeInsets.zero,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.language),
                            SizedBox(width: 8.0),
                            Text(_selectedLanguage),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 30.0,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(1.0),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Column(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Nunito',
                          fontSize: 21.0,
                        ),
                        children: [
                          TextSpan(
                            text: 'Bienvenido a ',
                          ),
                          TextSpan(
                            text: 'TRAKNAV',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 15, 106, 180),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isLogin
                                ? const Color.fromARGB(255, 15, 106, 180)
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            fixedSize: Size(160.0, 50.0),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !_isLogin
                                ? const Color.fromARGB(255, 15, 106, 180)
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            fixedSize: Size(160.0, 50.0),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            'Registrarse',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    _isLogin
                        ? LoginForm(
                            onEmailSubmitted: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                            onPasswordSubmitted: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                          )
                        : RegisterForm(
                            onEmailSubmitted: (value) {
                              setState(() {
                                _email1 = value;
                              });
                            },
                            onNameSubmitted: (value) {
                              setState(() {
                                _name = value;
                              });
                            },
                            onTelefonoSubmitted: (value) {
                              setState(() {
                                _telefono = value;
                              });
                            },
                            onPassword1Submitted: (value) {
                              setState(() {
                                _password1 = value;
                              });
                            },
                            onPrimariaSubmitted: (value) {
                              setState(() {
                                _primaria = value;
                              });
                            },
                            onCiudadSubmitted: (value) {
                              setState(() {
                                _ciudad = value;
                              });
                            },
                          ),
                    Divider(
                      height: 30.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          if (_isLogin) {
                            AutoRouter.of(context).navigate(const HomeRoute());
                            print('Iniciando sesión con $_email y $_password');
                          } else {
                            AutoRouter.of(context).navigate(const RecommendationsRoute());
                            print('Registrando con $_email y $_password');
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 15, 106, 180),
                          padding: EdgeInsets.all(13.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                        child: Text(
                          _isLogin ? 'Iniciar Sesión' : 'Registrarse',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 3.0,
                    ),
                    if (_isLogin)
                      SizedBox(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    void _showLanguageMenu(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'SELECCIONA TU IDIOMA',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MX - Español',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                        ),
                      ),
                      getCountryFlagIcon('MX'),
                    ],
                  ),
                  onTap: () {
                    _updateLanguage('MX');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'US - English',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                        ),
                      ),
                      getCountryFlagIcon('US'),
                    ],
                  ),
                  onTap: () {
                    _updateLanguage('US');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    Image getCountryFlagIcon(String countryCode) {
      String imagePath = 'assets/signin/';
      String flagFileName = '';

      switch (countryCode) {
        case 'MX':
          flagFileName = 'mexico.png';
          break;
        case 'US':
          flagFileName = 'estados unidos.png';
          break;
      }
      return Image.asset(
        '$imagePath$flagFileName',
        width: 50.0,
        height: 30.0,
      );
    }

    void _updateLanguage(String countryCode) {
      setState(() {
        _selectedLanguage = countryCode;
      });
    }
  }