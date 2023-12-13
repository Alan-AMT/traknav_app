import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/home/widgets/main.dart';

class SearchBarCustom extends StatefulWidget {
  const SearchBarCustom({Key? key}) : super(key: key);

  @override
  _SearchBarCustomState createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {
  final double borderValue = 35.0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(top: 2.0),
        shrinkWrap: true,
        children: [
          Container(
            height: 760.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderValue),
                topRight: Radius.circular(borderValue),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 18.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: SearchBarWidget(),
                ),
                SizedBox(
                  height: 30.0,
                ),
                AdviceWidget(),
                RecomendedWidget(),
                CategoryWidget(),
                ToolsWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
