import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projeto_integrador/DTO/DadosAutenticacaoDTO.dart';
import 'package:projeto_integrador/DTO/EsqueciSenhaDTO.dart';
import 'package:projeto_integrador/services/tokenService.dart';

import '../DTO/DadosTokenJWTDTO.dart';
import '../DTO/NovaSenhaDTO.dart';
import 'apiService.dart';

class LoginService {

  final Apiservice api = Apiservice();
  final TokenService tokenService = TokenService();
  
  
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: dotenv.env['GOOGLE_CLIENT_ID'],
  );

  Future<DadosTokenJWTDTO?>efetuarLogin(DadosAutenticacaoDTO dto) async{

    final response = await api.post("login", dto.toJson(),);

    if(response.statusCode == 200){

      final data = jsonDecode(response.body);
      final tokenDTO = DadosTokenJWTDTO.fromJson(data);

      print("TOKEN: ${tokenDTO.token}");

      await tokenService.salvarToken(tokenDTO.token);
      return tokenDTO;

    }else{

      print("Erro no login");
      return null;
    }

  }


  Future<DadosTokenJWTDTO?>loginGoogle() async{

    final account = await _googleSignIn.signIn();

    if(account == null){
      print ("Erro login Google");
      return null;
    }

    final auth = await account.authentication;
    final accessToken = auth.accessToken;

    print("TOKEN GOOGLE: $accessToken");

    if (accessToken == null) {
      print("Erro: accessToken null");
      return null;
    }


    final response = await api.post("login/google",
        {
          "token": accessToken,
        },
    );


    if(response.statusCode == 200){

      final data = jsonDecode(response.body);
      final tokenDTO = DadosTokenJWTDTO.fromJson(data);

      print("TOKEN: ${tokenDTO.token}");

      await tokenService.salvarToken(tokenDTO.token);
      return tokenDTO;

    }else{

      print("Erro no login");
      return null;
    }



  }

  Future<String?> esqueciSenha(EsqueciSenhaDTO dto) async {

    final response = await api.post(
      "login/esqueci-senha",
      dto.toJson(),
    );

    if (response.statusCode == 200) {
      return response.body;

    } else {

      print("Erro: ${response.body}");
      return null;
    }
  }

  Future <String?> redefinirSenha(NovaSenhaDTO dto) async{

    final response = await api.post(
      "login/redefinir-senha",
      dto.toJson(),
    );

    if (response.statusCode == 200) {
      return response.body;

    } else {

      print("Erro: ${response.body}");
      return null;
    }

  }
}