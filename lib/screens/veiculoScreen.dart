import 'package:flutter/material.dart';
import 'package:projeto_integrador/content/veiculoContent.dart';
import '../DTO/UsuarioDTO.dart';
import '../shared/navegationBar.dart';

class VeiculoScreen extends StatefulWidget {

  final UsuarioDTO usuario;

  const VeiculoScreen({super.key,
    required this.usuario});

  @override
  State<VeiculoScreen> createState() => _VeiculoScreenState();
}

class _VeiculoScreenState extends State<VeiculoScreen> {
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      Veiculocontent(usuario: widget.usuario),
      Center(child: Text("Tela Carteira")),
      Center(child: Text("Tela Histórico")),
    ];

    return NavigationBarWidget(
      usuario: widget.usuario,
      currentIndex: currentIndex,

      onItemSelecionado: (index) {
        setState(() {
          currentIndex = index;
        });
      },

      child: pages[currentIndex],
    );
  }
}
