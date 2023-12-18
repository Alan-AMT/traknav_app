import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:traknav_app/ui/presentation/home/widgets/catalog.dart';

class AdviceWidget extends StatefulWidget {
  const AdviceWidget({Key? key}) : super(key: key);

  @override
  _AdviceWidgetState createState() => _AdviceWidgetState();
}

class _AdviceWidgetState extends State<AdviceWidget> {
  final double listPadding = 30.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0, left: 10.0, right: 10.0, bottom: 10.0),
      width: double.infinity,
      height: 153.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 20,
            top: 0,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(58, 172, 255, 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                constraints: BoxConstraints(maxWidth: 340.0, maxHeight: 135.0),
              ),
            ),
          ),
          Positioned(
            right: 95,
            top: 50,
            child: Image(
              image: AssetImage('assets/home/R_5-modified.png'),
              width: 25.0,
              height: 45.0,
            ),
          ),
          Positioned(
            right: 35,
            top: 15,
            child: Image(
              image: AssetImage('assets/home/R_3-modified.png'),
              width: 35.0,
              height: 45.0,
            ),
          ),
          Positioned(
            right: 60,
            top: 90,
            child: Image(
              image: AssetImage('assets/home/R_4-modified.png'),
              width: 19.0,
              height: 29.0,
            ),
          ),
          Positioned(
            right: 35,
            top: 67,
            child: Image(
              image: AssetImage('assets/home/Cwhite.png'),
              width: 15.0,
              height: 35.0,
            ),
          ),
          Positioned(
            right: 90,
            top: 85,
            child: Image(
              image: AssetImage('assets/home/Cwhite.png'),
              width: 20.0,
              height: 35.0,
            ),
          ),
          Positioned(
            right: 70,
            top: 38,
            child: Image(
              image: AssetImage('assets/home/Cwhite.png'),
              width: 20.0,
              height: 35.0,
            ),
          ),
          Positioned(
            top: 25,
            left: 55,
            child: Text(
              AppLocalizations.of(context)!.homeAdviceUp,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 52,
            left: 55,
            child: Text(
              AppLocalizations.of(context)!.homeAdviceDown,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 95,
            left: 55,
            child: GestureDetector(
              onTap: () {
                // Replace 'YourDestinationWidget()' with the widget you want to navigate to.
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => WidgetCatalog()));
              },
              child: Text(
                AppLocalizations.of(context)!.homeAdviceDiscover,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infCard() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 135.0,
          width: 370.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ModelAdvice {
  final String discover = 'Encuentra más lugares';
  final String button = 'Descubrir ahora';
}
