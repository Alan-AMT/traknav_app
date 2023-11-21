import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:traknav_app/ui/presentation/FAQs/InformacionGeneral/informacionGeneral.dart';
import 'package:traknav_app/ui/presentation/FAQs/acercaDe/btnFAQ_style.dart';
import 'package:traknav_app/ui/presentation/FAQs/politicas/politicas.dart';
import 'package:traknav_app/ui/presentation/FAQs/problemasTecnicos/problemasTecnicos.dart';
import 'package:traknav_app/ui/router/android.gr.dart';

class Btns extends StatelessWidget {
  const Btns({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 35,
        ),
        //-----primera fila de botones (Perfil de usuario e info.)---------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BtnFAQ(
              imgUrl: 'assets/FAQs/usuario.png',
              descripcion: "Perfil de Usuario",
              onPressed: () {
                AutoRouter.of(context).navigate(const PerfilUsuarioRoute());
              },
            ),
            BtnFAQ(
              imgUrl: 'assets/FAQs/info.png',
              descripcion: "Información general",
              onPressed: () {
                AutoRouter.of(context)
                    .navigate(const InformacionGeneralRoute());
              },
            ),
          ],
        ),
        Container(
          height: 35,
        ),
        //--------segunda fila de botones (problemas técnicos y políticas)--------------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BtnFAQ(
              imgUrl: 'assets/FAQs/alerta.png',
              descripcion: "Problemas técnicos",
              onPressed: () {
                AutoRouter.of(context).navigate(const ProblemasTecnicosRoute());
              },
            ),
            BtnFAQ(
              imgUrl: 'assets/FAQs/privacidad.png',
              descripcion: "Políticas de privacidad",
              onPressed: () {
                AutoRouter.of(context).navigate(const PoliticasRoute());
              },
            ),
          ],
        )
      ],
    );
  }
}
