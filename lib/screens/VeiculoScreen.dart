import 'package:flutter/material.dart';
import 'package:projeto_integrador/content/VeiculoContent.dart';
import '../shared/NavegationBar.dart';

class VeiculoScreen extends StatefulWidget {
  const VeiculoScreen({super.key});

  @override
  State<VeiculoScreen> createState() => _VeiculoScreenState();
}

class _VeiculoScreenState extends State<VeiculoScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    Veiculocontent(),
    Center(child: Text("Tela Carteira")),
    Center(child: Text("Tela Histórico")),
  ];


  @override
  Widget build(BuildContext context) {
    return NavigationBarWidget(
      nomeUsuario: "Eduardo",
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
