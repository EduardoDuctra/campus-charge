import 'dart:convert';

import 'package:projeto_integrador/DTO/TransacaoCreditoDTO.dart';

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


}