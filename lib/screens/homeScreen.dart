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

    Widget getPage() {
      switch (currentIndex) {
        case 0:
          return Homecontent(usuario: usuario!);
        case 1:
          return HistoricoTransacoesContent(usuario: usuario!);
        case 2:
          return HistoricoRecargasContent(usuario: usuario!);
        default:
          return Homecontent(usuario: usuario!);
      }
    }


    return NavigationBarWidget(
      usuario: usuario!,
      currentIndex: currentIndex,

      onItemSelecionado: (index) {
        setState(() {
          currentIndex = index;
        });
      },

        child: getPage(),
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

          print("SALDO NOVO: ${usuarioAtualizado?.saldo}");
          print("SALDO ANTIGO: ${usuario?.saldo}");

          setState(() {
            usuario = usuarioAtualizado;
          });
        },
      );
    }
  }
}