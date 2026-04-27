import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService{

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> salvarToken(String token) async{

    print("Token salvo SecureStorage");

    await _storage.write(key: "jwt", value: token);
  }
  
  Future<String?> recuperarToken() async{
    return _storage.read(key: "jwt");
  }

  Future<void> removerToken() async {
    await _storage.delete(key: 'jwt');
  }

  
}