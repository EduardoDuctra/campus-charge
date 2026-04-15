import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/cardHistoricoRecargas.dart';
import '../shared/topBarWidget.dart';

class HistoricoRecargasContent extends StatefulWidget {
  const HistoricoRecargasContent({super.key});

  @override
  State<HistoricoRecargasContent> createState() => _HistoricoRecargasContentState();
}

class _HistoricoRecargasContentState extends State<HistoricoRecargasContent> {


  final List<Map<String, dynamic>> historico = [
    {"tipo": "Débito", "potencia": 25, "valor": 25.0, "data": "10/04/2026"},
    {"tipo": "Débito", "potencia": 30, "valor": 30.0, "data": "09/04/2026"},
    {"tipo": "Débito", "potencia": 18.5, "valor": 18.5, "data": "08/04/2026"},
    {"tipo": "Débito", "potencia": 42, "valor": 42.0, "data": "07/04/2026"},
    {"tipo": "Débito", "potencia": 15, "valor": 15.0, "data": "06/04/2026"},
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


              SizedBox(height: 20),

              Text(
                "Histórico de Recargas",
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
                    Map<String, dynamic> item = entry.value;

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index != historico.length - 1 ? 16 : 0,
                      ),
                      child: CardHistoricoRecargas(
                        tipo: item["tipo"],
                        potencia: (item["potencia"] as num).toDouble(),
                        valor: (item["valor"] as num).toDouble(),
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
