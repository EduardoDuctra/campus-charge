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
import '../utils/modal_recarga.dart';

class ConectoresSreen extends StatefulWidget {

  //recebe o usuario + idCarregador da tela anterior
  final UsuarioDTO usuario;
  final String idCarregador;
  final VoidCallback onVoltar;


  const ConectoresSreen({super.key,
    required this.usuario,
    required this.idCarregador,
    required this.onVoltar});

  @override
  State<ConectoresSreen> createState() => _ConectoresSreenState();
}

class _ConectoresSreenState extends State<ConectoresSreen> {

  final TransacaoService transacaoService = TransacaoService();
  final ConectorService conectorService = ConectorService();

  //usado para ver se tenho resposta na minha API nessa url
  ConectorDTO? conectorRecente;
  bool carregando = true;


  List<ConectorDTO>conectores = [];


  @override
  void initState() {
    super.initState();

    carregarConectores();

    WebSocketService().conectarCarregador(
      idCarregador: widget.idCarregador,
      onMensagem: (msg) async {
        print("WS CONECTORES: atualização");

        await carregarConectores(); // 🔥 AQUI resolve
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  //
  // //se mudou -> atualiza
  // @override
  // void didUpdateWidget(covariant ConectoresSreen oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //
  //   if (oldWidget.usuario.saldo != widget.usuario.saldo) {
  //     print("Atualizando conectores por mudança de estado...");
  //     carregarConectores();
  //   }
  // }


  Future<void> carregarConectores() async {

    final recente = await conectorService.buscarConectorRecente();

    if (!mounted) return; // 🔥 ESSENCIAL (ANTES de qualquer setState)

    if(recente != null){

      setState(() {
        conectorRecente = recente;
        conectores = [];
        carregando = false;
      });

    } else {

      final lista = await conectorService.listarConectores(widget.idCarregador);

      if (!mounted) return; // 🔥 aqui também

      setState(() {
        conectorRecente = null;
        conectores = lista;
        carregando = false;
      });
    }
  }


  // =====================  BUILD  =========================== //


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,

      body: SafeArea(
        child: Column(
          children: [

            TopBarWidget(usuario: widget.usuario),

            SaldoCard(
              saldo: widget.usuario.saldo ?? 0,
                onPressed: () => abrirModalRecarga(context)
            ),

            SizedBox(height: 40),

            Stack(
              alignment: Alignment.center,
              children: [


                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: widget.onVoltar,
                    color: Colors.white,
                    iconSize: 30,
                  ),
                ),


                Text(
                  'Escolha o conector',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
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
                            onPressed: (){
                              print("Implementar comando");
                            },
                          ),

                          SizedBox(height: 160),

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
                                onPressed: (){
                                  print("Implementar comando");
                                },
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