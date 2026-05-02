import 'dart:convert';

import 'package:projeto_integrador/DTO/ConectorDTO.dart';

import 'apiService.dart';

class ConectorService {
  final Apiservice api = Apiservice();


  //backend já retorna apenas os disponíveis
  Future<List<ConectorDTO>> listarConectores(String idCarregador) async {

    final response = await api.get("conector/disponiveis/$idCarregador");

    if (response.statusCode == 200) {

      final List jsonList = jsonDecode(response.body);

      return jsonList
          .map((item) => ConectorDTO.fromJson(item))
          .toList();

    } else if (response.statusCode == 204) {

      return [];

    } else {

      throw Exception("Erro ao buscar conectores");
    }
  }

  //usado recentemente -> remover forçado
  //tem um tempo no backend
  Future<ConectorDTO?> buscarConectorRecente() async {

    final response = await api.get("conector/usado-recentemente-pelo-usuario");

    if (response.statusCode == 200) {

      return ConectorDTO.fromJson(jsonDecode(response.body));

    } else if (response.statusCode == 204) {

      return null;

    } else {

      throw Exception("Erro ao buscar conectores");
    }
  }

}