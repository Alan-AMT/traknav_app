import 'package:flutter/material.dart';
import 'Item.dart';

//TOMA LA LISTA DE ITEMS Y LA PROCESA PARA CONVERTIRLA EN EL ExtensionPanelList
class BuildPanel extends StatefulWidget {
  final List<Item> data;
  const BuildPanel({super.key, required this.data});

  @override
  State<BuildPanel> createState() => _BuildPanelState();
}

class _BuildPanelState extends State<BuildPanel> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      dividerColor: Colors.white,
      expandIconColor: Colors.white,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.data[index].isExpanded = isExpanded;
        });
      },
      children: widget.data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          backgroundColor: const Color(0XFF237BBB),
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              textColor: Colors.white,
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            textColor: Colors.white,
            title: Text(
              item.expandedValue,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
