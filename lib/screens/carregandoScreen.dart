import 'package:flutter/cupertino.dart';

import '../content/carregandoContent.dart';
import '../content/historicoRecargasContent.dart';
import '../content/historicoTransacoesContent.dart';
import '../shared/navegationBar.dart';

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
