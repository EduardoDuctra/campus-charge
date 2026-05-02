import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_integrador/DTO/TransacaoAtivaDTO.dart';
import 'package:projeto_integrador/screens/conectoresScreen.dart';
import 'package:projeto_integrador/services/carregadorService.dart';
import 'package:projeto_integrador/shared/carregadorCard.dart';
import 'package:projeto_integrador/shared/saldoCard.dart';

import '../DTO/CarregadorDTO.dart';
import '../DTO/UsuarioDTO.dart';
import '../services/websocket_service.dart';
import '../shared/topBarWidget.dart';

class Homecontent extends StatefulWidget {

  final UsuarioDTO usuario;



  const Homecontent({super.key,
    required this.usuario});

  @override
  State<Homecontent> createState() => _HomecontentState();
}

class _HomecontentState extends State<Homecontent> {
  final CarregadorService carregadorService = CarregadorService();
  final WebSocketService ws = WebSocketService();

  List<CarregadorDTO> carregadores = [];


  @override
  void initState() {
    super.initState();

    carregarCarregadores();

    ws.conectarTodosCarregadores(
      onMensagem: (msg) {

        print("Atualização carregadores");

        carregarCarregadores();
      },
    );
  }

  @override
  void dispose() {
    ws.desconectar();
    super.dispose();
  }

  Future<void> carregarCarregadores() async {
    final lista = await carregadorService.listarCarregadores();


    setState(() {

      carregadores = lista;

    });
  }

  void irParaConectores(String idCarregador) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Conectoresscreen(
          usuario: widget.usuario,
          idCarregador: idCarregador,),
      ),
    );
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

            Expanded(
              child: Container(
                child: Column(
                  children: [

                    SizedBox(height: 30),


                    Row(

                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        SvgPicture.asset(
                            'assets/icons/location.svg',
                            width: 25,
                            colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn)

                        ),

                        SizedBox(width: 20),

                        Text(
                          'UFSM - Santa Maria',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 40),

                    Expanded(
                      child: ListView.builder(
                        itemCount: carregadores.length,
                        itemBuilder: (context, index) {

                          final carregador = carregadores[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: CardCarregador(
                              carregadorDTO: carregador,

                              //so executa quando clicar
                              onPressed: () => irParaConectores(carregador.idCarregador),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 30),

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