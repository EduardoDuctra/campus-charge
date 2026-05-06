import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/CarregadorDTO.dart';
import 'package:projeto_integrador/DTO/ConectorDTO.dart';
import 'package:projeto_integrador/DTO/ocpp/RemoteStartDTO.dart';
import 'package:projeto_integrador/services/conectorService.dart';
import 'package:projeto_integrador/services/ocppService.dart';
import 'package:projeto_integrador/services/transacaoService.dart';
import 'package:projeto_integrador/shared/conectorCard.dart';
import 'package:projeto_integrador/theme/colors.dart';
import 'package:quickalert/quickalert.dart';

import '../DTO/UsuarioDTO.dart';
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
    required this.onVoltar});

  @override
  State<ConectoresSreen> createState() => _ConectoresSreenState();
}

class _ConectoresSreenState extends State<ConectoresSreen> {

  final TransacaoService transacaoService = TransacaoService();
  final ConectorService conectorService = ConectorService();
  final OcppService ocppService = OcppService();

  //usado para ver se tenho resposta na minha API nessa url
  ConectorDTO? conectorRecente;
  bool carregando = true;


  List<ConectorDTO>conectores = [];


  @override
  void initState() {
    super.initState();

    carregarConectores();

    //wb que fica escutando a atualização dos conectores
    WebSocketService().wbConectores(
      idCarregador: widget.idCarregador,
      onMensagem: (msg) async {
        print("WS CONECTORES: atualização");

        await carregarConectores();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }


  Future<void> carregarConectores() async {

    //verifica se o backend ta mandando uma transação recente
    final transacaoRecenteAPI = await conectorService.buscarConectorRecente();

    /*
    mounted -> se tem o widgte na tela
    se não tiver na tela -> return
     */
    if (!mounted) {
      return;
    }

    //tem transação recente -> atualiza as listas
    if(transacaoRecenteAPI != null){

      setState(() {
        //seta a transacao que veio da API
        conectorRecente = transacaoRecenteAPI;
        conectores = [];
        carregando = false;
      });

    } else {

      //não tem transacao recente -> mostra todos os conectores
      final lista = await conectorService.listarConectores(widget.idCarregador);

      /*
      mounted -> se tem o widgte na tela
      se não tiver na tela -> return
     */
      if (!mounted){
        return;
      }

      //tem transação recente -> atualiza as listas
      setState(() {
        conectorRecente = null;
        conectores = lista;
        carregando = false;
      });
    }
  }

  Future<bool> enviarRemoteStart(ConectorDTO dto) async {

    bool aceito = false;

    print("ID carregador: ${widget.idCarregador}");
    print("ID conector: ${dto.connectorIdNoCarregador}");

    RemoteStartDTO remoteStartDTO = new RemoteStartDTO(
        charger_id: widget.idCarregador,
      connector_id: dto.connectorIdNoCarregador,);

    String response = await ocppService.RemoteStart(remoteStartDTO);

    if(response == "Accepted"){
      aceito = true;
    }

    return aceito;
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
                                onPressed: () async {

                                  bool response = await enviarRemoteStart(dto);

                                  if(response){

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
                                      text: "Transação recusada.",
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