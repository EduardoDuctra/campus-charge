import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projeto_integrador/screens/loginScreen.dart';
import 'package:projeto_integrador/services/websocket_service.dart';

import '../DTO/UsuarioDTO.dart';
import '../screens/atualizarSenhaScreen.dart';
import '../screens/cadastroUsuarioScreen.dart';
import '../screens/carregadorTravadoScreen.dart';
import '../screens/listarVeiculoScreen.dart';
import '../services/tokenService.dart';

class AppDrawer extends StatelessWidget {

  final UsuarioDTO usuario;
  final Future<void> Function() onAtualizarUsuario;


  const AppDrawer({
    super.key,
    required this.usuario,
    required this.onAtualizarUsuario,
  });

  @override
  Widget build(BuildContext context) {

    return Drawer(

      backgroundColor: Colors.black,

      child: ListView(
        padding: EdgeInsets.zero,

        children: [

          UserAccountsDrawerHeader(

            decoration:
            BoxDecoration(color: Colors.black),

            accountName:
            Text("Olá ${usuario.nome}"),

            accountEmail: null,

            currentAccountPicture:
            CircleAvatar(

              backgroundImage: NetworkImage(

                usuario.fotoUrl != null &&
                    usuario.fotoUrl!.isNotEmpty

                    ? usuario.fotoUrl!

                    : "https://via.placeholder.com/150",
              ),
            ),
          ),

          ListTile(

            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),

            title: Text(
              "Meus dados",
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            onTap: () async {

              Navigator.pop(context);

              final atualizou = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CadastroUsuarioScreen(
                        usuario: usuario,
                      ),
                ),
              );

              print("ATUALIZOU: $atualizou");

              if (atualizou == true) {
                await onAtualizarUsuario();
              }


            },
          ),

          ListTile(

            leading: Icon(
              Icons.directions_car,
              color: Colors.white,
            ),

            title: Text(
              "Meu veículo",
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            onTap: () async {

              Navigator.pop(context);

              await Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) =>
                      ListarVeiculoScreen(
                        usuario: usuario,
                      ),
                ),
              );
            },
          ),

          ListTile(

            leading: Icon(
              Icons.lock,
              color: Colors.white,
            ),

            title: Text(
              "Conector travado",
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            onTap: () async {

              Navigator.pop(context);

              await Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) =>
                      CarregadorTravadoScreen(
                        usuario: usuario,
                      ),
                ),
              );
            },
          ),

          ListTile(

            leading: Icon(
              Icons.lock,
              color: Colors.white,
            ),

            title: Text(
              "Alterar senha",
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            onTap: () async {

              Navigator.pop(context);

              await Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) =>
                      AtualizarSenhaScreen(
                        usuario: usuario,
                      ),
                ),
              );
            },
          ),

          ListTile(

            leading: Icon(
              Icons.logout,
              color: Colors.white,
            ),

            title: Text(
              "Sair",
              style: TextStyle(
                color: Colors.white,
              ),
            ),

            onTap: () async {

              final navigator = Navigator.of(context);

              final TokenService tokenService = TokenService();
              final WebSocketService wsService = WebSocketService();
              final GoogleSignIn googleSignIn = GoogleSignIn();


              wsService.desconectar();

              await tokenService.removerToken();
              await googleSignIn.signOut();

              print("Logout com sucesso");
              print(await tokenService.recuperarToken());

              navigator.pushAndRemoveUntil(

                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),

                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}