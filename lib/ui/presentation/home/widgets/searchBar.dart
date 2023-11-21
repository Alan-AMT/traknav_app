import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:traknav_app/ui/presentation/map_search/widgets/search_form.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 17.0, right: 17.0),
      height: 50.0,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: List.generate(
          1,
          (index) => BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 5,
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.16),
          ),
        ),
      ),
      child: TextField(
        onTap: () async {
          final String? placeId = await showMaterialModalBottomSheet(
              context: context, builder: (context) => const SearchForm());
          print("******************");
          print(placeId);
          if (placeId == null) return;
        },
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 35,
          ),
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Color.fromARGB(129, 35, 34, 34),
            fontSize: 18.0,
            fontFamily: 'NUNITO_LIGHT',
          ),
          hintText: 'Hola, ¿A dónde vamos?',
        ),
      ),
    );
  }
}
