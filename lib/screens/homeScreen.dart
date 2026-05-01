import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/DTO/TransacaoAtivaDTO.dart';
import 'package:projeto_integrador/services/transacaoService.dart';

import '../DTO/UsuarioDTO.dart';
import '../content/carregandoContent.dart';
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
  final TransacaoService transacaoService = TransacaoService();
  final Usuarioservice usuarioservice = Usuarioservice();

  TransacaoAtivaDTO?transacaoAtiva;


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
          if (transacaoAtiva != null) {
            return Carregandocontent(
              usuario: usuario!,
              transacaoAtiva: transacaoAtiva!,
            );
          } else {
            return Homecontent(usuario: usuario!);
          }
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
    carregarTransacaoAtiva();
  }

  //desconectar ws
  @override
  void dispose() {
    webSocketService.desconectar();
    super.dispose();
  }

  //busca usuario e atualiza WS sempre que tem mudança
  Future<void> carregarUsuario() async {
    final user = await usuarioservice.buscarUsuarioLogado();

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

          if (!mounted) return;

          final transacao =
          await transacaoService.listarTransacoesAtiva();


          if (transacaoAtiva != null && transacao == null) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }

          setState(() {
            usuario = usuarioAtualizado;
            transacaoAtiva = transacao;
          });
        },
      );
    }
  }

  Future<void>carregarTransacaoAtiva() async {

    final transacao = await transacaoService.listarTransacoesAtiva();


    setState(() {
      transacaoAtiva = transacao;
    });

  }
}