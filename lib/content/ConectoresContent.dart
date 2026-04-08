import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/shared/ConectorCard.dart';

import '../shared/CarregadorCard.dart';
import '../shared/SaldoCard.dart';
import '../shared/TopBarWidget.dart';

class Conectorescontent extends StatefulWidget {
  const Conectorescontent({super.key});

  @override
  State<Conectorescontent> createState() => _ConectorescontentState();
}

class _ConectorescontentState extends State<Conectorescontent> {
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


            SizedBox(height: 40),

            Text(
              'Escolha o conector',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),

            SizedBox(height: 40),

            Expanded(
              child: Container(

                child: Column(
                  children: [


                   

                    Expanded(
                      child: ConectorCard(
                          conector: "Conector Rápido",
                        onPressed: () {
                          print("Conector");
                        },
                      )
                    ),

                    SizedBox(height: 20),

                    Expanded(
                      child: ConectorCard(
                        conector: "Conector Rápido",
                        onPressed: () {
                          print("Conector");
                        },
                      ),
                    ),

                    SizedBox(height: 20),

                    Expanded(
                      child: ConectorCard(
                        conector: "Conector Alternado",
                        onPressed: () {
                          print("Conector");
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
