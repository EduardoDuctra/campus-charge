import 'package:flutter/cupertino.dart';

import '../content/ConectoresContent.dart';
import '../content/HistoricoRecargasContent.dart';
import '../content/HistoricoTransacoesContent.dart';
import '../shared/NavegationBar.dart';

class Conectoresscreen extends StatefulWidget {
  const Conectoresscreen({super.key});

  @override
  State<Conectoresscreen> createState() => _ConectoresscreenState();
}

class _ConectoresscreenState extends State<Conectoresscreen> {

  int currentIndex = 0;

  final List<Widget> pages = [
    Conectorescontent(),
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
