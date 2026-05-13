import '../DTO/CarregadorDTO.dart';
import '../services/carregadorService.dart';
import '../services/transacaoService.dart';
import '../services/usuarioService.dart';
import 'homeState.dart';

/**
 * coordena a atualização de dados da tela HOME
 * intermediário entre interface e services
 */
class HomeController {
  final Usuarioservice usuarioservice;
  final TransacaoService transacaoService;
  final CarregadorService carregadorService;

  HomeController({
    required this.usuarioservice,
    required this.transacaoService,
    required this.carregadorService,
  });


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

    return HomeState(
      usuario: usuario,
      transacaoAtiva: transacao,
      carregadores: carregadores,
    );
  }
}