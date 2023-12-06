import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traknav_app/ui/presentation/home/cubit/home_cubit.dart';
import 'package:traknav_app/ui/presentation/signin/widgets/forgot_password.dart';
import 'package:traknav_app/ui/presentation/signin/widgets/signin_form.dart';
import 'package:traknav_app/ui/presentation/signup/main.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  final String _selectedLanguage = 'MX';
  bool _isLogin = true;

  List<String> listaIdioma = ['MX', 'USA'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/signin/fondo.jpg'),
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
                  Image.asset('assets/signin/finallogo11.png'),
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
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          fixedSize: const Size(80.0, 45.0),
                          padding: EdgeInsets.zero,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.language),
                            const SizedBox(width: 8.0),
                            Text(_selectedLanguage),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 30.0,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: state.isLightTheme
                      ? Colors.white.withOpacity(1.0)
                      : Colors.black,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Column(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 21.0,
                        ),
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.signinWelcome,
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.signinAppTitle,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 15, 106, 180),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
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
                            fixedSize: const Size(160.0, 50.0),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.signinTapTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                        const SizedBox(
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
                            fixedSize: const Size(160.0, 50.0),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.signupTapTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _isLogin ? LoginForm() : SignUpForm(),
                    const Divider(
                      height: 30.0,
                    ),
                    const Divider(
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
                            AppLocalizations.of(context)!.signinForgotPass,
                            style: const TextStyle(
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
    });
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
              Text(
                AppLocalizations.of(context)!.changeLanguageTitle,
                style: const TextStyle(
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
                  context.read<HomeCubit>().changeLanguage(lang: "es");
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
                  context.read<HomeCubit>().changeLanguage(lang: "en");
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
}
