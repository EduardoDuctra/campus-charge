import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/ConectorDTO.dart';
import 'package:projeto_integrador/screens/carregandoScreen.dart';
import 'package:projeto_integrador/services/conectorService.dart';
import 'package:projeto_integrador/services/transacaoService.dart';
import 'package:projeto_integrador/shared/conectorCard.dart';

import '../DTO/TransacaoAtivaDTO.dart';
import '../DTO/UsuarioDTO.dart';
import '../services/websocket_service.dart';
import '../shared/BotaoRemover.dart';
import '../shared/carregadorCard.dart';
import '../shared/saldoCard.dart';
import '../shared/topBarWidget.dart';

class Conectorescontent extends StatefulWidget {
  final UsuarioDTO usuario;
  final String idCarregador;




  const Conectorescontent({super.key, required this.usuario, required this.idCarregador});

  @override
  State<Conectorescontent> createState() => _ConectorescontentState();
}

class _ConectorescontentState extends State<Conectorescontent> {

  final TransacaoService transacaoService = TransacaoService();
  final ConectorService conectorService = ConectorService();
  final WebSocketService ws = WebSocketService();

  ConectorDTO? conectorRecente;
  bool carregando = true;


  List<ConectorDTO>conectores = [];


  @override
  void initState() {
    super.initState();

    carregarConectores();

    ws.conectarCarregador(
      idCarregador: widget.idCarregador,
      onMensagem: (msg) {

        print("Atualização recebida");

        carregarConectores();;
      },
    );
  }

  @override
  void dispose() {
    ws.desconectar();
    super.dispose();
  }

  Future<void> carregarConectores() async {

    final recente = await conectorService.buscarConectorRecente();

    if(recente != null){
      setState(() {
        conectorRecente = recente;
        conectores = [];
        carregando = false;
      });
    }  else {

      final lista = await conectorService.listarConectores(widget.idCarregador);

      setState(() {
        conectorRecente = null;
        conectores = lista;
        carregando = false;

      });
    }
  }

  Future<void> irParaCarregando() async {

    final transacao = await transacaoService.listarTransacoesAtiva();

    if(transacao!= null){

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CarregandoScreen(
              usuario: widget.usuario, transacaoAtiva: transacao),
        ),
      );
    }
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

                      //se for recente mostra somente ele
                      child: conectorRecente != null ?

                      Column(
                        children: [

                          ConectorCard(
                            dto: conectorRecente!,
                            onPressed: irParaCarregando,
                          ),

                          SizedBox(height: 180),

                          BotaoRemover(onPressed: () {

                          },
                          ),

                          SizedBox(height: 20),


                          Text(
                            'Caso o conector fique preso, force a retirada',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ]
                      )

                      :

                      Column(
                        children: conectores.asMap().entries.map((entry) {
                          int index = entry.key;
                          ConectorDTO dto = entry.value;

                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: index != conectores.length - 1 ? 20 : 0,
                              ),

                              child: ConectorCard(
                                dto: dto,
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