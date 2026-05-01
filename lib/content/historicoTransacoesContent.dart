import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/TransacaoCreditoDTO.dart';
import 'package:projeto_integrador/services/transacaoService.dart';
import 'package:projeto_integrador/services/websocket_service.dart';

import '../DTO/UsuarioDTO.dart';
import '../shared/cardHistoricoTransacoes.dart';
import '../shared/saldoCard.dart';
import '../shared/topBarWidget.dart';

class HistoricoTransacoesContent extends StatefulWidget {
  final UsuarioDTO usuario;





  const HistoricoTransacoesContent({super.key, required this.usuario});

  @override
  State<HistoricoTransacoesContent> createState() => _HistoricoTransacoesContentState();
}

class _HistoricoTransacoesContentState extends State<HistoricoTransacoesContent> {

  final TransacaoService transacaoService = TransacaoService();
  final WebSocketService webSocketService = WebSocketService();

  @override
  void initState() {
    super.initState();

    carregarTransacoes();


    if (widget.usuario.idUsuario == null) {
      throw Exception("Usuário sem ID");
    }

    webSocketService.conectar(
      userId: widget.usuario.idUsuario!.toString(),
      onMensagem: (msg) async {
        print("Recebeu WS: $msg");


        await carregarTransacoes();

      },
    );
  }

  List<TransacaoCreditoDTO>historico = [];


  Future<void>carregarTransacoes() async {

    try{

      final lista = await transacaoService.listarTransacoesCredito();

      setState(() {
        historico = lista;
      });
    } catch (e){
      print("Erro: $e");
    }
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


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
                        tipo: "Crédito",
                        valor: item.valorRecarga,
                        data: item.dataInicio,
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
