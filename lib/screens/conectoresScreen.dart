import 'package:flutter/cupertino.dart';

import '../DTO/UsuarioDTO.dart';
import '../content/conectoresContent.dart';
import '../content/historicoRecargasContent.dart';
import '../content/historicoTransacoesContent.dart';
import '../shared/navegationBar.dart';

class Conectoresscreen extends StatefulWidget {

  final UsuarioDTO usuario;


  const Conectoresscreen({super.key, required this.usuario});

  @override
  State<Conectoresscreen> createState() => _ConectoresscreenState();
}

class _ConectoresscreenState extends State<Conectoresscreen> {

  int currentIndex = 0;




  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      Conectorescontent(usuario: widget.usuario),
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
