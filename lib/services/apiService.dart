import 'dart:convert';

import 'package:http/http.dart' as http;

class Apiservice {
  
  static const String urlBase = "http://localhost:8080/projeto-integrador";
  
  Future<http.Response> get(String endpoint) async{

    final url = Uri.parse("$urlBase/$endpoint");
    return await http.get(url);

  }


  Future<http.Response> post(String endpoint, Map dados) async{


    final url = Uri.parse("$urlBase/$endpoint");
    return await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(dados),
    );
  }
}