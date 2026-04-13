import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/CardHistoricoTransacoes.dart';
import '../shared/SaldoCard.dart';
import '../shared/TopBarWidget.dart';

class HistoricoTransacoesContent extends StatefulWidget {
  const HistoricoTransacoesContent({super.key});

  @override
  State<HistoricoTransacoesContent> createState() => _HistoricoTransacoesContentState();
}

class _HistoricoTransacoesContentState extends State<HistoricoTransacoesContent> {


  final List<Map<String, dynamic>> historico = [
    {"tipo": "Crédito", "valor": 25.0, "data": "10/04/2026"},
    {"tipo": "Crédito", "valor": 30.0, "data": "09/04/2026"},
    {"tipo": "Crédito", "valor": 18.5, "data": "08/04/2026"},
    {"tipo": "Crédito", "valor": 42.0, "data": "07/04/2026"},
    {"tipo": "Crédito", "valor": 15.0, "data": "06/04/2026"},
  ];


  @override
  Widget build(BuildContext context) {


    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


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
                "Histórico de Transações",
                style: TextStyle(
                  fontSize: height * 0.03,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 20),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: historico.asMap().entries.map((entry) {
                    int index = entry.key;
                    var item = entry.value;

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index != historico.length - 1 ? 16 : 0,
                      ),
                      child: CardHistoricoRecargas(
                        tipo: item["tipo"],
                        valor: item["valor"],
                        data: item["data"],
                      ),
                    );
                  }).toList(),
                ),
              )

            ],
          )),
    );
  }
}
