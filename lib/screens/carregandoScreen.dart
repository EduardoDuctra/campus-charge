import 'package:flutter/cupertino.dart';

import '../DTO/UsuarioDTO.dart';
import '../content/carregandoContent.dart';
import '../content/historicoRecargasContent.dart';
import '../content/historicoTransacoesContent.dart';
import '../shared/navegationBar.dart';

class CarregandoScreen extends StatefulWidget {
  final UsuarioDTO usuario;

  const CarregandoScreen({super.key, required this.usuario});

  @override
  State<CarregandoScreen> createState() => _CarregandoScreenState();
}

class _CarregandoScreenState extends State<CarregandoScreen> {


  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      Carregandocontent(usuario: widget.usuario),
      HistoricoTransacoesContent(usuario: widget.usuario),
      HistoricoRecargasContent(usuario: widget.usuario),
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
