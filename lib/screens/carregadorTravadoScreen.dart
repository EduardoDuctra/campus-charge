import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/UsuarioDTO.dart';
import 'package:projeto_integrador/services/conectorService.dart';
import 'package:projeto_integrador/services/usuarioService.dart';
import 'package:projeto_integrador/services/veiculoService.dart';
import 'package:projeto_integrador/shared/botaoAdicionar.dart';
import 'package:projeto_integrador/shared/botaoCancelar.dart';
import 'package:projeto_integrador/shared/cardVeiculo.dart';

import '../DTO/ConectorDTO.dart';
import '../DTO/VeiculoDTO.dart';
import '../DTO/ocpp/UnlockConnectorDTO.dart';
import '../controller/veiculoController.dart';
import '../services/ocppService.dart';
import '../shared/BotaoRemover.dart';
import '../shared/appDrawer.dart';
import '../shared/conectorCard.dart';
import '../shared/saldoCard.dart';
import '../shared/topBarWidget.dart';
import '../theme/colors.dart';
import '../utils/modal_recarga.dart';
import 'homeScreen.dart';

class CarregadorTravadoScreen extends StatefulWidget {

  final UsuarioDTO usuario;

  const CarregadorTravadoScreen({super.key, required this.usuario});

  @override
  State<CarregadorTravadoScreen> createState() => _CarregadorTravadoScreenState();
}

class _CarregadorTravadoScreenState extends State<CarregadorTravadoScreen> {


  final ConectorService conectorService = ConectorService();
  final OcppService ocppService  = OcppService();

  ConectorDTO? conectorRecente;
  bool carregando = true;

  @override
  void initState() {
    super.initState();

    carregarConectorTravado();

  }

  Future<void> carregarConectorTravado() async {

    final response = await conectorService.buscarConectorRecente();


    if (!mounted) {
      return;
    }

    setState(() {
      conectorRecente = response;
      carregando = false;
    });
  }

  Future<void> enviarUnlockConector(ConectorDTO dto) async {


    print("ID carregador: ${dto.idCarregador}");
    print("ID conector: ${dto.connectorIdNoCarregador}");

    UnlockConnectorDTO unlockDTO = new UnlockConnectorDTO(
      charger_id: dto.idCarregador,
      connector_id: dto.connectorIdNoCarregador,);

    await ocppService.unlockConnector(unlockDTO);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: AppDrawer(
        usuario: widget.usuario,),

      backgroundColor: Colors.black,

      body: SafeArea(
        child: Column(
          children: [

            TopBarWidget(usuario: widget.usuario),


            SaldoCard(
                saldo: widget.usuario!.saldo ?? 0,
                onPressed: () => abrirModalRecarga(context)
            ),




            SizedBox(height: 40),

            if (carregando)
              CircularProgressIndicator(),

            if (!carregando && conectorRecente == null)
              Text(
                "Nenhum conector travado",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

            if (conectorRecente != null)

              Column(
                children: [

                  Text(
                    'Caso o conector fique preso,\nforce a retirada',

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: .bold,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 80),

                  BotaoRemover(
                    onPressed: () async {

                      await enviarUnlockConector(
                        conectorRecente!,
                      );

                      Navigator.pushAndRemoveUntil(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen(),
                        ),

                            (route) => false,
                      );
                    },
                  ),
                  SizedBox(height: 140),


                ],
              ),


            BotaoCancelar(),

          ],
        ),
      ),


    );
  }
}