import 'package:flutter/cupertino.dart';

import '../content/CarregandoContent.dart';
import '../content/HistoricoRecargasContent.dart';
import '../content/HistoricoTransacoesContent.dart';
import '../shared/NavegationBar.dart';

class CarregandoScreen extends StatefulWidget {
  const CarregandoScreen({super.key});

  @override
  State<CarregandoScreen> createState() => _CarregandoScreenState();
}

class _CarregandoScreenState extends State<CarregandoScreen> {


  int currentIndex = 0;

  final List<Widget> pages = [
    Carregandocontent(),
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
