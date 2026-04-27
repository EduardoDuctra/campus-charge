import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DTO/UsuarioDTO.dart';
import '../content/historicoRecargasContent.dart';
import '../content/historicoTransacoesContent.dart';
import '../content/homeContent.dart';
import '../services/usuarioService.dart';
import '../services/websocket_service.dart';
import '../shared/navegationBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final WebSocketService webSocketService = WebSocketService();


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

  //desconectar ws
  @override
  void dispose() {
    webSocketService.desconectar();
    super.dispose();
  }

  //busca usuario e atualiza WS sempre que tem mudança
  Future<void> carregarUsuario() async {
    final user = await Usuarioservice().buscarUsuarioLogado();

    setState(() {
      usuario = user;
    });


    if (usuario?.idUsuario != null) {
      webSocketService.conectar(
        userId: usuario!.idUsuario.toString(),
        onMensagem: (msg) async {
          print("WS HOME: $msg");


          final usuarioAtualizado =
          await Usuarioservice().buscarUsuarioLogado();

          setState(() {
            usuario = usuarioAtualizado;
          });
        },
      );
    }
  }
}