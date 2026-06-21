import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/UsuarioDTO.dart';
import 'package:projeto_integrador/screens/atualizarSenhaScreen.dart';
import 'package:projeto_integrador/screens/cadastrarVeiculoScreen.dart';
import 'package:projeto_integrador/screens/carregadorTravadoScreen.dart';
import 'package:projeto_integrador/screens/listarVeiculoScreen.dart';
import 'package:projeto_integrador/theme/colors.dart';

import '../screens/cadastroUsuarioScreen.dart';
import 'appDrawer.dart';

class NavigationBarWidget extends StatefulWidget {
  final int currentIndex;
  final Widget child;
  final Function(int) onItemSelecionado;
  final Future<void> Function() onAtualizarUsuario;



  final UsuarioDTO usuario;

  const NavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.child,
    required this.onItemSelecionado,
    required this.usuario,
    required this.onAtualizarUsuario,
  });

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: AppDrawer(
        usuario: widget.usuario,
        onAtualizarUsuario: widget.onAtualizarUsuario,
      ),

      body: KeyedSubtree(
        key: ValueKey(widget.usuario.saldo),
        child: widget.child,
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

            NavigationDestination(
              icon: Icon(Icons.qr_code_2_outlined),
              selectedIcon: Icon(Icons.qr_code_2_outlined),
              label: "Ler QR Code",
            ),

          ],
        ),
      ),
    );
  }
}