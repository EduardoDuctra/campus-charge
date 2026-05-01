import 'dart:convert';

import 'package:projeto_integrador/DTO/TransacaoAtivaDTO.dart';
import 'package:projeto_integrador/DTO/TransacaoCreditoDTO.dart';

import '../DTO/TransacaoDebitoDTO.dart';
import 'apiService.dart';

class TransacaoService {

  final Apiservice api = Apiservice();

  Future<List<TransacaoCreditoDTO>> listarTransacoesCredito() async {

    final response = await api.get("transacao/listar-transacoes-credito");

    if (response.statusCode == 200) {

      final List jsonList = jsonDecode(response.body);


      return jsonList
          .map((item) => TransacaoCreditoDTO.fromJson(item))
          .toList();

    } else if (response.statusCode == 404) {

      return [];
    } else {

      throw Exception("Erro ao buscar transações");
    }
  }

  Future<List<TransacaoDebitoDTO>> listarTransacoesDebito() async {

    final response = await api.get("transacao/listar-transacoes-debito");

    if (response.statusCode == 200) {

      final List jsonList = jsonDecode(response.body);

      return jsonList
          .map((item) => TransacaoDebitoDTO.fromJson(item))
          .toList();

    } else if (response.statusCode == 404) {

      return [];
    } else {

      throw Exception("Erro ao buscar transações");
    }
  }


  Future<TransacaoAtivaDTO?> listarTransacoesAtiva() async {
    final response = await api.get("transacao/listar-transacao-ativa");

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    try {

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final json = jsonDecode(response.body);
        return TransacaoAtivaDTO.fromJson(json);
      }


      if (response.statusCode == 404 ||
          response.statusCode == 204 ||
          response.body.isEmpty ||
          response.body == "null") {
        return null;
      }


      print("Erro inesperado: ${response.statusCode}");
      return null;

    } catch (e) {
      print("Erro parse JSON: $e");
      return null;
    }
  }


}