import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/router/android.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Categoria {
  int id;
  String nombre;
  String foto;

  Categoria(this.id, this.nombre, this.foto);
}

@RoutePage()
class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final opciones = [
      Categoria(
          1, AppLocalizations.of(context)!.recPopular, "Sitios_populares.png"),
      Categoria(2, AppLocalizations.of(context)!.recMuseum, "Museos.png"),
      Categoria(
          3, AppLocalizations.of(context)!.recRestaurants, "Restaurantes.png"),
      Categoria(4, AppLocalizations.of(context)!.recLocalCommerce,
          "Comercio_local.png"),
      Categoria(5, AppLocalizations.of(context)!.recHistorical,
          "Patrimonio_historico.png"),
      Categoria(6, AppLocalizations.of(context)!.recLodgment, "Hospedaje.png"),
      Categoria(7, AppLocalizations.of(context)!.recParks, "Parques.png"),
      Categoria(
          8, AppLocalizations.of(context)!.recGuided, "Visitas_guiadas.png"),
    ];
    return Scaffold(
        backgroundColor:
            const Color.fromARGB(255, 255, 255, 255), //rgb(58, 172, 255).
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
        
            title: 
            //const Padding(
              //padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),child: 
              Text('¡Hola!', style: TextStyle(
                  color: Colors.black, // Establece el color de texto deseado
                ),
              ),
            
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: Center(
             child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    //padding: EdgeInsets.only(all: 8.0),
                    padding: EdgeInsets.fromLTRB(38.0, 0.0, 38.0, 4.0),
                    child: Text(
                      'Para personalizar tus recomendaciones de manera óptima, ¡cuéntanos un poco sobre tus gustos e intereses en viajes!',
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black,
                      
                    ),
                  ),
                  ),
                /*TextButton(
                  onPressed: () {
                  // Aquí se define la acción que se ejecuta al presionar el botón de omitir
                },
                child: Text('Omitir', style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
              ),*/
                ],
              ),
          ),
        ),
        ),
        body: 
        Center(
        child:
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.83,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 58, 172, 255),
            
          borderRadius: BorderRadius.circular(20),
        ),
        child:
         Column(children: [
          Expanded(
              child: GridView.builder(
                  itemCount: opciones.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: ((context, index) {
                    return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(180, 230, 230, 230), //rgb(0, 187, 164).
                            borderRadius: BorderRadius.circular(10)),
                        child: /*Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/${opciones[index].foto}",
                                width: 100),
                            Text(
                              opciones[index].nombre,
                              style: TextStyle(color: Colors.black,),
                            )
                          ],
                        )*/
                        Column( 
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: [ 
                        InkWell( onTap: () { 
                          // Aquí se define la acción que se ejecuta al presionar el botón 
                        }, 
                        child: Image.asset('assets/${opciones[index].foto}', 
                                width: 100), ), 
                        Text( opciones[index].nombre, style: TextStyle(color: Colors.black,), 
                        ) 
                        ], 
                        )
                        );
                  }))),
          Row(
            children: [
              Expanded(flex : 5, child:
              
              
              Text('0/3 seleccionados',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            Theme.of(context).textTheme.titleLarge!.fontSize)),
              //Expanded(child: 
              ),
              Expanded(flex : 4, child:
              ElevatedButton(
                
                onPressed: () {
                  AutoRouter.of(context).navigate(const HomeRoute());
                },
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ))),
                child: Text('Siguiente',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.titleLarge!.fontSize)),
              )
              ),

             //)
            ],
          )
        ]
        )
        ),
        ),
        
      );
  }
}
