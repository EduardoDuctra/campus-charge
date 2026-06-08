import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_integrador/screens/conectoresSreen.dart';
import 'package:projeto_integrador/services/transacaoService.dart';

import '../controller/homeController.dart';
import '../services/carregadorService.dart';
import '../services/usuarioService.dart';
import '../services/websocket_service.dart';
import '../shared/carregadorCard.dart';
import '../shared/navegationBar.dart';
import '../shared/saldoCard.dart';
import '../shared/topBarWidget.dart';
import '../utils/modal_recarga.dart';
import 'cadastroUsuarioScreen.dart';
import 'carregandoScreen.dart';
import 'historicoTransacoesCreditoScreen.dart';
import 'historicoTransacoesDebitoScreen.dart';
import 'lerQRCodeScreen.dart';

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

  String? idCarregadorSelecionado;

  int currentIndex = 0;




  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    /**
     * inicializo o controller da Home
     */
    controller = HomeController(
      atualizarTela: () {

        //se não tem mudança -> ignora
        if(mounted){
          setState(() {});
        }
      },

      usuarioservice: usuarioservice,
      transacaoService: transacaoService,
      carregadorService: carregadorService,
      webSocketService: webSocketService,

    );

    //carrego as informações
    controller.carregarTudo();
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("APP VOLTOU - RECARREGANDO DADOS");
      controller.carregarTudo();
    }
  }




  @override
  Widget build(BuildContext context) {

    if (controller.state?.usuario == null) {
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

          if (controller.state?.transacaoAtiva != null) {
            return CarregandoScreen(
              usuario: controller.state!.usuario!,
              transacaoAtiva: controller.state!.transacaoAtiva!,
            );
          }

          if (idCarregadorSelecionado != null) {
            return ConectoresSreen(
              usuario: controller.state!.usuario!,
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
          return HistoricoTransacoesCreditoScreen(usuario: controller.state!.usuario!);

        case 2:
          return HistoricoTransacoesDebitoScreen(usuario: controller.state!.usuario!);

        case 3:
          return LerQRCodeScreen(usuario: controller.state!.usuario!);

        default:
          return buildHome();
      }
    }


    //recebe o index da página pela navbar
    //atualiza a pagina de acordo com o index
    return NavigationBarWidget(
      usuario: controller.state!.usuario!,
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


            TopBarWidget(usuario: controller.state!.usuario!),

            SaldoCard(
                saldo: controller.state!.usuario!.saldo ?? 0,
                onPressed: () async {


                  //cadastro incompleto -> tela atualizar
                  if (!controller.state!.usuario!.isCadastroCompleto) {

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CadastroUsuarioScreen(usuario: controller.state!.usuario!),
                      ),
                    );

                    await controller.carregarTudo();

                    return;

                  }

                  abrirModalRecarga(context);
                }
            ),

            Expanded(
              child: Container(
                child: Column(
                  children: [

                    SizedBox(height: 20),

                    Text(
                      'Você está em',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

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

                        DropdownButton<String>(
                            value: controller.state!.cidade,

                          dropdownColor: Colors.black,
                          icon: SizedBox.shrink(),

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),


                          underline: Container(),

                          items: const [

                            DropdownMenuItem(
                              value: "Santa Maria",
                              child: Text("UFSM - Santa Maria"),
                            ),

                            DropdownMenuItem(
                              value: "Cachoeira do Sul",
                              child: Text("UFSM - Cachoeira do Sul"),
                            ),
                          ],

                          onChanged: (value) async {
                              if(value !=null){

                                await controller.alterarCidade(value);

                              }
                          },


                           )

                      ],
                    ),

                    SizedBox(height: 20),

                    Expanded(
                      child: controller.state!.carregadores.isEmpty ?
                      Center(
                        child: Text(
                          "Nenhum carregador disponível.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )

                      :

                      ListView.builder(
                        itemCount: controller.state!.carregadores.length,
                        itemBuilder: (context, index) {

                          final carregador = controller.state!.carregadores[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
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