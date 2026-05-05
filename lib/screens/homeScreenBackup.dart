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

  bool wsUsuarioConectado = false;


  List<CarregadorDTO> carregadores = [];

  TransacaoAtivaDTO?transacaoAtiva;

  String? idCarregadorSelecionado;


  int currentIndex = 0;

  UsuarioDTO? usuario;


  @override
  Widget build(BuildContext context) {

    if (usuario == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }



    Widget getPage() {
      switch (currentIndex) {
        case 0:

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

          if (transacaoAtiva != null) {
            return CarregandoScreen(
              usuario: usuario!,
              transacaoAtiva: transacaoAtiva!,
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



  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    controller = HomeController(
      usuarioservice: usuarioservice,
      transacaoService: transacaoService,
      carregadorService: carregadorService,
    );

    carregarTudo();

    webSocketService.conectarTodosCarregadores(
      onMensagem: (msg) {
        print("WS carregadores: $msg");
        carregarTudo();
      },
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //
  //   WidgetsBinding.instance.addObserver(this);
  //
  //   carregarUsuario();
  //   carregarTransacaoAtiva();
  //   carregarCarregadores();
  //
  //   webSocketService.conectarTodosCarregadores(
  //     onMensagem: (msg) {
  //       print("WS carregadores: $msg");
  //       carregarCarregadores();
  //     },
  //   );
  //
  // }

  //desconectar ws
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    webSocketService.desconectar();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("App voltou, recarregando usuário...");

      atualizarDados();
    }
  }

  Future<void> carregarTudo() async {
    final state = await controller.carregarDados();

    if (!mounted) return;

    setState(() {
      usuario = state.usuario;
      transacaoAtiva = state.transacaoAtiva;
      carregadores = state.carregadores;
    });

    // 🔥 AQUI é o que faltava
    if (usuario != null && !wsUsuarioConectado) {
      wsUsuarioConectado = true;

      webSocketService.conectarUsuario(
        userId: usuario!.idUsuario.toString(),
        onMensagem: (msg) async {
          print("WS usuário: $msg");

          await carregarTudo();
        },
      );
    }
  }

  Future<void> atualizarDados() async {
    await carregarTudo();
  }

  // Future<void> atualizarDados() async {
  //   final usuarioAtualizado = await usuarioservice.buscarUsuarioLogado();
  //   final transacao = await transacaoService.listarTransacoesAtiva();
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     usuario = usuarioAtualizado;
  //     transacaoAtiva = transacao;
  //   });
  // }

  // //busca usuario e atualiza WS sempre que tem mudança
  // Future<void> carregarUsuario() async {
  //   final user = await usuarioservice.buscarUsuarioLogado();
  //
  //   setState(() {
  //     usuario = user;
  //   });
  //
  //
  //   if (usuario?.idUsuario != null) {
  //     webSocketService.conectar(
  //       userId: usuario!.idUsuario.toString(),
  //       onMensagem: (msg) async {
  //         print("WS HOME: $msg");
  //
  //         final valor = double.tryParse(msg);
  //         print("VALOR PARSE: $valor");
  //
  //
  //         if (valor != null) {
  //           if (!mounted) return;
  //
  //           setState(() {
  //             usuario!.saldo = valor;
  //           });
  //
  //           return;
  //         }
  //
  //
  //         final usuarioAtualizado = await usuarioservice.buscarUsuarioLogado();
  //
  //         print("SALDO NOVO: ${usuarioAtualizado?.saldo}");
  //         print("SALDO ANTIGO: ${usuario?.saldo}");
  //
  //         if (!mounted) return;
  //
  //         final transacao =
  //         await transacaoService.listarTransacoesAtiva();
  //
  //         if (transacaoAtiva != null && transacao == null) {
  //           Navigator.popUntil(context, (route) => route.isFirst);
  //         }
  //
  //         setState(() {
  //           usuario = usuarioAtualizado;
  //           transacaoAtiva = transacao;
  //         });
  //       },
  //     );
  //
  //   }
  // }
  //
  // Future<void>carregarTransacaoAtiva() async {
  //
  //   final transacao = await transacaoService.listarTransacoesAtiva();
  //
  //
  //   setState(() {
  //     transacaoAtiva = transacao;
  //   });
  //
  // }
  //
  //
  // //lista os carregadores -> coloca eles numa lista
  // Future<void> carregarCarregadores() async {
  //   final lista = await carregadorService.listarCarregadores();
  //
  //   setState(() {
  //
  //     carregadores = lista;
  //
  //   });
  // }

  // //redireciona para a tela dos conectores, passando o idCarregador
  // void irParaConectores(String idCarregador) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => Conectorescontent(
  //         usuario: usuario!,
  //         idCarregador: idCarregador,),
  //     ),
  //   );
  // }
}