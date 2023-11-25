import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyAppForm(),
    );
  }
}

class MyAppForm extends StatefulWidget {
  const MyAppForm({Key? key}) : super(key: key);

  @override
  State<MyAppForm> createState() => _MyAppFormState();
}

class _MyAppFormState extends State<MyAppForm> {
  String _selectedLanguage = 'MX';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/fondo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 60.0,
          ),
          children: <Widget>[
            Column(
              children: [
                Image.asset('images/finallogo11.png'),
                const SizedBox(height: 16.0),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 21.0),
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
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        fixedSize: const Size(80.0, 45.0),
                        padding: EdgeInsets.zero,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.language),
                              const SizedBox(width: 8.0),
                              Text(
                                _selectedLanguage,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 420.0),
            // Agregamos los dos botones uno debajo del otro

            ElevatedButton(
              onPressed: () {
                // Lógica del primer botón
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Lógica del segundo botón
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                //onPrimary: Colors.white.withOpacity(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    '¿No tienes cuenta? Registrate',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Nunito',
                      decoration: TextDecoration.combine([
                        TextDecoration.underline,
                      ]),
                    ),
                  ),
                ),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'SELECCIONA TU IDIOMA',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
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
                    const Text(
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
    String imagePath = 'images/';
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