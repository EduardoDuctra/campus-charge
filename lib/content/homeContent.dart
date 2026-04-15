import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/screens/conectoresScreen.dart';
import 'package:projeto_integrador/shared/carregadorCard.dart';
import 'package:projeto_integrador/shared/saldoCard.dart';

import '../shared/topBarWidget.dart';

class Homecontent extends StatefulWidget {
  const Homecontent({super.key});

  @override
  State<Homecontent> createState() => _HomecontentState();
}

class _HomecontentState extends State<Homecontent> {

  final List<String> carregadores = [
    "Carregador 01",
    "Carregador 02",
  ];


  void irParaConectores() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Conectoresscreen(),
      ),
    );
  }

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
                      child: Column(
                        children: carregadores.asMap().entries.map((entry) {
                          int index = entry.key;
                          String carregador = entry.value;

                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: index != carregadores.length - 1 ? 20 : 0,
                              ),
                              child: CardCarregador(
                                carregador: carregador,
                                onPressed: irParaConectores,
                              ),
                            ),
                          );
                        }).toList(),
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