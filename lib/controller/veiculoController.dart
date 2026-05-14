import '../DTO/UsuarioDTO.dart';
import '../DTO/VeiculoDTO.dart';
import '../services/usuarioService.dart';
import '../services/veiculoService.dart';

class VeiculoController {

  final VeiculoService veiculoService = VeiculoService();
  final Usuarioservice usuarioservice = Usuarioservice();


  String? marcaSelecionada;
  String? modeloSelecionado;


  List<VeiculoDTO> veiculos = [];

  int indexPrincipal = 0;

  //ordena com o principal sempre em primeiro
  Future<void> carregarVeiculos(UsuarioDTO usuario) async {

    final lista = await veiculoService.listarVeiculos();

    int principal = 0;

    for (int i = 0; i < lista.length; i++) {

      if (lista[i].idVeiculo ==
          usuario.idVeiculoPrincipal) {

        principal = i;
        break;
      }
    }

    // move o veículo principal para primeira posição
    final veiculoPrincipal = lista.removeAt(principal);

    lista.insert(0, veiculoPrincipal);


      veiculos = lista;

      indexPrincipal = 0;

  }

}