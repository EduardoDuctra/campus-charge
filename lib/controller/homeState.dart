import '../DTO/CarregadorDTO.dart';
import '../DTO/TransacaoAtivaDTO.dart';
import '../DTO/UsuarioDTO.dart';

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