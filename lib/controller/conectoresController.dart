import '../DTO/ConectorDTO.dart';
import '../DTO/ocpp/RemoteStartDTO.dart';
import '../services/conectorService.dart';
import '../services/ocppService.dart';
import '../services/transacaoService.dart';

class ConectoresController {


  final ConectorService conectorService;
  final OcppService ocppService;

  ConectoresController({
    required this.conectorService,
    required this.ocppService,
  });

  List<ConectorDTO> conectores = [];
  bool carregando = true;

  Future<void> carregarConectores(String idCarregador) async {


    //mostra todos os conectores
    conectores  = await conectorService.listarConectores(idCarregador);


    carregando = false;

  }


  Future<bool> enviarRemoteStart(ConectorDTO dto) async {

    bool aceito = false;

    print("ID carregador: ${dto.idCarregador}");
    print("ID conector: ${dto.connectorIdNoCarregador}");

    RemoteStartDTO remoteStartDTO = new RemoteStartDTO(
      charger_id: dto.idCarregador,
      connector_id: dto.connectorIdNoCarregador,);

    String response = await ocppService.remoteStart(remoteStartDTO);

    if(response == "Accepted"){
      aceito = true;
    }

    return aceito;
  }


}