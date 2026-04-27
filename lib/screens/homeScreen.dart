import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/content/historicoTransacoesContent.dart';

import '../DTO/UsuarioDTO.dart';
import '../content/historicoRecargasContent.dart';
import '../content/homeContent.dart';
import '../services/usuarioService.dart';
import '../shared/navegationBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int currentIndex = 0;

  UsuarioDTO? usuario;


  @override
  Widget build(BuildContext context) {

    if (usuario == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final List<Widget> pages = [
      Homecontent(usuario: usuario!),
      HistoricoTransacoesContent(usuario: usuario!),
      HistoricoRecargasContent(usuario: usuario!),
    ];


    return NavigationBarWidget(
      usuario: usuario!,
      currentIndex: currentIndex,

      onItemSelecionado: (index) {
        setState(() {
          currentIndex = index;
        });
      },

      child: pages[currentIndex],
    );
  }

  @override
  void initState() {
    super.initState();
    carregarUsuario();
  }

  Future<void> carregarUsuario() async {
    final user = await Usuarioservice().buscarUsuarioLogado();

    setState(() {
      usuario = user;
    });
  }
}