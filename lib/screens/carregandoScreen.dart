import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/TransacaoAtivaDTO.dart';
import 'package:projeto_integrador/DTO/ocpp/RemoteStopDTO.dart';
import 'package:projeto_integrador/services/ocppService.dart';
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
import '../utils/modal_recarga.dart';

class CarregandoScreen extends StatefulWidget {

  //recebe usuario e transação ativa
  final UsuarioDTO usuario;
  final TransacaoAtivaDTO transacaoAtiva;

  const CarregandoScreen({
    super.key,
    required this.usuario,
    required this.transacaoAtiva});

  @override
  State<CarregandoScreen> createState() => _CarregandoScreenState();
}

class _CarregandoScreenState extends State<CarregandoScreen> {

  final TransacaoService transacaoService = TransacaoService();
  final OcppService ocppService = OcppService();


  @override
  void initState() {
    super.initState();

    if (widget.usuario.idUsuario == null) {
      throw Exception("Usuário sem ID");
    }

  }

  Future<bool> enviarRemoteStop() async {

    bool aceito = false;

    print("ID carregador: ${widget.transacaoAtiva.idCarregador}");
    print("ID Transacao: ${widget.transacaoAtiva.idTransacao}");

    RemoteStopDTO remoteStopDTO = new RemoteStopDTO(
      charger_id: widget.transacaoAtiva.idCarregador,
      transaction_id: widget.transacaoAtiva.idTransacao,);

    String response = await ocppService.remoteStop(remoteStopDTO);

    if(response == "Accepted"){
      aceito = true;
    }

    return aceito;

  }


  // =====================  BUILD  =========================== //


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
                onPressed: () => abrirModalRecarga(context)
            ),

            SizedBox(height: 20,),

            Valorrecargacard(

              valor: widget.transacaoAtiva.valorRecarga,

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
                      child:CarregandoAtivoCard(  transacao: widget.transacaoAtiva),
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: CardFinalizar(
                            onPressed: () async {
                              await enviarRemoteStop();
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
