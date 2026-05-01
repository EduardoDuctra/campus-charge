import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/UsuarioDTO.dart';
import 'package:projeto_integrador/theme/colors.dart';

import '../screens/cadastroUsuarioScreen.dart';

class NavigationBarWidget extends StatefulWidget {
  final int currentIndex;
  final Widget child;
  final Function(int) onItemSelecionado;

  final UsuarioDTO usuario;

  const NavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.child,
    required this.onItemSelecionado,
    required this.usuario,
  });

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: KeyedSubtree(
        key: ValueKey(widget.usuario.saldo),
        child: widget.child,
      ),

      //menu lateral
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,

          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              accountName: Text("Olá ${widget.usuario.nome}"),
                accountEmail: null,
              currentAccountPicture: CircleAvatar(

              backgroundImage:
                NetworkImage(widget.usuario.fotoUrl !=null && widget.usuario.fotoUrl!.isNotEmpty ?
                widget.usuario.fotoUrl! : "https://via.placeholder.com/150"),
              ),

            ),


            ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: Text("Meus dados", style: TextStyle(color: Colors.white)),
              onTap: () async {

                final usuarioAtualizado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CadastroUsuarioScreen(
                      usuario: widget.usuario,),
                  ),
                );

                if(usuarioAtualizado !=null){
                  setState(() {
                    widget.usuario.nome = usuarioAtualizado.nome;
                  });
                }

              },
            ),

            ListTile(
              leading: Icon(Icons.directions_car, color: Colors.white),
              title: Text("Meu veículo", style: TextStyle(color: Colors.white)),
            ),


            ListTile(
              leading: Icon(Icons.lock, color: Colors.white),
              title: Text("Alterar senha", style: TextStyle(color: Colors.white)),
            ),


            ListTile(
              leading: Icon(Icons.phone, color: Colors.white),
              title: Text("Suporte", style: TextStyle(color: Colors.white)),
            ),

            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text("Sair", style: TextStyle(color: Colors.white)),
            ),

          ],
        ),
      ),

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.black,

          //cor dos texto
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            return TextStyle(
              color: states.contains(WidgetState.selected)
                  ?  AppColors.principal
                  : Colors.white,
              fontSize: 12,
            );
          }),

          //cor itens
          iconTheme: WidgetStateProperty.resolveWith((states) {
            return IconThemeData(
              color: states.contains(WidgetState.selected)
                  ? AppColors.principal
                  : Colors.white,
            );
          }),

          indicatorColor: Colors.black,
        ),


        child: NavigationBar(
          selectedIndex: widget.currentIndex,
          onDestinationSelected: widget.onItemSelecionado,
          destinations: const [

            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: "Home",
            ),

            NavigationDestination(
              icon: Icon(Icons.wallet_outlined),
              selectedIcon: Icon(Icons.wallet),
              label: "Carteira",

            ),
            NavigationDestination(
              icon: Icon(Icons.history_outlined),
              selectedIcon: Icon(Icons.history),
              label: "Histórico",
            ),
          ],
        ),
      ),
    );
  }
}