import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/TransacaoAtivaDTO.dart';
import 'package:projeto_integrador/shared/cardFinalizar.dart';
import 'package:projeto_integrador/shared/carregandoAtivoCard.dart';
import 'package:projeto_integrador/shared/valorRecargaCard.dart';
import 'package:projeto_integrador/theme/colors.dart';

import '../DTO/UsuarioDTO.dart';
import '../services/transacaoService.dart';
import '../services/websocket_service.dart';
import '../shared/conectorCard.dart';
import '../shared/saldoCard.dart';
import '../shared/topBarWidget.dart';

class Carregandocontent extends StatefulWidget {

  final UsuarioDTO usuario;

  const Carregandocontent({super.key, required this.usuario});

  @override
  State<Carregandocontent> createState() => _CarregandocontentState();
}

class _CarregandocontentState extends State<Carregandocontent> {

  final TransacaoService transacaoService = TransacaoService();
  final WebSocketService webSocketService = WebSocketService();

  TransacaoAtivaDTO? transacaoAtiva;

  @override
  void initState() {
    super.initState();

    carregarTransacaoAtiva();


    if (widget.usuario.idUsuario == null) {
      throw Exception("Usuário sem ID");
    }

    webSocketService.conectar(
      userId: widget.usuario.idUsuario!.toString(),
      onMensagem: (msg) async {
        print("Recebeu WS: $msg");


        await carregarTransacaoAtiva();

      },
    );
  }



  Future<void>carregarTransacaoAtiva() async {

    try{

      final transacao = await transacaoService.listarTransacoesAtiva();

      setState(() {
        transacaoAtiva = transacao;
      });
    } catch (e){
      print("Erro: $e");

      setState(() {
        transacaoAtiva = null;
      });

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

            SizedBox(height: 20,),

            Valorrecargacard(

              valor: transacaoAtiva?.valorRecarga ?? 0,

              //modal valor
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {

                    TextEditingController controller = TextEditingController();

                    return AlertDialog(
                      title: Text("Informe o valor da recarga"),

                      content: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Ex: 20",

                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.principal),
                          ),

                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.principal,
                              width: 2
                            )
                          )
                        ),
                      ),

                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancelar",
                            style: TextStyle(color: Colors.black),
                          ),

                        ),

                        TextButton(
                          onPressed: () {
                            print("Valor digitado: ${controller.text}");
                            Navigator.pop(context);
                          },
                          child: Text("Confirmar",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    );
                  },
                );
              },



            ),

            Expanded(
              child: Container(

                child: Column(
                  children: [


                    SizedBox(height: 20),

                    Expanded(
                      child: transacaoAtiva == null
                          ? Center(child: Text("Nenhuma transação ativa",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24
                      ),))
                          : CarregandoAtivoCard(transacao: transacaoAtiva!,
                      ),
                    ),

                    SizedBox(height: 20),


                    transacaoAtiva == null ? SizedBox():

                    Row(
                      children: [
                        Expanded(
                          child: CardFinalizar(
                            onPressed: () {
                              print("Finalizar");
                              },
                          ),
                        ),
                      ],
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
