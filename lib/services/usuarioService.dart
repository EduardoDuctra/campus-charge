
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



}