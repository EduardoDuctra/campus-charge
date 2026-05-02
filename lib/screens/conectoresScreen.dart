import 'package:flutter/cupertino.dart';

import '../DTO/TransacaoAtivaDTO.dart';
import '../DTO/UsuarioDTO.dart';
import '../content/carregandoContent.dart';
import '../content/conectoresContent.dart';
import '../content/historicoRecargasContent.dart';
import '../content/historicoTransacoesContent.dart';
import '../content/homeContent.dart';
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

    Widget getPage() {
      switch (currentIndex) {
        case 0:
          return Conectorescontent(usuario: widget.usuario);
        case 1:
          return HistoricoTransacoesContent(usuario: widget.usuario);
        case 2:
          return HistoricoRecargasContent(usuario: widget.usuario);
        default:
          return Homecontent(usuario: widget.usuario);
      }
    }

    return NavigationBarWidget(
      usuario: widget.usuario,
      currentIndex: currentIndex,

      onItemSelecionado: (index) {

        if (index == 0) {
          Navigator.pop(context);
        } else {
          setState(() {
            currentIndex = index;
          });
        }
      },

      child: getPage(),
    );
  }
}
