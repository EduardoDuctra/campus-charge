import 'dart:convert';

import 'package:projeto_integrador/DTO/CarregadorDTO.dart';

import 'apiService.dart';

class CarregadorService {
  final Apiservice api = Apiservice();

  //backend já retorna apenas os disponíveis
  Future<List<CarregadorDTO>> listarCarregadores() async {

    final response = await api.get("carregador/disponiveis");

    if (response.statusCode == 200) {

      final List jsonList = jsonDecode(response.body);

      return jsonList
          .map((item) => CarregadorDTO.fromJson(item))
          .toList();

    } else if (response.statusCode == 204) {

      return [];

    } else {

      throw Exception("Erro ao buscar carregadores");
    }
  }

}