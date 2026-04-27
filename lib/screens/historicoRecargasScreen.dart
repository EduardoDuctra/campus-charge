import 'package:flutter/cupertino.dart';

import '../DTO/UsuarioDTO.dart';
import '../content/historicoRecargasContent.dart';
import '../content/historicoTransacoesContent.dart';

class HistoricoRecargasScreen extends StatefulWidget {
  final UsuarioDTO usuario;


  const HistoricoRecargasScreen({super.key, required this.usuario});

  @override
  State<HistoricoRecargasScreen> createState() => _HistoricoRecargasScreenState();
}

class _HistoricoRecargasScreenState extends State<HistoricoRecargasScreen> {

  int currentIndex = 2;




  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      HistoricoTransacoesContent(usuario: widget.usuario),
      HistoricoTransacoesContent(usuario: widget.usuario),
      HistoricoRecargasContent(usuario: widget.usuario),
    ];

    return const Placeholder();
  }
}
