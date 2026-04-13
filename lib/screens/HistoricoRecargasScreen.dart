import 'package:flutter/cupertino.dart';

import '../content/HistoricoRecargasContent.dart';
import '../content/HistoricoTransacoesContent.dart';

class HistoricoRecargasScreen extends StatefulWidget {
  const HistoricoRecargasScreen({super.key});

  @override
  State<HistoricoRecargasScreen> createState() => _HistoricoRecargasScreenState();
}

class _HistoricoRecargasScreenState extends State<HistoricoRecargasScreen> {

  int currentIndex = 2;

  final List<Widget> pages = [
    HistoricoTransacoesContent(),
    HistoricoTransacoesContent(),
    HistoricoRecargasContent(),
  ];


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
