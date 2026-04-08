import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/shared/CarregadorCard.dart';
import 'package:projeto_integrador/shared/SaldoCard.dart';

import '../shared/TopBarWidget.dart';

class Homecontent extends StatefulWidget {
  const Homecontent({super.key});

  @override
  State<Homecontent> createState() => _HomecontentState();
}

class _HomecontentState extends State<Homecontent> {
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
                      child: CardCarregador(
                        carregador: "Carregador 01",
                        onPressed: () {
                          print("Carregar");
                        },
                      ),
                    ),

                    SizedBox(height: 20),

                    Expanded(
                      child: CardCarregador(
                        carregador: "Carregador 02",
                        onPressed: () {
                          print("Carregar");
                        },
                      ),
                    ),
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