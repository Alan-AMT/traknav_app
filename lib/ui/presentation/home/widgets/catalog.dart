import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WidgetCatalog extends StatelessWidget {
  const WidgetCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.homeRecomendedTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: CatalogScreen(),
      ),
    );
  }
}

class CatalogScreen extends StatelessWidget {
  final List<CatalogItem> catalogItems = [
    CatalogItem("Museo Frida Kahlo", "assets/home/R_1.png"),
    CatalogItem("Bellas Artes", "assets/home/R_2.png"),
    CatalogItem("Parque Bicentenario", "assets/home/R_3.png"),
    CatalogItem("Museo Frida Kahlo", "assets/home/R_4.png"),
    CatalogItem("Bellas Artes", "assets/home/R_5.png"),
    CatalogItem("Parque Bicentenario", "assets/home/R_6.png"),
    CatalogItem("Museo Frida Kahlo", "assets/home/R_1.png"),
    CatalogItem("Bellas Artes", "assets/home/R_2.png"),
    CatalogItem("Parque Bicentenario", "assets/home/R_3.png"),
    CatalogItem("Museo Frida Kahlo", "assets/home/R_4.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18.0,
        mainAxisSpacing: 18.0,
      ),
      itemCount: catalogItems.length,
      itemBuilder: (context, index) {
        return CatalogItemWidget(catalogItem: catalogItems[index]);
      },
    );
  }
}

class CatalogItem {
  final String name;
  final String imagePath;

  CatalogItem(this.name, this.imagePath);
}

class CatalogItemWidget extends StatelessWidget {
  final CatalogItem catalogItem;

  const CatalogItemWidget({required this.catalogItem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Aquí puedes manejar la navegación a la pantalla deseada
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(catalogItem: catalogItem),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.0),
        child: Card(
          child: Stack(
            children: [
              Image.asset(
                catalogItem.imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(7.0),
                ),
              ),
              Positioned(
                left: 10.0,
                bottom: 30,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    catalogItem.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
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

class DetailScreen extends StatelessWidget {
  final CatalogItem catalogItem;

  const DetailScreen({required this.catalogItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catalogItem.name),
      ),
      body: Center(
        child: Image.asset(catalogItem.imagePath),
      ),
    );
  }
}
