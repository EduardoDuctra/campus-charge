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


      final carregadoresOrdenados = jsonList
          .map((item) => CarregadorDTO.fromJson(item))
          .toList();

      carregadoresOrdenados.sort(
            (a, b) => a.idCarregador.compareTo(b.idCarregador),);

      return carregadoresOrdenados;

    } else if (response.statusCode == 204) {

      return [];

    } else {

      throw Exception("Erro ao buscar carregadores");
    }
  }

}