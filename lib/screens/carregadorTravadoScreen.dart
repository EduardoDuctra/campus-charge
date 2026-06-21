import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/UsuarioDTO.dart';
import 'package:projeto_integrador/services/conectorService.dart';
import 'package:projeto_integrador/shared/botaoCancelar.dart';

import '../controller/carregadorController.dart';
import '../services/ocppService.dart';
import '../shared/BotaoRemover.dart';
import '../shared/appDrawer.dart';
import '../shared/saldoCard.dart';
import '../shared/topBarWidget.dart';
import '../utils/modal_recarga.dart';
import 'homeScreen.dart';

class CarregadorTravadoScreen extends StatefulWidget {

  final UsuarioDTO usuario;

  const CarregadorTravadoScreen({super.key, required this.usuario});

  @override
  State<CarregadorTravadoScreen> createState() => _CarregadorTravadoScreenState();
}

class _CarregadorTravadoScreenState extends State<CarregadorTravadoScreen> {

  late CarregadorController controller;

  @override
  void initState() {
    super.initState();

    controller = CarregadorController(
        ocppService: OcppService(),
        conectorService: ConectorService()
    );

    carregarTela();

  }

  Future<void> carregarTela() async {

    await controller.carregarConectorTravado();

    if(mounted){
      setState(() {});
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: AppDrawer(
        usuario: widget.usuario,
        onAtualizarUsuario: () async {},),

      backgroundColor: Colors.black,

      body: SafeArea(
        child: Column(
          children: [

            TopBarWidget(),


            SaldoCard(
                saldo: widget.usuario!.saldo ?? 0,
                onPressed: () => abrirModalRecarga(context)
            ),



            SizedBox(height: 40),

            if (controller.carregando)
              CircularProgressIndicator(),

            if (!controller.carregando && controller.conectorRecente == null)
              Text(
                "Nenhum conector travado",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

            if (controller.conectorRecente != null)

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

                  SizedBox(height: 60),

                  BotaoRemover(
                    onPressed: () async {

                      await controller.enviarUnlockConector(
                        controller.conectorRecente!,
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
                  SizedBox(height: 60),


                ],
              ),


            BotaoCancelar(),

          ],
        ),
      ),


    );
  }
}