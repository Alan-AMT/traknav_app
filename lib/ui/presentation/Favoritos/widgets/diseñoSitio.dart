import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyButton extends StatefulWidget {
  @override
  _MyButtonState createState() => _MyButtonState();
  
}

class _MyButtonState extends State<MyButton> {
  
  bool _showMenu = false;

  void _toggleMenu() {
    setState(() {
      _showMenu = !_showMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: _toggleMenu,
          label: const Text('Compartir'), 
          icon: const Icon(
                              Icons.share, // Icono de compartir
                              size: 24.0,
                            ),
          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Color de fondo del botón
                              foregroundColor: Colors.white, // Color de texto del botón
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0), // Forma redondeada del botón
                              ),
                            ),
          //child: const Text('Compartir'),
        ),
        
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _showMenu ? MediaQuery.of(context).size.height / 6 : 0,
          child: _showMenu
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.link),
                    Image.asset('assets/favoritos/facebook.jpg', 
                      width: MediaQuery.of(context).size.width * 0.1,),
                    Image.asset('assets/favoritos/whatsapp.png', 
                      width: MediaQuery.of(context).size.width * 0.1,),
                    Image.asset('assets/favoritos/instagram.png', 
                      width: MediaQuery.of(context).size.width * 0.1,),
                  ],
                )
              : null,
        ),
      ],
    );
  }
}