import 'package:flutter/material.dart';

import '../DTO/UsuarioDTO.dart';
import '../screens/atualizarSenhaScreen.dart';
import '../screens/cadastroUsuarioScreen.dart';
import '../screens/carregadorTravadoScreen.dart';
import '../screens/listarVeiculoScreen.dart';

class AppDrawer extends StatelessWidget {

  final UsuarioDTO usuario;

  const AppDrawer({
    super.key,
    required this.usuario,
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

              await Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) =>
                      CadastroUsuarioScreen(
                        usuario: usuario,
                      ),
                ),
              );
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
          ),
        ],
      ),
    );
  }
}