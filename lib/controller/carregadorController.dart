import '../DTO/ConectorDTO.dart';
import '../DTO/TransacaoAtivaDTO.dart';
import '../DTO/ocpp/RemoteStopDTO.dart';
import '../DTO/ocpp/UnlockConnectorDTO.dart';
import '../services/conectorService.dart';
import '../services/ocppService.dart';

class CarregadorController {

  final OcppService ocppService;
  final ConectorService conectorService;

  ConectorDTO? conectorRecente;
  bool carregando = true;

  CarregadorController({
    required this.ocppService,
    required this.conectorService,
  });


  Future<bool> enviarRemoteStop(TransacaoAtivaDTO transacaoAtiva) async {

    bool aceito = false;

    print("ID carregador: ${transacaoAtiva.idCarregador}");
    print("ID Transacao: ${transacaoAtiva.idTransacao}");

    RemoteStopDTO remoteStopDTO = new RemoteStopDTO(
      charger_id: transacaoAtiva.idCarregador,
      transaction_id: transacaoAtiva.idTransacao,);

    String response = await ocppService.remoteStop(remoteStopDTO);

    if(response == "Accepted"){
      aceito = true;
    }

    return aceito;

  }


  Future<void> carregarConectorTravado() async {

    conectorRecente = await conectorService.buscarConectorRecente();

    carregando = false;

  }

  Future<void> enviarUnlockConector(ConectorDTO dto) async {


    print("ID carregador: ${dto.idCarregador}");
    print("ID conector: ${dto.connectorIdNoCarregador}");

    UnlockConnectorDTO unlockDTO = new UnlockConnectorDTO(
      charger_id: dto.idCarregador,
      connector_id: dto.connectorIdNoCarregador,);

    await ocppService.unlockConnector(unlockDTO);

  }


}