import 'package:flutter/cupertino.dart';

import '../DTO/TransacaoAtivaDTO.dart';
import '../DTO/UsuarioDTO.dart';
import '../content/carregandoContent.dart';
import '../content/historicoRecargasContent.dart';
import '../content/historicoTransacoesContent.dart';
import '../content/homeContent.dart';
import '../shared/navegationBar.dart';

class CarregandoScreen extends StatefulWidget {
  final UsuarioDTO usuario;
  final TransacaoAtivaDTO transacaoAtiva;


  const CarregandoScreen({super.key,
    required this.usuario,
    required this.transacaoAtiva});

  @override
  State<CarregandoScreen> createState() => _CarregandoScreenState();
}

class _CarregandoScreenState extends State<CarregandoScreen> {


  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {

    Widget getPage() {
      switch (currentIndex) {
        case 0:
          return Carregandocontent(
            usuario: widget.usuario,
            transacaoAtiva: widget.transacaoAtiva,
          );

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
        setState(() {
          currentIndex = index;
        });
      },

      child: getPage(),
    );
  }
}
