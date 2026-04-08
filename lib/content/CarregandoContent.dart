import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/shared/CardFinalizar.dart';
import 'package:projeto_integrador/shared/CardRemoverForcado.dart';
import 'package:projeto_integrador/shared/CarregandoAtivoCard.dart';

import '../shared/ConectorCard.dart';
import '../shared/SaldoCard.dart';
import '../shared/TopBarWidget.dart';

class Carregandocontent extends StatefulWidget {
  const Carregandocontent({super.key});

  @override
  State<Carregandocontent> createState() => _CarregandocontentState();
}

class _CarregandocontentState extends State<Carregandocontent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,

      child: SafeArea(
        child: Column(
          children: [


            TopBarWidget(),

            SaldoCard(
              saldo: 20,
              onPressed: () {
                print("Carregar");
              },
            ),



            Expanded(
              child: Container(

                child: Column(
                  children: [


                    SizedBox(height: 20),

                    Expanded(
                        child: CarregandoAtivoCard()
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        CardFinalizar(
                          onPressed: () {
                          print("Finalizar");
                        },
                        ),

                        CardRemoverForcado(
                          onPressed: () {
                          print("Remover a força");
                        },
                        )
                      ],
                    )



                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
