import 'package:flutter/cupertino.dart';

import '../DTO/UsuarioDTO.dart';
import '../content/historicoRecargasContent.dart';
import '../content/historicoTransacoesContent.dart';
import '../content/homeContent.dart';
import '../shared/navegationBar.dart';

class HistoricoTransacoesScreen extends StatefulWidget {
  final UsuarioDTO usuario;

  const HistoricoTransacoesScreen({super.key, required this.usuario});

  @override
  State<HistoricoTransacoesScreen> createState() => _HistoricoTransacoesScreenState();
}

class _HistoricoTransacoesScreenState extends State<HistoricoTransacoesScreen> {

  int currentIndex = 1;



  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      Homecontent(usuario: widget.usuario),
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
