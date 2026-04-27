
import 'dart:convert';
import 'dart:ui';

import 'package:image_picker/image_picker.dart';
import 'package:projeto_integrador/DTO/UsuarioDTO.dart';
import 'package:projeto_integrador/services/apiService.dart';

class Usuarioservice {
  final Apiservice api = Apiservice();

  Future <bool> cadastrar(UsuarioDTO usuario) async{
    final response = await api.post(
        "usuario",
        usuario.toJson());

    print(response.statusCode);

    return response.statusCode == 201;

  }

  Future <bool> atualizar(UsuarioDTO usuario) async{
    final response = await api.put(
        "usuario/atualizar/logado",
        usuario.toJson());

    print(response.statusCode);

    return response.statusCode == 200;

  }
  
  Future<UsuarioDTO?> buscarUsuarioLogado() async {
    
    final response = await api.get("usuario/logado");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UsuarioDTO.fromJson(data);
    }

    return null;

  }

  Future<String?>uploadFoto(XFile imagem)async{

    return await api.uploadFoto(imagem);

  }



}