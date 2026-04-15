import 'package:flutter/cupertino.dart';
import 'package:projeto_integrador/content/historicoTransacoesContent.dart';

import '../content/historicoRecargasContent.dart';
import '../content/homeContent.dart';
import '../shared/navegationBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int currentIndex = 0;

  final List<Widget> pages = [
    Homecontent(),
    HistoricoTransacoesContent(),
    HistoricoRecargasContent(),
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