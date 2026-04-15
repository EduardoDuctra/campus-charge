import 'package:flutter/cupertino.dart';

import '../content/conectoresContent.dart';
import '../content/historicoRecargasContent.dart';
import '../content/historicoTransacoesContent.dart';
import '../shared/navegationBar.dart';

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
