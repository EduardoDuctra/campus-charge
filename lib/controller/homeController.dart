import 'dart:ui';


import '../DTO/CarregadorDTO.dart';
import '../services/carregadorService.dart';
import '../services/transacaoService.dart';
import '../services/usuarioService.dart';
import '../services/websocket_service.dart';
import 'homeState.dart';

/**
 * coordena a atualização de dados da tela HOME
 * intermediário entre interface e services
 * controllerHome -> atualiza o estado da home conforme as mudanças nos WS
 */
class HomeController {

  VoidCallback atualizarTela;

  final Usuarioservice usuarioservice;
  final TransacaoService transacaoService;
  final CarregadorService carregadorService;
  final WebSocketService webSocketService;


  HomeController({
    required this.atualizarTela,
    required this.usuarioservice,
    required this.transacaoService,
    required this.carregadorService,
    required this.webSocketService,
  });

  //estado atual da tela Home
  HomeState? state;

  bool wsUsuarioConectado = false;
  bool wsCarregadoresConectado = false;


  String cidade = "Santa Maria";

  //passa para o HomeState as informações atualizadas
  Future<HomeState> carregarDados() async {
    final usuario = await usuarioservice.buscarUsuarioLogado();

    dynamic transacao;

    try {

      transacao = await transacaoService.listarTransacoesAtiva();
      
      
    } catch (e) {

      print("Sem transação ativa");

      transacao = null;

    }

    final carregadores = await carregadorService.listarCarregadores();

    List<CarregadorDTO> carregadoresPorCidade = [];

    for(CarregadorDTO carregador in carregadores){
      if(carregador.cidade == cidade){
        carregadoresPorCidade.add(carregador);
      }
    }
    
    return HomeState(
      usuario: usuario,
      transacaoAtiva: transacao,
      carregadores: carregadoresPorCidade,
      cidade: cidade,
    );
  }

  Future<void> alterarCidade(String cidade) async {

    print("Nova cidade " + cidade);
    this.cidade = cidade;

    await carregarTudo();
  }


  //WS dos carregadores e Usuario
  //passa para o HomeState as informações atualizadas
  Future<void> carregarTudo() async {

    //atualiza o estado da Home
    state = await carregarDados();

    atualizarTela();

    if (!wsCarregadoresConectado) {

      wsCarregadoresConectado = true;

      webSocketService.wbCarregadores(

        onMensagem: (msg) async {

          print("WS carregadores");

          await carregarTudo();
        },
      );
    }

    if (state?.usuario != null && !wsUsuarioConectado) {

      wsUsuarioConectado = true;

      webSocketService.wbUsuario(

        userId: state!.usuario!.idUsuario.toString(),

        onMensagem: (msg) async {

          print("WS usuario");

          await carregarTudo();
        },

        onSaldo: (novoSaldo) {

          state!.usuario!.saldo = novoSaldo;

          atualizarTela();
        },
      );
    }
  }
}