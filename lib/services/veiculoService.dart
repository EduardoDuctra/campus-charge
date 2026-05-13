import 'dart:convert';

import 'package:projeto_integrador/DTO/VeiculoDTO.dart';

import 'apiService.dart';

class VeiculoService {
  final Apiservice api = Apiservice();


  Future<List<VeiculoDTO>> listarVeiculos() async {

    final response = await api.get("veiculo/listar");

    if (response.statusCode == 200) {

      final List jsonList = jsonDecode(response.body);


      return jsonList
          .map((item) => VeiculoDTO.fromJson(item))
          .toList();

    } else if (response.statusCode == 404) {

      return [];

    } else {

      throw Exception("Erro ao buscar veículos");
    }
  }

  Future<VeiculoDTO> cadastrarVeiculo(VeiculoDTO veiculoDTO) async {


    final response = await api.post("veiculo/cadastrar", veiculoDTO.toJson());


    if(response.statusCode == 201){

      return VeiculoDTO.fromJson(jsonDecode(response.body),);

    } else{
      throw Exception("Erro ao cadastrar veículo");
    }


  }

  Future<void> deletar(int idVeiculo) async {

    final response = await api.delete("veiculo/deletar/$idVeiculo", {});

    if(response.statusCode != 204){

      throw Exception("Erro ao deletar veículo");

    }

  }


}