import 'package:flutter/cupertino.dart';

import '../content/HomeContent.dart';
import '../shared/NavegationBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int currentIndex = 0;

  final List<Widget> pages = [
    Homecontent(),
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