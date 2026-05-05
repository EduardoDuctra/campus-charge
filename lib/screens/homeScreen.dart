import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_integrador/DTO/TransacaoAtivaDTO.dart';
import 'package:projeto_integrador/screens/conectoresSreen.dart';
import 'package:projeto_integrador/services/transacaoService.dart';

import '../DTO/CarregadorDTO.dart';
import '../DTO/UsuarioDTO.dart';
import '../controller/homeController.dart';
import 'carregandoScreen.dart';
import 'historicoTransacoesDebitoScreen.dart';
import 'historicoTransacoesCreditoScreen.dart';
import '../services/carregadorService.dart';
import '../services/usuarioService.dart';
import '../services/websocket_service.dart';
import '../shared/carregadorCard.dart';
import '../shared/navegationBar.dart';
import '../shared/saldoCard.dart';
import '../shared/topBarWidget.dart';
import '../utils/modal_recarga.dart';

/**
 * TELA PRINCIPAL
 * RESPONSÁVEL POR:
 *    -CONSUMIR E MOSTRAR AS INFORMAÇÕES/ATUALIZAÇÕES
 *    - NAVEGAÇÃO ENTRE TELAS (NAVBAR)
 */
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver  {

  final WebSocketService webSocketService = WebSocketService();
  final TransacaoService transacaoService = TransacaoService();
  final Usuarioservice usuarioservice = Usuarioservice();
  final CarregadorService carregadorService = CarregadorService();

  late HomeController controller;


  List<CarregadorDTO> carregadores = [];

  TransacaoAtivaDTO?transacaoAtiva;

  String? idCarregadorSelecionado;

  //variaveis controle WS
  bool wsUsuarioConectado = false;
  bool wsCarregadoresConectado = false;


  int currentIndex = 0;

  UsuarioDTO? usuario;


  @override
  void initState() {
    super.initState();


    //passo para o controller os services
    // o controller centraliza a lógica de obtenção e organização dos dados da tela
    //controller monta os dados no HomeState e a INTERFACE (HomeScreen) só consome os dados do controller
    controller = HomeController(
      usuarioservice: usuarioservice,
      transacaoService: transacaoService,
      carregadorService: carregadorService,
    );

    carregarTudo();
  }


  @override
  void dispose() {
    webSocketService.desconectar();
    super.dispose();
  }


  Future<void> carregarTudo() async {

    //solicita ao controller os dados atualizados
    final dadosAtualizados = await controller.carregarDados();

    /*
      mounted -> se tem o widgte na tela
      se não tiver na tela -> return
     */
    if (!mounted){
      return;
    }

    //atualiza o estado da tela com os dados retornados pelo controller
    setState(() {
      usuario = dadosAtualizados.usuario;
      transacaoAtiva = dadosAtualizados.transacaoAtiva;

      //cria uma copia da lista de carregadores atualizada
      carregadores = [...dadosAtualizados.carregadores];
    });

    //WS carregadores
    if (!wsCarregadoresConectado) {
      //ws conectou -> não conecta de novo
      wsCarregadoresConectado = true;

      //ao receber evento do backend, recarrega os dados da tela
      webSocketService.wbCarregadores(
        onMensagem: (msg) async {
          print(" WS carregadores");

          await carregarTudo();

        },
      );
    }

    // WS USUÁRIO (SOC/transação)

    if (usuario != null && !wsUsuarioConectado) {

      //ws conectou -> não conecta de novo
      wsUsuarioConectado = true;

      //ao receber evento do backend, recarrega os dados da tela
      webSocketService.wbUsuario(
        userId: usuario!.idUsuario.toString(),
        onMensagem: (msg) async {
          print("WS USUARIO: $msg");

          await carregarTudo();
        },
      );
    }
  }


  // =====================  BUILD  =========================== //


  @override
  Widget build(BuildContext context) {

    if (usuario == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }


    /**
     * NAVBAR
     */
    Widget getPage() {
      switch (currentIndex) {
        case 0:

          if (transacaoAtiva != null) {
            return CarregandoScreen(
              usuario: usuario!,
              transacaoAtiva: transacaoAtiva!,
            );
          }

          if (idCarregadorSelecionado != null) {
            return ConectoresSreen(
              usuario: usuario!,
              idCarregador: idCarregadorSelecionado!,
              onVoltar: () {
                setState(() {
                  idCarregadorSelecionado = null;
                });
              },
            );
          }

          return buildHome();

        case 1:
          return HistoricoTransacoesCreditoScreen(usuario: usuario!);

        case 2:
          return HistoricoTransacoesDebitoScreen(usuario: usuario!);

        default:
          return buildHome();
      }
    }


    //recebe o index da página pela navbar
    //atualiza a pagina de acordo com o index
    return NavigationBarWidget(
      usuario: usuario!,
      currentIndex: currentIndex,

      onItemSelecionado: (index) {
        setState(() {
          currentIndex = index;
        });
      },

        child: getPage(),
    );
  }


  Widget buildHome() {
    return Container(
      color: Colors.black,

      child: SafeArea(
        child: Column(
          children: [


            TopBarWidget(usuario: usuario!),

            SaldoCard(
                saldo: usuario!.saldo ?? 0,
                onPressed: () => abrirModalRecarga(context)
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
                                onPressed: () {
                                  setState(() {
                                    idCarregadorSelecionado = carregador.idCarregador;});
                                }
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