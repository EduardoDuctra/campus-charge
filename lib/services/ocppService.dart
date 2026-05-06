import 'package:projeto_integrador/DTO/ocpp/RemoteStartDTO.dart';
import 'package:projeto_integrador/DTO/ocpp/RemoteStopDTO.dart';

import 'apiService.dart';

class OcppService{

  final Apiservice api = Apiservice();

  Future<String>RemoteStart(RemoteStartDTO dto) async {

    final response = await api.post("carregador/remotestart", dto.toJson());

    print("[REMOTE START - ]" + response.body);

    return response.body;

  }

  Future<String>RemoteStop(RemoteStopDTO dto) async {

    final response = await api.post("carregador/remotestop", dto.toJson());

    print("[REMOTE STOP - ]" + response.body);

    return response.body;

  }

}