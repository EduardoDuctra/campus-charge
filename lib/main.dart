import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projeto_integrador/screens/lerQRCodeScreen.dart';
import 'package:projeto_integrador/shared/cardVeiculo.dart';

import 'DTO/UsuarioDTO.dart';
import 'app.widget.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}



/**
 * teste camera
 */
// Future<void> main() async {
//
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await dotenv.load(fileName: ".env");
//
//   final usuario = UsuarioDTO();
//
//   usuario.idUsuario = 1;
//   usuario.nome = "Teste";
//   usuario.email = "teste@email.com";
//
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//
//       home: LerQRCodeScreen(
//         usuario: usuario,
//       ),
//     ),
//   );
// }
