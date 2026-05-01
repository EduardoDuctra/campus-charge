import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:projeto_integrador/services/tokenService.dart';
import 'package:http_parser/http_parser.dart';

class Apiservice {
  
  // static const String urlBase = "http://localhost:8080/projeto-integrador";
  static String get urlBase => dotenv.env['URL_BASE']!;
  static String get wsBase  => dotenv.env['WS_URL']!;

  final TokenService tokenService = TokenService();



  Future<http.Response> get(String endpoint) async{

    final token = await tokenService.recuperarToken();

    final url = Uri.parse("$urlBase/$endpoint");
    return await http.get(url,
      headers: {
        "Content-Type": "application/json",
        if(token != null) "Authorization": "Bearer $token"

      },
    );

  }


  Future<http.Response> post(String endpoint, Map dados) async{

    final token = await tokenService.recuperarToken();

    final url = Uri.parse("$urlBase/$endpoint");
    return await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        if(token != null) "Authorization": "Bearer $token",
      },
      body: jsonEncode(dados),
    );
  }


  Future<http.Response> put(String endpoint, Map dados) async {
    final token = await tokenService.recuperarToken();

    final url = Uri.parse("$urlBase/$endpoint");

    return await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
      body: jsonEncode(dados),
    );
  }

  //enviar foto
  Future<String?> uploadFoto(XFile imagem) async {
    try {

      final uri = Uri.parse("$urlBase/usuario/logado/foto",);


      final request = http.MultipartRequest('POST', uri);


      final token = await TokenService().recuperarToken();

      if (token != null) {

        request.headers['Authorization'] = "Bearer $token";
      } else {

        print("ERRO: Token está NULL");

      }


      final bytes = await imagem.readAsBytes();
      print("Nome imagem: ${imagem.name}");
      print("Tamanho bytes: ${bytes.length}");

      request.files.add(
        http.MultipartFile.fromBytes(
          'foto',
          bytes,
          filename: imagem.name,
          contentType: MediaType('image', 'png'),
        ),
      );


      final response = await request.send();


      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        print("Upload OK!");
        return responseBody;
      }

      print("Upload falhou!");
      return null;

    } catch (e) {
      print("EXCEPTION: $e");
      return null;
    }
  }
}