import 'package:projeto_integrador/services/apiService.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';

class WebSocketService {

  static final WebSocketService _instance = WebSocketService._internal();

  //singleton
  factory WebSocketService() => _instance;

  WebSocketService._internal();

  StompClient? stompClient;
  bool _isConnected = false;


  //criar conexao
  void _connect(void Function() onConnected) {

    //se tem cliente e se ta conectado -> não cria outra conexão
    if (stompClient != null && _isConnected) {
      onConnected();
      return;
    }

    //criando conexao
    stompClient = StompClient(
      config: StompConfig.SockJS(
        url: "${Apiservice.urlBase}/ws",

        onConnect: (frame) {
          print("WS conectado");
          _isConnected = true;

          //inscrições
          onConnected();

        },

        onWebSocketError: (error) {
          print("Erro WS: $error");
          _isConnected = false;
        },

        onDisconnect: (frame) {
          print("WS desconectado");
          _isConnected = false;
        },
      ),
    );

    stompClient!.activate();
  }

  /*
   escuta atualizações do usuário
   uso para saldo e atualização da recarga
   */
  void wbUsuario({
    required String userId,
    required Function(String) onMensagem,
  }) {
    _connect(() {
      print("[USUÁRIO WS]");

      stompClient!.subscribe(
        destination: '/topic/usuario/$userId',
        callback: (frame) {
          if (frame.body != null) {
            onMensagem(frame.body!);
          }
        },
      );

      stompClient!.subscribe(
        destination: '/topic/usuario/saldo/$userId',
        callback: (frame) {
          print("SALDO: ${frame.body}");
          if (frame.body != null) {
            onMensagem(frame.body!);
          }
        },
      );
    });
  }


  /*
  inscrito no topico dos carregadores -> atualização deles
  disponivel/indisponivel
   */
  void wbCarregadores({
    required Function(String) onMensagem,
  }) {
    _connect(() {
      print("[CARREGADORES WS]");

      stompClient!.subscribe(
        destination: '/topic/carregadores',
        callback: (frame) {
          if (frame.body != null) {
            onMensagem(frame.body!);
          }
        },
      );
    });
  }


  /*
  inscrito no topico do /carregador/{idCarregador} -> atualização dos conectores dos carregadores
   */
  void wbConectores({
    required String idCarregador,
    required Function(String) onMensagem,
  }) {
    _connect(() {
      print("[CONECTORES WS]");

      stompClient!.subscribe(
        destination: '/topic/carregador/$idCarregador',
        callback: (frame) {
          if (frame.body != null) {
            onMensagem(frame.body!);
          }
        },
      );
    });
  }


  void desconectar() {
    stompClient?.deactivate();
    stompClient = null;
    _isConnected = false;
  }
}