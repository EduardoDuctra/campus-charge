import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/screens/carregandoScreen.dart';
import 'package:projeto_integrador/shared/conectorCard.dart';

import '../DTO/UsuarioDTO.dart';
import '../shared/carregadorCard.dart';
import '../shared/saldoCard.dart';
import '../shared/topBarWidget.dart';

class Conectorescontent extends StatefulWidget {
  final UsuarioDTO usuario;


  const Conectorescontent({super.key, required this.usuario});

  @override
  State<Conectorescontent> createState() => _ConectorescontentState();
}

class _ConectorescontentState extends State<Conectorescontent> {

  final List<String> conectores = [
    "Conector Rápido",
    "Conector Rápido",
    "Conector Alternado",
  ];

  void irParaCarregando() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarregandoScreen(usuario: widget.usuario,),
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

            TopBarWidget(usuario: widget.usuario),

            SaldoCard(
              saldo: widget.usuario.saldo ?? 0,
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
                      child: Column(
                        children: conectores.asMap().entries.map((entry) {
                          int index = entry.key;
                          String conector = entry.value;

                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: index != conectores.length - 1 ? 20 : 0,
                              ),
                              child: ConectorCard(
                                conector: conector,
                                nome: "Type 2",
                                onPressed: irParaCarregando,
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