import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/CarregadorDTO.dart';
import 'package:projeto_integrador/DTO/ConectorDTO.dart';
import 'package:projeto_integrador/DTO/ocpp/RemoteStartDTO.dart';
import 'package:projeto_integrador/DTO/ocpp/RemoteStartResponseDTO.dart';
import 'package:projeto_integrador/DTO/ocpp/UnlockConnectorDTO.dart';
import 'package:projeto_integrador/services/conectorService.dart';
import 'package:projeto_integrador/services/ocppService.dart';
import 'package:projeto_integrador/services/transacaoService.dart';
import 'package:projeto_integrador/shared/conectorCard.dart';
import 'package:projeto_integrador/theme/colors.dart';
import 'package:quickalert/quickalert.dart';

import '../DTO/UsuarioDTO.dart';
import '../controller/conectoresController.dart';
import '../services/websocket_service.dart';
import '../shared/BotaoRemover.dart';
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
    required this.onVoltar,
  });

  @override
  State<ConectoresSreen> createState() => _ConectoresSreenState();
}

class _ConectoresSreenState extends State<ConectoresSreen> {

  late ConectoresController controller;


  @override
  void initState() {
    super.initState();

    controller = ConectoresController(
      conectorService: ConectorService(),
      ocppService: OcppService(),);


    carregarTela();




    WidgetsBinding.instance.addPostFrameCallback((_) {

      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: "Importante",
        text: "Certifique-se que o veículo está conectado antes de iniciar a recarga",
        confirmBtnText: "OK",

        onConfirmBtnTap: () {

          Navigator.pop(context); // fecha o alert

        },
      );

    });


    //wb que fica escutando a atualização dos conectores
    WebSocketService().wbConectores(
      idCarregador: widget.idCarregador,
      onMensagem: (msg) async {
        print("WS CONECTORES: atualização");

        await carregarTela();
      },
    );
  }

  Future<void> carregarTela() async {

    await controller.carregarConectores(
        widget.idCarregador);

    if(mounted){
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }



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

            SizedBox(height: 10),

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

            SizedBox(height: 10),

            Expanded(
              child: Container(
                child: Column(
                  children: [


                    Expanded(

                      child: widget.usuario.saldo == null ||
                          widget.usuario.saldo! <= 0

                          ? Center(
                        child: Text(
                          "Adicione saldo\n para utilizar os conectores.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )

                      :


                      Column(
                        children: controller.conectores.asMap().entries.map((entry) {
                          int index = entry.key;
                          ConectorDTO dto = entry.value;

                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: index != controller.conectores.length - 1 ? 16 : 0,
                              ),

                              child: ConectorCard(
                                dto: dto,
                                onPressed: () async {

                                  RemoteStartResponseDTO response = await controller.enviarRemoteStart(dto);

                                  if(response.aceito){

                                    QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.success,
                                        showConfirmBtn: false,
                                        autoCloseDuration: Duration(seconds: 3),

                                    );

                                  } else{

                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      text: response.response,
                                      showConfirmBtn: false,
                                      autoCloseDuration: Duration(seconds: 5),
                                    );

                                  }
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