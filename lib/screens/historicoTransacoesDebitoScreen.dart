import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/TransacaoDebitoDTO.dart';

import '../DTO/UsuarioDTO.dart';
import '../services/transacaoService.dart';
import '../services/websocket_service.dart';
import '../shared/cardHistoricoRecargas.dart';
import '../shared/saldoCard.dart';
import '../shared/topBarWidget.dart';
import '../utils/modal_recarga.dart';

class HistoricoTransacoesDebitoScreen extends StatefulWidget {

  final UsuarioDTO usuario;

  const HistoricoTransacoesDebitoScreen({super.key, required this.usuario});

  @override
  State<HistoricoTransacoesDebitoScreen> createState() => _HistoricoTransacoesDebitoScreenState();
}

class _HistoricoTransacoesDebitoScreenState extends State<HistoricoTransacoesDebitoScreen> {

  final TransacaoService transacaoService = TransacaoService();


  @override
  void initState() {
    super.initState();
    carregarTransacoesDebito();
  }

  @override
  void didUpdateWidget(covariant HistoricoTransacoesDebitoScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.usuario.saldo != widget.usuario.saldo) {
      print("Saldo mudou, atualizando recargas...");
      carregarTransacoesDebito();
    }
  }

  List<TransacaoDebitoDTO>historico = [];



  //lista as transacoes -> coloca elas numa lista
  Future<void>carregarTransacoesDebito() async {

    try{

      final lista = await transacaoService.listarTransacoesDebito();

      setState(() {
        historico = lista;
      });
    } catch (e){
      print("Erro: $e");
    }
  }


  // =====================  BUILD  =========================== //


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
                  onPressed: () => abrirModalRecarga(context)
              ),

              SizedBox(height: 40),

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
                    var item = entry.value;

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index != historico.length - 1 ? 16 : 0,
                      ),
                      child: CardHistoricoRecargas(
                        tipo: "Débito",
                        potencia: item.recargaKwh,
                        valor: item.valorRecarga,
                        data: item.dataInicio,
                        modelo: item.modelo,
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
