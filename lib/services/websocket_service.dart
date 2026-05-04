import 'package:projeto_integrador/services/apiService.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';

/**
 * conexão websocket com o backend -> preciso de dados em tempo real
 * observer no backend
 */
class WebSocketService {

  static final WebSocketService _instance = WebSocketService._internal();

  factory WebSocketService() => _instance;

  WebSocketService._internal();

  StompClient? stompClientUsuario;
  StompClient? stompClientCarregador;


  void conectar({
    required String userId,
    required Function(String) onMensagem,
  }) {

    if (stompClientUsuario != null && stompClientUsuario!.connected) {
      print("WS usuário já conectado");
      return;
    }

    stompClientUsuario = StompClient(
      config: StompConfig.SockJS(
        url: "${Apiservice.urlBase}/ws",

        onConnect: (frame) {
          print("Conectado WS USUÁRIO");

          stompClientUsuario!.subscribe(
            destination: '/topic/usuario/$userId',
            callback: (frame) {
              if (frame.body != null) {
                onMensagem(frame.body!);
              }
            },
          );

          stompClientUsuario!.subscribe(
            destination: '/topic/usuario/saldo/$userId',
            callback: (frame) {
              print("SALDO RECEBIDO: ${frame.body}");

              if (frame.body != null) {
                onMensagem(frame.body!);
              }
            },
          );
        },

        onWebSocketError: (error) {
          print("Erro WS usuário: $error");
        },
      ),
    );

    stompClientUsuario!.activate();
  }

  //atualizar os conectores do carregador
  void conectarCarregador({
    required String idCarregador,
    required Function(String) onMensagem,
  }) {

    if (stompClientCarregador != null && stompClientCarregador!.connected) {
      print("WS carregador já conectado");
      return;
    }

    stompClientCarregador = StompClient(
      config: StompConfig.SockJS(
        url: "${Apiservice.urlBase}/ws",

        onConnect: (frame) {
          print("Conectado WS CARREGADOR");

          stompClientCarregador!.subscribe(
            destination: '/topic/carregador/$idCarregador',
            callback: (frame) {
              if (frame.body != null) {
                onMensagem(frame.body!);
              }
            },
          );
        },

        onWebSocketError: (error) {
          print("Erro WS carregador: $error");
        },
      ),
    );

    stompClientCarregador!.activate();
  }

  //atualizar os carregadores
  void conectarTodosCarregadores({
    required Function(String) onMensagem,
  }) {

    if (stompClientCarregador != null && stompClientCarregador!.connected) {
      print("WS carregadores já conectado");
      return;
    }

    stompClientCarregador = StompClient(
      config: StompConfig.SockJS(
        url: "${Apiservice.urlBase}/ws",

        onConnect: (frame) {
          print("Conectado WS CARREGADORES");

          stompClientCarregador!.subscribe(
            destination: '/topic/carregadores',
            callback: (frame) {
              if (frame.body != null) {
                onMensagem(frame.body!);
              }
            },
          );
        },

        onWebSocketError: (error) {
          print("Erro WS carregadores: $error");
        },
      ),
    );

    stompClientCarregador!.activate();
  }

  void desconectar() {
    stompClientUsuario?.deactivate();
    stompClientCarregador?.deactivate();
  }
}