import '../DTO/CarregadorDTO.dart';
import '../services/carregadorService.dart';
import '../services/transacaoService.dart';
import '../services/usuarioService.dart';
import 'homeState.dart';

class HomeController {
  final Usuarioservice usuarioservice;
  final TransacaoService transacaoService;
  final CarregadorService carregadorService;

  HomeController({
    required this.usuarioservice,
    required this.transacaoService,
    required this.carregadorService,
  });


  Future<List<CarregadorDTO>> carregarCarregadores() async {
    return await carregadorService.listarCarregadores();
  }

  Future<HomeState> carregarDados() async {
    final usuario = await usuarioservice.buscarUsuarioLogado();
    final transacao = await transacaoService.listarTransacoesAtiva();
    final carregadores = await carregadorService.listarCarregadores();

    return HomeState(
      usuario: usuario,
      transacaoAtiva: transacao,
      carregadores: carregadores,
    );
  }
}