import '../DTO/CarregadorDTO.dart';
import '../DTO/TransacaoAtivaDTO.dart';
import '../DTO/UsuarioDTO.dart';

/**
 * representa o estado atual da HomeScreen,
 * funcionando como um DTO de estado da interface
 *
 * O estado é atualizado pelo HomeController
 * quando eventos websocket ou chamadas da API ocorrem
 */
class HomeState {
  final UsuarioDTO? usuario;
  final TransacaoAtivaDTO? transacaoAtiva;
  final List<CarregadorDTO> carregadores;

  HomeState({
    required this.usuario,
    required this.transacaoAtiva,
    required this.carregadores,
  });
}