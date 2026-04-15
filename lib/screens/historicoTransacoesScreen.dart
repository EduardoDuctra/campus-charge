import 'package:flutter/cupertino.dart';

import '../content/historicoRecargasContent.dart';
import '../content/historicoTransacoesContent.dart';
import '../shared/navegationBar.dart';

class HistoricoTransacoesScreen extends StatefulWidget {
  const HistoricoTransacoesScreen({super.key});

  @override
  State<HistoricoTransacoesScreen> createState() => _HistoricoTransacoesScreenState();
}

class _HistoricoTransacoesScreenState extends State<HistoricoTransacoesScreen> {

  int currentIndex = 1;

  final List<Widget> pages = [
    HistoricoTransacoesContent(),
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
